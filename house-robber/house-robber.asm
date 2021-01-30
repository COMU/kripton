; How to compile
; $ nasm -f elf64 house-robber.asm && ld -m elf_x86_64 -dynamic-linker \
; /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/crt1.o \
; /usr/lib/x86_64-linux-gnu/crti.o house-robber.o /usr/lib/x86_64-linux-gnu/crtn.o -lc -o house-robber
; 
; Based on Golang solution

        extern printf

        SECTION .rodata
houses:
        dq 2, 7, 9, 3, 1
houseslen:
        dq 5
fmt:
        db "%ld", 10, 0

        SECTION	.text

        global main
main:
        push rbp

        mov rdi, houses                ; first parameter of rob (houses address)
        mov rsi, qword [houseslen]     ; second parameter of rob
        call rob

        lea rdi, fmt                   ; first parameter of printf (format string)
        mov rsi, rax                   ; second parameter of printf (return value of rob function)
        xor rax, rax                   ; 0 xmm register used (assign 0 to rax)
        call printf                    ; Call printf C function

        xor rax, rax                   ; return with exit code 0
        ret

rob:
        push rbp                       ; save parent function's base pointer
        mov rbp, rsp                   ; assign stack pointer to base pointer
        mov rax, rsi                   ; second parameter (houseslen)
        imul rax, 8                    ; calculate stack offset for qword
        sub rsp, rax                   ; allocate space from stack
        pushfq                         ; push EFLAGS Register (https://en.wikipedia.org/wiki/FLAGS_register)

        mov r8, rdi                    ; first parameter (houses address)

        xor rax, rax                   ; rax = 0 (return rax)

        cmp rsi, 0                     ; houseslen == 0
        je ret_rax

        mov rax, qword [r8]            ; rax = houses[0] (return rax)

        cmp rsi, 1                     ; houseslen == 1
        je ret_rax

        mov rcx, rsi                   ; rsi = rcx (houseslen)
        neg rcx                        ; stack offset of total_robbed[0]

        mov qword [rbp+rcx*8], rax     ; total_robbed[0] = houses[0]

        cmp rax, qword [r8+8]          ; rax > houses[1]
        jg h0_greater

        mov rax, qword [r8+8]          ; rax = houses[1]

h0_greater:
        mov qword [rbp+rcx*8+8], rax   ; total_robbed[1] = rax

        mov rax, 2                     ; i = 2
        add rcx, rax                   ; set stack offset
loop:
        mov rdi, qword [rbp+rcx*8-8]   ; rdi = total_robbed[i-1]
        mov rdx, qword [rbp+rcx*8-16]  ; rdx = total_robbed[i-2]
        add rdx, qword [r8+rax*8]      ; rdx += houses[i]

        cmp rdx, rdi                   ; if (total_robbed[i-2] + houses[i]) > total_robbed[i-1]
        jg tr_h_greater

        mov rdx, rdi                   ; rdx = total_robbed[i-1]
tr_h_greater:
        mov qword [rbp+rcx*8], rdx     ; total_robbed[i] = rdx (total_robbed[i-2] + houses[i])

        inc rax                        ; i += 1
        inc rcx                        ; increase stack offset
        cmp rax, rsi                   ; if i > len(total_robbed)
        jle loop                       ; finish loop

        mov rax, qword [rbp-8]         ; rax = total_robbed[len(total_robbed)-1]
ret_rax:
        popfq                          ; pop EFLAGS Register
        leave                          ; restore rbp & rsp (https://www.felixcloutier.com/x86/leave)
        ret                            ; return rax

