; How to compile
; $ nasm -f elf64 calc-sheet-column-number.asm && ld -m elf_x86_64 -dynamic-linker \
; /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/crt1.o \
; /usr/lib/x86_64-linux-gnu/crti.o calc-sheet-column-number.o /usr/lib/x86_64-linux-gnu/crtn.o -lc -o calc-sheet-column-number

        extern printf

        SECTION .data
triangle:
        dq 0
i:
        dq 0

        SECTION .rodata
fmt:
        db "%ld", 10, 0
input_string:
        db "KRPT", 0
input_length: equ $-input_string

        SECTION	.text

        global main
main:
        push rbp                       ; save rbp to stack (before function call)

        mov rdi, input_string          ; first parameter of csnc
        mov rsi, input_length          ; second parameter of cscn
        call cscn

        lea rdi, fmt                   ; first parameter of printf (format string)
        mov rsi, rax                   ; second parameter of printf (return value of cscn)
        xor rax, rax                   ; 0 xmm register used (assign 0 to rax)
        call printf                    ; Call printf C function
        pop rbp                        ; load rbp from stack after using printf

        xor rax, rax                   ; return with exit code 0
        ret

cscn:                                  ; calc-sheet-column-number
        push rbp
        mov rbp, rsp

        xor rax, rax                   ; initialize return value
        xor r10, r10                   ; power of 26 (i = 0)
        sub rsi, 2                     ; max_power_for_string (lenght - `null teminated char lenght` - 1)

loop:
        movzx rdx, byte [rdi+r10]      ; rdx = input_string[i]

        cmp rdx, 0                     ; if rdx == '0' (null teminated char) then jump to return
        je ret_rax

        sub rdx, 64                    ; input_string[i]-64 (get char value from ascii value)

; begining of power
        mov r9, r10                    ; power counter for pow (j = i)
        mov r8, 1                      ; initialize min power value for pow current_power=x^0
pow:
        cmp rsi, r9                    ; if max_power_for_string == j then jump to ret_pow
        je ret_pow

        imul r8, 26                    ; multiply with base current_power*=26
        inc r9                         ; j++
        jmp pow

ret_pow:
        imul rdx, r8                   ; rdx*(26^current_power)
        add rax, rdx                   ; total += current_char_value
; ending of power

        inc r10                        ; increase for next items power
        jmp loop

ret_rax:
        pop rbp
        ret

