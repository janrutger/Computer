### Memory Map Upgrade Table (16K $\rightarrow$ 24K)

| File | Variable / Location | Old Value (16K) | New Value (24K) | Notes |
| :--- | :--- | :--- | :--- | :--- |
| **stern-ATX.py** | `MEM_SIZE` | `16384` | `24576` | Total memory size |
| | `MEM_INT_VECTORS_START` | `3072` | `8192` | Moves after expanded 8K kernel |
| | `MEM_PROG_START` | `4096` | `9216` | Moves after Interrupts/Buffer region |
| | `MEM_IO_END` | `12287` | `18431` | Top of the new I/O page |
| | `MEM_VAR_START` | `12288` | `18432` | Start of expanded Static Heap |
| | `MEM_VIDEO_START` | `14336` | `22528` | Moves to the very top of 24K |
| **udc_routines.stacks** | `$udc_channel_register` | `12248` | `18392` | Base of UDC (IO_END - 39) |
| | `$udc_status_register` | `12249` | `18393` | Base + 1 |
| | `$udc_command_register` | `12250` | `18394` | Base + 2 |
| | `$udc_data_register` | `12251` | `18395` | Base + 3 |
| | `$udc_device_type_0` | `12252` | `18396` | Base + 4 |
| | ... | ... | ... | ... |
| | `$udc_device_type_7` | `12259` | `18403` | Base + 11 |
| **rtc_routines.stacks** | `$RTC_VALUE` | `12247` | `18391` | Just below UDC Base |
| **vdisk_routines.stacks** | `$status_register` | `12272` | `18416` | Base of VDisk (IO_END - 15) |
| | `$command_register` | `12273` | `18417` | Base + 1 |
| | `$hostbuffer_adres_register`| `12274` | `18418` | Base + 2 |
| | `$filehash_register` | `12275` | `18419` | Base + 3 |
| | `$last_block_register` | `12276` | `18420` | Base + 4 |
| **parser_tools.stacks** | `bytecode_buffer` | `3584` | `8704` | `MEM_PROG_START` (9216) - 512 |
| **conway.stacks** | `current_board` | `9216` | `18432` | Moved to start of new Static Heap |
| | `next_board` | `10416` | `19632` | `current_board` + 1200 offset |
| **hardware_config.stacks** | `~SCREEN_LAST_ADRES` | `16256` | `24448` | `VIDEO_MEM` + 1920 |
| | `~INT_VECTORS` | `3072` | `8192` | Matches `MEM_INT_VECTORS_START` |
| | `~PROG_START` | `4096` | `9216` | Matches `MEM_PROG_START` |
| | `~VAR_START` | `12288` | `18432` | Matches `MEM_VAR_START` |
| | `~VIDEO_MEM` | `14336` | `22528` | Matches `MEM_VIDEO_START` |
| | `~STACK_TOP` | `14335` | `22527` | Just below `VIDEO_MEM` |
| | `VALUE INT_VECTORS` | `3072` | `8192` | Stacks variable for Interrupts |
| | `VALUE VIDEO_MEM` | `14336` | `22528` | Stacks variable for Video |
| **bootfile.stacks** | `std_heap start` | `10240` | `15360` | `MEM_VAR_START` - 3072 (Avoids I/O) |
| | `std_heap size` | `2048` | `2048` | Heap size |
| **devices/debugger.py** | `show_memory_map` | `1024 - 3071` | `1024 - 8191` | Kernel Range |
| | | `3072 - 4095` | `8192 - 9215` | Vectors Range |
| | | `4096 - 12287` | `9216 - 17407` | Program & Heap Range |
| | | `12288 - 14335` | `17408 - 22527` | I/O & Static Vars |
| | | `14336 - 16383` | `22528 - 24575` | Video & Stack |
| **devices/cpuR3.py** | `MEM_INT_VECTORS_START` | | `8192` |  |
| **devices/cpu_m1.py** | `MEM_SIZE` | | `24576` | |
|| `MEM_INT_VECTORS_START` | | `8192` | |