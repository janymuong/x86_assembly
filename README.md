# `assembly` - Hello, World

Print `Hello, World` text to **stdout** in assembly.

Compile and run the ouput files in command line - with a compatible **x86 assembler**, NASM:

`option - a`: a sequence of four ASCII-encoded strings in x86 assembly.		 
> will rely on shell command, `cat`, to print to the console.
```bash
$ nasm hello.asm
$ cat hello
Hello, World
$
```

`option - a improved`: relies on syscall - `write`
```bash
$ nasm -f elf64 -o hello_wrld.o hello_wrld.asm
$ ld -m elf_x86_64 -o hello_wrld hello_wrld.o
$ ./hello_wrld
Hello, World!
$
```

`option - b` for file `hello_other`:
```bash
$ nasm -f elf64 other_asm.asm && gcc -no-pie -std=gnu89 other_asm.o -o hello_other
$ ./hello_other
Hello, World
$
```

---
## `File` `hello_wrld.asm`: 	  
`hello_msg` string is defined in the `.data` section using the `db` directive. The `10` at the end of the string represents a `newline` character, which will cause the console to move to the next line after printing the message.

In the `.text` section, the `_start` label marks the beginning of the program. The first block of instructions prepares the arguments for the write system call:

* `mov eax, 4` sets the syscall number for write to 4.
* `mov ebx, 1` sets the file descriptor for stdout to 1.
* `mov ecx, hello_msg` loads the address of the **hello_msg** string into the `ecx` register.
* `mov edx, 14` sets the length of the message to 14, which includes the 13 characters in the message string plus the newline character.

After setting up the system call arguments, the program invokes the int `0x80` instruction to trigger the write system call and print the message to the console.

Finally, the program invokes the exit system call to terminate. The last block of instructions sets the syscall number for exit to 1, sets the exit code to 0 using `xor ebx, ebx`, and invokes the int **0x80** instruction to trigger the exit system call.

## `File` `hello.asm`:  	 
Is a sequence of four ASCII-encoded strings in x86 assembly language, defined using the db (define byte) directive. Here's what each string represents:

* `0x48,0x65,0x6c,0x6c` represents the string "Hell" in `ASCII` encoding. The hexadecimal values `0x48, 0x65, 0x6c`, and `0x6c` correspond to the ASCII codes for the characters 'H', 'e', 'l', and 'l', respectively.

* `0x6f,0x2c,0x20,0x57` represents the string "o, W" in ASCII encoding. The hexadecimal values `0x6f, 0x2c, 0x20`, and `0x57` correspond to the ASCII codes for the characters 'o', ',', ' ', and 'W', respectively.

* `0x6f,0x72,0x6c,0x64` represents the string "orld" in ASCII encoding. The hexadecimal values 0x6f, 0x72, 0x6c, and 0x64 correspond to the ASCII codes for the characters 'o', 'r', 'l', and 'd', respectively.

* `0x0a` represents a newline character (ASCII code 10). This is commonly used in text files to indicate the end of a line.

So when this code is executed, it will simply define these four strings in memory, but it won't actually output them to the console or do anything else with them. If you wanted to output these strings to the console, you would need to use additional assembly instructions to invoke the appropriate system calls or library functions to print them out. Thus the need for **"improving"** it to use system calls.
> `hello.asm` was written by `Тsфdiиg` - on Twitter.
