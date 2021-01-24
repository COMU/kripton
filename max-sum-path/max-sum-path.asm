
; How to compile
; $ nasm -f elf64 max-sum-path.asm && gcc -no-pie -o max-sum-path max-sum-path.o

        extern printf

        SECTION .data
triangle:
        dq 75
        dq 95, 64
        dq 17, 47, 82
        dq 18, 35, 87, 10
        dq 20, 4,  82, 47, 65
        dq 19, 1,  23, 75, 3,  34
        dq 88, 2,  77, 73, 7,  63, 67
        dq 99, 65, 4,  28, 6,  16, 70, 92
        dq 41, 41, 26, 56, 83, 40, 80, 70, 33
        dq 41, 48, 72, 33, 47, 32, 37, 16, 94, 29
        dq 53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14
        dq 70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57
        dq 91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48
        dq 63, 66, 4,  68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31
        dq 4,  62, 98, 27, 23, 9,  70, 98, 73, 93, 38, 53, 60, 4,  23

        SECTION .rodata
fmt:
        db "%d", 10, 0

        SECTION	.text

        global main
main:
        mov rsi, 14                    ; len of current array which is second to last array
        mov rdx, 91                    ; first item offset of inner array which is second to last array
        xor rax, rax                   ; inner loop index

loop_1:
        push rdx                       ; backup offsets for future use in loop
        push rsi

        add rdx, rax                   ; calculate parent offset
        mov rcx, rdx                   ; backup parent offset
        mov r10, [triangle+rdx*8]      ; assign parent value
        add rdx, rsi                   ; calculate left child offset
        mov r8, [triangle+rdx*8]       ; assign left node value
        mov r9, [triangle+(rdx+1)*8]   ; assign right node value

        cmp r8, r9                     ; compare left and right node values
        jle left                       ; r8 > r9
        add r10, r8                    ; parent += left_node
        jmp addition

left:                                  ; r8 <= r9
        add r10, r9                    ; parent += right_node

addition:

        mov qword [triangle+rcx*8], r10 ; assign parent's new value (parent = new_value)

        pop rsi                        ; get offsets back in to registers
        pop rdx
        inc rax                        ; increase index value
        cmp rax, rsi                   ; compare idex value with current array's lenght
        jne loop_1                     ; if rax != rsi then continue
; end of inner loop

        xor rax, rax                   ; assign 0 to rax

        dec rsi                        ; upper array size is one shorter than current
        sub rdx, rsi                   ; change offset to upper array's first item

        cmp rsi, 0                     ; if upper array size is 0 then exit from loop
        jne loop_1                     ; else continue loop
; end of outer loop

        push rbp                       ; save rbp to stack (before function call)

        lea rdi, fmt                   ; first parameter of printf (format string)
        mov rsi, [triangle]            ; second parameter of printf (first array item)
        xor rax, rax                   ; 0 xmm register used (assign 0 to rax)
        call printf                    ; Call printf C function
        pop rbp                        ; load rbp from stack after using printf

        xor rax, rax                   ; return with exit code 0
        ret
