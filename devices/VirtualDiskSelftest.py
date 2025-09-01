from memory import Memory
from VirtualDisk import (
    VirtualDisk,
    DISK_IDLE, HOST_WAITING, DISK_SUCCESS, DISK_ERROR, FILE_ERROR, HOST_BUSY,
    CMD_INIT, CMD_OPEN_READ, CMD_OPEN_WRITE, CMD_CREATE_FILE, CMD_READ_BLOCK, CMD_WRITE_BLOCK, CMD_CLOSE
)

def main():
    # try to use Sterns memorymap
    MEM_SIZE = 16384
    memory = Memory(MEM_SIZE)
    varstart = 12288
    baseadres = varstart - 16
    Vdisk = VirtualDisk(memory, baseadres, "Vdisk0")

    # init registers
    status_register = baseadres + 0
    command_register = baseadres + 1
    hostbuffer_adres_register = baseadres + 2
    filehash_register = baseadres + 3
    last_block_register = baseadres + 4

    def test_openfile(name):
        print("test open existing file")
        Filename = name
        filename_chars = [ord(c) for c in Filename]
        filename_chars.append(0) # Add the null terminator

        file_hash = Vdisk._myhash(Filename)

        print(f"file hash is  : {file_hash}")
        print(f"name buffer is: {filename_chars}")

        memory.write(command_register, CMD_OPEN_READ)
        memory.write(filehash_register, file_hash)
        memory.write(status_register, HOST_WAITING)
        return file_hash
    
    def test_open_writefile(name):
        print("test open existing file")
        Filename = name
        filename_chars = [ord(c) for c in Filename]
        filename_chars.append(0) # Add the null terminator

        file_hash = Vdisk._myhash(Filename)

        print(f"file hash is  : {file_hash}")
        print(f"name buffer is: {filename_chars}")

        memory.write(command_register, CMD_OPEN_WRITE)
        memory.write(filehash_register, file_hash)
        memory.write(status_register, HOST_WAITING)
        return file_hash
    
    def test_read_openfile(filehash):
        print("test read existing 1-block file")
        memory.write(filehash_register, filehash)
        memory.write(hostbuffer_adres_register, varstart)
        memory.write(command_register, CMD_READ_BLOCK)
        memory.write(status_register, HOST_WAITING)

    def test_create_file():
        print("test create new file")
        Filename = "newfile"
        FileHash = Vdisk._myhash(Filename)
        filename_chars = [ord(c) for c in Filename]
        filename_chars.append(0) # Add the null terminator
        for i, char_code in enumerate(filename_chars):
            memory.write(int(memory.read(hostbuffer_adres_register)) + i, char_code)
        
        memory.write(filehash_register, FileHash)
        memory.write(command_register, CMD_CREATE_FILE)
        memory.write(status_register, HOST_WAITING)

    def test_write_block_1():
        print("testwrite to an newfile")
        block_content = "1234 5678 9" + "\r"
        block_chars = [ord(c) for c in block_content]
        for i, char_code in enumerate(block_chars):
            memory.write(int(memory.read(hostbuffer_adres_register)) + i, char_code)
        memory.write(command_register, CMD_WRITE_BLOCK)
        memory.write(status_register, HOST_WAITING)

    def test_write_block_2():
        print("testwrite to an existing file")
        memory.write(hostbuffer_adres_register, varstart)
        block_content = "ab a\r bc\r" + chr(0)        # incomplete buffer < 12, must be terminated 
        block_chars = [ord(c) for c in block_content]
        for i, char_code in enumerate(block_chars):
            memory.write(int(memory.read(hostbuffer_adres_register)) + i, char_code)
        memory.write(command_register, CMD_WRITE_BLOCK)
        memory.write(status_register, HOST_WAITING)

    def test_close_file():
        print("test close file")
        memory.write(command_register, CMD_CLOSE)
        memory.write(status_register, HOST_WAITING)

    def check_status():
            status = int(memory.read(status_register))
            while status != DISK_SUCCESS and status != DISK_ERROR and status != FILE_ERROR:
                Vdisk.access()
                print(".", end="")
                status = int(memory.read(status_register))
            print(f"\nAfter receiving {status} from disk, set status to {HOST_BUSY}")
            status = int(memory.read(status_register))
            memory.write(status_register, HOST_BUSY)

            if status == DISK_ERROR:
                print("Disk error")
                exit()
            elif status == FILE_ERROR:
                print("File error: no such file, invalid filename")
                exit()

    # the actual test script form here
    # test 1
    # lets spin the disk one time
    print("1 - Spinup the disk once")
    Vdisk.access()

    print("2 - check status and init disk")
    status = int(memory.read(status_register))
    while status != DISK_IDLE:
        Vdisk.access()
        print(".", end="")
        status = memory.read(status_register)    
    print(f"\nReceived status {status} from disk, setup CMD_INIT")

    print("Setup CMD_INIT")
    memory.write(command_register, CMD_INIT)
    Vdisk.access()

    check_status()
    print(f"filemap is : {Vdisk.file_map}")
    print("Disk succesfull initialized")

    print("3 - Open a file for reading and read from it")
    filehash = test_openfile("program")
    check_status()
    print(f"open files are : {Vdisk.open_files}")
    print("File is succesfully opened")

    test_read_openfile(filehash)
    check_status()
    print("File is succesfully read")

    print(memory.dump(varstart, varstart + 16))

    lastpart = int(memory.read(last_block_register))
    print(f"lastpart flag is {lastpart}")

    print("4 - Create a new file and write to it")
    test_create_file()
    print(memory.dump(varstart, varstart + 16))
    check_status()
    print(f"filemap is : {Vdisk.file_map}")
    print(f"open files are : {Vdisk.open_files}")
    print("File is succesfully created")

    print("Write to this new file's buffer")
    test_write_block_1()
    print(memory.dump(varstart, varstart + 16))
    check_status()
    print(f"open files are : {Vdisk.open_files}")
    print(f"filemap is : {Vdisk.file_map}")
    print("File is succesfully written to buffer")

    print("Close the written file")
    test_close_file()
    check_status()
    print(f"open files are : {Vdisk.open_files}")
    print(f"filemap is : {Vdisk.file_map}")
    print("File is succesfully written to the real file")

    print("5 - open an file for write, write multiple parts to it and close it")
    filehash = test_open_writefile("newfile")
    check_status()
    print(f"open files are : {Vdisk.open_files}")
    print(f"filemap is : {Vdisk.file_map}")
    print("File is succesfully opened")

    print("Write first block")
    test_write_block_1()
    check_status()

    print("Write second block")
    test_write_block_2()
    check_status()
    
    print(f"open files are : {Vdisk.open_files}")
    print(f"filemap is : {Vdisk.file_map}")
    print("Wrote 2 blocks to the filebuffer")

    print("Close the file")
    test_close_file()
    check_status()

    print("6 - open file and read multiple times")
    filehash = test_openfile("newfile")
    check_status()
    print(f"open files are : {Vdisk.open_files}")

    
    print("Read first block")
    test_read_openfile(filehash)
    check_status()
    print(memory.dump(varstart, varstart + 16))
    print("Last block flag: ", int(memory.read(last_block_register)))

    print("Read second block")
    test_read_openfile(filehash)
    check_status()
    print(memory.dump(varstart, varstart + 16))
    print("Last block flag: ", int(memory.read(last_block_register)))

    print("Read non existing block")
    test_read_openfile(filehash)
    check_status()
    print(memory.dump(varstart, varstart + 16))
    print("Last block flag: ", int(memory.read(last_block_register)))        

if __name__ == "__main__":
    main()
