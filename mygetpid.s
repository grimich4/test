.section .data
.section .text
.global mygetpid

mygetpid:
    mov         $20, %eax
    xor         %rdi, %rdi
    syscall
    ret
