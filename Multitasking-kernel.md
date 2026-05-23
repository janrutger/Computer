# Implementatieplan: Asynchroon I/O-systeem (Stern-ATX Kernel)

Hier is een helder en gestructureerd overzicht van alle wijzigingen en administratieve zaken die nodig zijn om het asynchrone I/O-plan waterdicht te implementeren.

## 0. Kernprincipe: Coöperatieve Multitasking
De Stern-ATX kernel werkt op basis van **coöperatieve multitasking**. Omdat de CPU geen hardwarematige interrupts gebruikt voor task-switching, moet elke VVM de controle expliciet teruggeven aan de kernel.

1.  **Time-slicing via `runbatch`**: De scheduler laat een VVM een beperkt aantal instructies uitvoeren voordat de beurt naar de volgende gaat.
2.  **Yielding bij I/O**: Door de introductie van asynchrone I/O "geeft een VVM zijn tijd op" zodra er gewacht moet worden op input. De status `VVM_WaitIO` zorgt ervoor dat de scheduler deze VVM direct overslaat, wat de algehele systeem-responsiviteit verhoogt.
3.  **Efficiency**: De kernel gebruikt de vrijgekomen cycles om de hardware te pollen (`POLLline`), waardoor multitasking soepel aanvoelt ondanks de single-threaded natuur van de host.

---

## 1. Globale Kernel-Variabelen & Constanten (Host-zijde)
Voeg deze definities toe aan de top van de kernel-code:

*   **`VVM_WaitIO`**: Definieer een nieuwe status-constante voor de VVM (bijvoorbeeld `CONST VVM_WaitIO 5`).
*   **`kbd_request_queue`**: Initialiseer bij de boot van het OS een globaal startadres voor een lege host-deque (bijvoorbeeld `VALUE kbd_request_queue 0`).
*   **`input_buffer` & `input_buffer_index`**: Zorg ervoor dat de buffer waarin `POLLline` karakters verzamelt globaal is (of zijn staat behoudt), zodat data tussen opeenvolgende kloktikken behouden blijft.

---

## 2. De Input-Stofzuiger (`POLLline`)
Bouw de bestaande `READline` om naar de non-blocking `POLLline` variant met de volgende logica:

1.  **Poortwachter invoegen**: Zet bovenaan de functie: `kbd_request_queue DEQUE.is_empty IF 0 EXIT END`.
2.  **Stofzuiger-loop**: Vervang de oude blocking `KEYchar` door een `WHILE KEYpressed DUP 0 != DO AS _char` lus.
3.  **Return-waarde**: De routine geeft `0` terug als de regel nog niet af is. Zodra de return (Enter) valt, wordt het geheugenadres (`&input_buffer`) van de string op de stack achtergelaten.

---

## 3. De Wekker-routine (`KERNEL.handle_raw_input_line`)
Schrijf deze nieuwe kernel-routine die wordt aangeroepen zodra `POLLline` een complete regel oplevert:

*   **VVM de-queuen**: Haal de langst wachtende VVM-pointer uit de verzoekrij via `kbd_request_queue DEQUE.pop_front AS _target_vvm_ptr`.
*   **Token streamen**: Loop over de binnengekomen string met `TOKENIZE` (split op spatie), bereken de `STRING.hash` van elk los token, en voeg deze toe aan de `kbd_deque` van de doel-VVM (offset 48).
*   **Status herstellen**: Schrijf de status `VVM_Sys` terug in het statusregister van de doel-VVM: `VVM_Sys VVM_status _target_vvm_ptr VVMpoke`.

---

## 4. De Syscall Poortwachter (`VVM.check_syscalls`)
Pas de afhandeling van **Syscall ID 60** (Input) aan:

*   **Peek in plaats van Pop**: Kijk naar de Syscall ID op de host-deque met `peek_tail` in plaats van hem direct te verwijderen.
*   **Scenario-check**:
    *   *Als `kbd_deque` van de VVM leeg is*: Voeg de `_VVMpointer` toe aan de `kbd_request_queue` (via `append_unique`), zet de status van de VVM op `VVM_WaitIO`, en doe een `EXIT`. De Syscall ID blijft op de deque staan.
    *   *Als `kbd_deque` gevuld is*: Pop de Syscall ID nu definitief, voer de originele handler uit (verhuist token) en zet de VVM-status op `VVM_Idle`.

---

## 5. De Hoofd-Scheduler Loop (`KERNEL.main_os_loop`)
Optimaliseer de volgorde in de hoofd-lus voor maximale performance:

*   **Stap 1 (Kernel-taken)**: Roep direct `POLLline` aan. De kernel gebruikt dit moment (tussen de VVM-beurten door) om de hardware-input te verwerken. Is het resultaat niet `0`? Stuur het naar `KERNEL.handle_raw_input_line`.
*   **Stap 2 (VVM-beurten)**: In de `WHILE _id total_vvms < DO` loop bepaalt de status of een VVM mag draaien:
    *   `VVM.runbatch`: Alleen draaien als status `VVM_Running` of `VVM_Idle` is.
    *   `VVM.check_syscalls`: Alleen draaien als status exact `VVM_Sys` is (meestal direct na een batch of I/O request).
    *   *VVM_WaitIO*: De scheduler flitst hier automatisch voorbij zonder CPU-cycles te verbruiken.

---

## 6. CLI Bootstrap (De 'Aan'-knop)

*   **Altijd Luisteren**: Zorg dat de RPN-CLI (bijv. VVM2) bij boot direct een `SYS 60` call doet. Hierdoor nestelt de CLI zich in de `kbd_request_queue`.
*   **Loop herhalen**: De CLI moet na elk uitgevoerd commando direct opnieuw `SYS 60` aanroepen om weer beschikbaar te zijn voor nieuwe invoer.