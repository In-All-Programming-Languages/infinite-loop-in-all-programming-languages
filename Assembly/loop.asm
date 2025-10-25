section .data
    newline db 10       ; newline character

section .bss
    buffer resb 20      ; buffer for number string

section .text
    global _start

_start:
    mov rbx, 1          ; counter starts at 1

print_loop:
    ; Convert number to string
    mov rax, rbx        ; number to convert
    lea rdi, [buffer+19]; point to end of buffer
    mov byte [rdi], 0   ; null terminate
    mov rcx, 10         ; divisor

convert_loop:
    xor rdx, rdx        ; clear rdx for division
    div rcx             ; divide rax by 10
    add dl, '0'         ; convert remainder to ASCII
    dec rdi             ; move buffer pointer back
    mov [rdi], dl       ; store digit
    test rax, rax       ; check if quotient is 0
    jnz convert_loop    ; continue if not zero

    ; Calculate string length
    lea rsi, [buffer+19]; end of buffer
    mov rdx, rsi        ; copy end address
    sub rdx, rdi        ; length = end - start

    ; Write number to stdout
    mov rax, 1          ; sys_write
    mov rsi, rdi        ; string start address
    mov rdi, 1          ; stdout
    syscall

    ; Write newline
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    lea rsi, [newline]  ; newline character
    mov rdx, 1          ; length
    syscall

    ; Increment counter and repeat
    inc rbx             ; next number
    jmp print_loop      ; infinite loop

    ; Exit (never reached)
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; exit code 0
    syscall