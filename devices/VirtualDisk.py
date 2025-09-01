import os

DISK_IDLE       = 0     # Disk is turnd on, waiting for init
HOST_WAITING    = 1     # Host is waiting for disk to complete command
DISK_SUCCESS    = 2     # Read/Write successful
DISK_ERROR      = 3     # Read/Write failed
FILE_ERROR      = 4     # File specific error, disk remains ready
HOST_BUSY       = 5     # Host is busy processing disk response

CMD_INIT        = 0     # Initialize disk
CMD_OPEN_READ   = 1     # Open file for reading
CMD_OPEN_WRITE  = 2     # Open file for writing
CMD_CREATE_FILE = 3     # Create new file
CMD_READ_BLOCK  = 4     # Read
CMD_WRITE_BLOCK = 5     # Write
CMD_CLOSE       = 6     # Close file

PENDING_BLOCK   = 0
LAST_BLOCK      = 1

MODULUS         = 10**12  # 1 followed by 12 zeros


class VirtualDisk:
    def __init__(self, memory, baseadres, real_directory, buffSize=12):
        self.bufferSize = buffSize
        self.memory = memory
        self.real_directory = real_directory

        self.file_map = {}
        self.open_files = {}

        self.status_register            = baseadres + 0
        self.command_register           = baseadres + 1
        self.hostbuffer_adres_register  = baseadres + 2
        self.filehash_register          = baseadres + 3
        self.last_block_register        = baseadres + 4

        self.memory.write(self.status_register, DISK_IDLE)
        self.memory.write(self.command_register, -1)
        self.memory.write(self.hostbuffer_adres_register, -1)
        self.memory.write(self.filehash_register, -1)
        self.memory.write(self.last_block_register, -1)


    def _myhash(self, string):
        hash_value = 0
        for char in string:
            hash_value = (hash_value * 31 + ord(char)) % MODULUS
        return hash_value

    def _build_file_map(self):
        self.file_map = {}
        for filename in os.listdir(self.real_directory):
            if filename.endswith(".txt"):
                file_path = os.path.join(self.real_directory, filename)
                if os.path.isfile(file_path):
                    basename = os.path.splitext(filename)[0]
                    file_hash = self._myhash(basename)
                    self.file_map[file_hash] = {
                        'real_basename': filename,
                        'path': file_path
                    }

    def access(self):
        # Check what to do in this cycle
        # read the input registers
        status   = int(self.memory.read(self.status_register))
        command  = int(self.memory.read(self.command_register))


        if status == DISK_IDLE and command != CMD_INIT:
            self.memory.write(self.status_register, DISK_IDLE)
            return              # Waiting for INIT command from host
        elif status == DISK_IDLE and command == CMD_INIT:
            self._init_disk()
            return
        elif status == FILE_ERROR:  # File error, disk remains ready
            return
        elif status == DISK_SUCCESS: # Disk has completed a command, waiting for host to set to HOST_BUSY or HOST_WAITING
            return
        elif status == HOST_BUSY: # Host is busy processing, disk waits
            return
        elif status == HOST_WAITING:
            if command == CMD_OPEN_READ:
                self._open_read()
            elif command == CMD_OPEN_WRITE:
                self._open_write()
            elif command == CMD_CREATE_FILE:
                self._create_file()
            elif command == CMD_READ_BLOCK:
                self._read_block()
            elif command == CMD_WRITE_BLOCK:
                self._write_block()
            elif command == CMD_CLOSE:
                self._close_file()
            elif command == CMD_INIT:       # re-init the disk after diskchange
                self._init_disk()
            else:       # its an invalid Disk Command
                self.memory.write(self.status_register, DISK_ERROR)
        
        else:           # when every thing goes wrong, disk will go back to the IDLE state
            self.memory.write(self.status_register, DISK_IDLE)
            print("Disk Error, disk is now in IDLE state")
        
    def _init_disk(self):
        # Close any currently open files and write back dirty ones
        # Iterate over a copy of keys to allow modification during iteration
        for file_hash in list(self.open_files.keys()):
            file_info = self.open_files[file_hash]
            mode = file_info['mode']
            dirty = file_info['dirty']
            path = file_info['path']
            file_buffer = file_info['buffer']

            if dirty and mode == 'w':
                file_content = file_buffer.replace('\r', '\n')
                try:
                    with open(path, 'w') as f:
                        f.write(file_content)
                except IOError:
                    # Log error, but continue to close other files
                    print(f"Error writing dirty file {path} during re-initialization.")
                    self.memory.write(self.status_register, DISK_ERROR)
                    return

            del self.open_files[file_hash] # Remove from open_files dictionary

        # Ensure open_files is completely clear (redundant but safe)
        self.open_files = {}

        self._build_file_map()
        self.memory.write(self.status_register, DISK_SUCCESS)

    def _open_read(self):
        file_hash = int(self.memory.read(self.filehash_register))
        if file_hash in self.file_map:
            file_path = self.file_map[file_hash]['path']
            try:
                with open(file_path, 'r') as f:
                    file_content = f.read()
                self.open_files[file_hash] = {'mode': 'r', 'dirty': False, 'path': file_path, 'buffer': file_content.replace('\n', '\r'), 'buffer_index': 0}
                self.memory.write(self.status_register, DISK_SUCCESS)
            except IOError:
                self.memory.write(self.status_register, DISK_ERROR)
        else:
            self.memory.write(self.status_register, FILE_ERROR)

    def _open_write(self):
        file_hash = int(self.memory.read(self.filehash_register))
        if file_hash in self.file_map:
            file_path = self.file_map[file_hash]['path']
            self.open_files[file_hash] = {'mode': 'w', 'dirty': False, 'path': file_path, 'buffer': "", 'buffer_index': 0}
            self.memory.write(self.status_register, DISK_SUCCESS)
        else:
            self.memory.write(self.status_register, FILE_ERROR)

    def _create_file(self):
        host_buffer_address = int(self.memory.read(self.hostbuffer_adres_register))
        host_hash = int(self.memory.read(self.filehash_register))

        # Read filename from host memory
        filename = []
        for i in range(12): # Max 12 characters
            char_code = int(self.memory.read(host_buffer_address + i))
            if char_code != 0:
                filename.append(chr(char_code))
            else:
                break
        filename_str = "".join(filename)

        # Verify hash
        if self._myhash(filename_str) != host_hash:
            self.memory.write(self.status_register, FILE_ERROR)
            return

        # Create the file
        new_filename = filename_str + ".txt"
        new_filepath = os.path.join(self.real_directory, new_filename)

        if os.path.exists(new_filepath):
            self.memory.write(self.status_register, FILE_ERROR)
            return

        try:
            # Create the file empty
            open(new_filepath, 'w').close()
            self.file_map[host_hash] = {
                'real_basename': new_filename,
                'path': new_filepath
            }
            self.open_files[host_hash] = {'mode': 'w', 'dirty': False, 'path': new_filepath, 'buffer': "", 'buffer_index': 0}
            self.memory.write(self.status_register, DISK_SUCCESS)
        except IOError:
            self.memory.write(self.status_register, DISK_ERROR)

    def _read_block(self):      # reading by the host
        file_hash = int(self.memory.read(self.filehash_register))

        
        if file_hash in self.open_files and self.open_files[file_hash]['mode'] == 'r':
            host_buffer_address = int(self.memory.read(self.hostbuffer_adres_register))
            
            # Read block from disk buffer
            file_buffer = self.open_files[file_hash]['buffer']
            buffer_index = self.open_files[file_hash]['buffer_index']

            if buffer_index >= len(file_buffer):
                self.memory.write(self.status_register, FILE_ERROR) # End of file reached
                return

            start = buffer_index
            end = start + self.bufferSize
            block = file_buffer[start:end]
            
            # Write block to host memory
            for i, char in enumerate(block):
                self.memory.write(host_buffer_address + i, ord(char))
            
            # Update buffer index
            self.open_files[file_hash]['buffer_index'] = end
            
            # Check if this is the last block
            if end >= len(file_buffer):
                self.memory.write(self.last_block_register, LAST_BLOCK)
            else:
                self.memory.write(self.last_block_register, PENDING_BLOCK)
                
            self.memory.write(self.status_register, DISK_SUCCESS)
        else:
            self.memory.write(self.status_register, FILE_ERROR)

    def _write_block(self):
        file_hash = int(self.memory.read(self.filehash_register))
        if file_hash in self.open_files and self.open_files[file_hash]['mode'] == 'w':
            host_buffer_address = int(self.memory.read(self.hostbuffer_adres_register))
            
            # Read block from host memory
            block = []
            for i in range(self.bufferSize):
                char_code = int(self.memory.read(host_buffer_address + i))
                if char_code != 0:
                    block.append(chr(char_code))
                else:
                    break
            block_str = "".join(block)
            
            # Write block to disk buffer
            file_buffer = self.open_files[file_hash]['buffer']
            buffer_index = self.open_files[file_hash]['buffer_index']

            start = buffer_index
            end = start + len(block_str)
            file_buffer = file_buffer[:start] + block_str + file_buffer[end:]
            self.open_files[file_hash]['buffer'] = file_buffer
            
            # Update buffer index
            self.open_files[file_hash]['buffer_index'] = end
            
            # Mark file as dirty
            self.open_files[file_hash]['dirty'] = True
            
            self.memory.write(self.status_register, DISK_SUCCESS)
        else:
            self.memory.write(self.status_register, FILE_ERROR)

    def _close_file(self):
        file_hash = int(self.memory.read(self.filehash_register))
        if file_hash in self.open_files:
            mode = self.open_files[file_hash]['mode']
            dirty = self.open_files[file_hash]['dirty']
            path = self.open_files[file_hash]['path']
            file_buffer = self.open_files[file_hash]['buffer']

            if dirty and mode == 'w':
                file_content = file_buffer.replace('\r', '\n')
                try:
                    with open(path, 'w') as f:
                        f.write(file_content)
                except IOError:
                    self.memory.write(self.status_register, DISK_ERROR)
                    return

            del self.open_files[file_hash]
            self.memory.write(self.status_register, DISK_SUCCESS)
        else:
            self.memory.write(self.status_register, FILE_ERROR)


