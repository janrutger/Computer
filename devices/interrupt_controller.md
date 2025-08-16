# Interrupt Controller

The `InterruptController` class is responsible for managing and queuing interrupt requests from peripheral devices to the CPU in the Stern-XT simulation. It ensures that no interrupt requests are lost, even during rapid-fire events.

## Class: `InterruptController`

### Initialization

```python
__init__(self, memory)
```

-   **`memory`**: An instance of the system's memory, used for writing interrupt-related data.

Upon initialization, the controller sets up a thread-safe queue (`pending_interrupts`) to hold incoming interrupt requests (vector and optional data). It also maintains a mapping (`vector_data_addresses`) for interrupt vectors to specific memory locations where their associated data should be written. A `master_enabled` flag controls whether interrupts are processed.

### Methods

#### `register_data_address(self, vector, address)`

Registers a specific memory `address` where data associated with an `interrupt vector` should be written when that interrupt is acknowledged and handled.

-   **`vector`**: The unique identifier for the interrupt.
-   **`address`**: The memory address where the interrupt's data will be stored.

#### `trigger(self, vector, data=None)`

Called by a peripheral device to signal an interrupt. If the `master_enabled` flag is `True`, the interrupt `vector` and its optional `data` are added to the `pending_interrupts` queue.

-   **`vector`**: The unique identifier for the interrupt.
-   **`data`**: (Optional) Any data associated with the interrupt (e.g., keyboard scan code, SIO data).

#### `has_pending(self)`

Returns `True` if there are any interrupt requests currently waiting in the queue, and `False` otherwise. This method is typically used by the CPU to check for pending interrupts.

#### `acknowledge(self)`

Called by the CPU to retrieve the next pending interrupt from the queue. This method removes the interrupt from the queue and returns its `(vector, data)` tuple. If no interrupts are pending, it returns `(None, None)`.

#### `handle_acknowledged_interrupt(self, vector, data)`

Called by the CPU after an interrupt has been acknowledged. This method checks if the provided `vector` has a registered data address and if `data` is present. If both conditions are met, it writes the `data` to the registered memory address.

-   **`vector`**: The interrupt vector that was acknowledged.
-   **`data`**: The data associated with the acknowledged interrupt.