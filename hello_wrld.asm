section .data
    hello_msg db "Hello, World!", 10 ; define the message string with a newline

section .text
    global _start

_start:
    ; prepare the arguments for the write system call
    mov eax, 4          ; set the syscall number for write
    mov ebx, 1          ; set the file descriptor to stdout
    mov ecx, hello_msg  ; set the message to print
    mov edx, 14         ; set the message length

    ; invoke the write system call to print the message
    int 0x80

    ; exit the program
    mov eax, 1          ; set the syscall number for exit
    xor ebx, ebx        ; set the exit code to 0
    int 0x80            ; invoke the exit system call

