; How to compile
; $ nasm -f elf64 xor-decryption.asm && ld -m elf_x86_64 -dynamic-linker \
; /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/crt1.o \
; /usr/lib/x86_64-linux-gnu/crti.o xor-decryption.o /usr/lib/x86_64-linux-gnu/crtn.o -lc -o xor-decryption

        %macro prologue 0
            push rbp
            mov rbp, rsp
            pushfq
        %endmacro
        %macro epilogue 0
            leave
            ret
        %endmacro

        %macro prepare_fc 0
            push rsi
            push rdi
            push rdx
        %endmacro
        %macro end_fc 0
            pop rdx
            pop rdi
            pop rsi
        %endmacro

        extern printf

        SECTION .rodata
fmt:
        db "%ld", 10, 0
encrypted_text:
        dq 36, 22, 80, 0, 0, 4, 23, 25, 19, 17, 88, 4, 4, 19, 21, 11, 88, 22, 23, 23, 29, 69, 12, 24, 0, 88, 25, 11, 12, 2, 10, 28, 
        dq 5, 6, 12, 25, 10, 22, 80, 10, 30, 80, 10, 22, 21, 69, 23, 22, 69, 61, 5, 9, 29, 2, 66, 11, 80, 8, 23, 3, 17, 88, 19, 0, 
        dq 20, 21, 7, 10, 17, 17, 29, 20, 69, 8, 17, 21, 29, 2, 22, 84, 80, 71, 60, 21, 69, 11, 5, 8, 21, 25, 22, 88, 3, 0, 10, 25, 
        dq 0, 10, 5, 8, 88, 2, 0, 27, 25, 21, 10, 31, 6, 25, 2, 16, 21, 82, 69, 35, 63, 11, 88, 4, 13, 29, 80, 22, 13, 29, 22, 88, 
        dq 31, 3, 88, 3, 0, 10, 25, 0, 11, 80, 10, 30, 80, 23, 29, 19, 12, 8, 2, 10, 27, 17, 9, 11, 45, 95, 88, 57, 69, 16, 17, 19, 
        dq 29, 80, 23, 29, 19, 0, 22, 4, 9, 1, 80, 3, 23, 5, 11, 28, 92, 69, 9, 5, 12, 12, 21, 69, 13, 30, 0, 0, 0, 0, 27, 4, 0, 28, 
        dq 28, 28, 84, 80, 4, 22, 80, 0, 20, 21, 2, 25, 30, 17, 88, 21, 29, 8, 2, 0, 11, 3, 12, 23, 30, 69, 30, 31, 23, 88, 4, 13, 
        dq 29, 80, 0, 22, 4, 12, 10, 21, 69, 11, 5, 8, 88, 31, 3, 88, 4, 13, 17, 3, 69, 11, 21, 23, 17, 21, 22, 88, 65, 69, 83, 80, 
        dq 84, 87, 68, 69, 83, 80, 84, 87, 73, 69, 83, 80, 84, 87, 65, 83, 88, 91, 69, 29, 4, 6, 86, 92, 69, 15, 24, 12, 27, 24, 
        dq 69, 28, 21, 21, 29, 30, 1, 11, 80, 10, 22, 80, 17, 16, 21, 69, 9, 5, 4, 28, 2, 4, 12, 5, 23, 29, 80, 10, 30, 80, 17, 16, 
        dq 21, 69, 27, 25, 23, 27, 28, 0, 84, 80, 22, 23, 80, 17, 16, 17, 17, 88, 25, 3, 88, 4, 13, 29, 80, 17, 10, 5, 0, 88, 3, 
        dq 16, 21, 80, 10, 30, 80, 17, 16, 25, 22, 88, 3, 0, 10, 25, 0, 11, 80, 12, 11, 80, 10, 26, 4, 4, 17, 30, 0, 28, 92, 69, 
        dq 30, 2, 10, 21, 80, 12, 12, 80, 4, 12, 80, 10, 22, 19, 0, 88, 4, 13, 29, 80, 20, 13, 17, 1, 10, 17, 17, 13, 2, 0, 88, 31, 
        dq 3, 88, 4, 13, 29, 80, 6, 17, 2, 6, 20, 21, 69, 30, 31, 9, 20, 31, 18, 11, 94, 69, 54, 17, 8, 29, 28, 28, 84, 80, 44, 88, 
        dq 24, 4, 14, 21, 69, 30, 31, 16, 22, 20, 69, 12, 24, 4, 12, 80, 17, 16, 21, 69, 11, 5, 8, 88, 31, 3, 88, 4, 13, 17, 3, 69, 
        dq 11, 21, 23, 17, 21, 22, 88, 25, 22, 88, 17, 69, 11, 25, 29, 12, 24, 69, 8, 17, 23, 12, 80, 10, 30, 80, 17, 16, 21, 69, 
        dq 11, 1, 16, 25, 2, 0, 88, 31, 3, 88, 4, 13, 29, 80, 21, 29, 2, 12, 21, 21, 17, 29, 2, 69, 23, 22, 69, 12, 24, 0, 88, 19, 
        dq 12, 10, 19, 9, 29, 80, 18, 16, 31, 22, 29, 80, 1, 17, 17, 8, 29, 4, 0, 10, 80, 12, 11, 80, 84, 67, 80, 10, 10, 80, 7, 1, 
        dq 80, 21, 13, 4, 17, 17, 30, 2, 88, 4, 13, 29, 80, 22, 13, 29, 69, 23, 22, 69, 12, 24, 12, 11, 80, 22, 29, 2, 12, 29, 3, 
        dq 69, 29, 1, 16, 25, 28, 69, 12, 31, 69, 11, 92, 69, 17, 4, 69, 16, 17, 22, 88, 4, 13, 29, 80, 23, 25, 4, 12, 23, 80, 22, 
        dq 9, 2, 17, 80, 70, 76, 88, 29, 16, 20, 4, 12, 8, 28, 12, 29, 20, 69, 26, 9, 69, 11, 80, 17, 23, 80, 84, 88, 31, 3, 88, 4, 
        dq 13, 29, 80, 21, 29, 2, 12, 21, 21, 17, 29, 2, 69, 12, 31, 69, 12, 24, 0, 88, 20, 12, 25, 29, 0, 12, 21, 23, 86, 80, 44, 
        dq 88, 7, 12, 20, 28, 69, 11, 31, 10, 22, 80, 22, 16, 31, 18, 88, 4, 13, 25, 4, 69, 12, 24, 0, 88, 3, 16, 21, 80, 10, 30, 
        dq 80, 17, 16, 25, 22, 88, 3, 0, 10, 25, 0, 11, 80, 17, 23, 80, 7, 29, 80, 4, 8, 0, 23, 23, 8, 12, 21, 17, 17, 29, 28, 28, 
        dq 88, 65, 75, 78, 68, 81, 65, 67, 81, 72, 70, 83, 64, 68, 87, 74, 70, 81, 75, 70, 81, 67, 80, 4, 22, 20, 69, 30, 2, 10, 
        dq 21, 80, 8, 13, 28, 17, 17, 0, 9, 1, 25, 11, 31, 80, 17, 16, 25, 22, 88, 30, 16, 21, 18, 0, 10, 80, 7, 1, 80, 22, 17, 8, 
        dq 73, 88, 17, 11, 28, 80, 17, 16, 21, 11, 88, 4, 4, 19, 25, 11, 31, 80, 17, 16, 21, 69, 11, 1, 16, 25, 2, 0, 88, 2, 10, 
        dq 23, 4, 73, 88, 4, 13, 29, 80, 11, 13, 29, 7, 29, 2, 69, 75, 94, 84, 76, 65, 80, 65, 66, 83, 77, 67, 80, 64, 73, 82, 65, 
        dq 67, 87, 75, 72, 69, 17, 3, 69, 17, 30, 1, 29, 21, 1, 88, 0, 23, 23, 20, 16, 27, 21, 1, 84, 80, 18, 16, 25, 6, 16, 80, 0, 
        dq 0, 0, 23, 29, 3, 22, 29, 3, 69, 12, 24, 0, 88, 0, 0, 10, 25, 8, 29, 4, 0, 10, 80, 10, 30, 80, 4, 88, 19, 12, 10, 19, 9, 
        dq 29, 80, 18, 16, 31, 22, 29, 80, 1, 17, 17, 8, 29, 4, 0, 10, 80, 12, 11, 80, 84, 86, 80, 35, 23, 28, 9, 23, 7, 12, 22, 
        dq 23, 69, 25, 23, 4, 17, 30, 69, 12, 24, 0, 88, 3, 4, 21, 21, 69, 11, 4, 0, 8, 3, 69, 26, 9, 69, 15, 24, 12, 27, 24, 69, 
        dq 49, 80, 13, 25, 20, 69, 25, 2, 23, 17, 6, 0, 28, 80, 4, 12, 80, 17, 16, 25, 22, 88, 3, 16, 21, 92, 69, 49, 80, 13, 25, 
        dq 6, 0, 88, 20, 12, 11, 19, 10, 14, 21, 23, 29, 20, 69, 12, 24, 4, 12, 80, 17, 16, 21, 69, 11, 5, 8, 88, 31, 3, 88, 4, 13, 
        dq 29, 80, 22, 29, 2, 12, 29, 3, 69, 73, 80, 78, 88, 65, 74, 73, 70, 69, 83, 80, 84, 87, 72, 84, 88, 91, 69, 73, 95, 87, 
        dq 77, 70, 69, 83, 80, 84, 87, 70, 87, 77, 80, 78, 88, 21, 17, 27, 94, 69, 25, 28, 22, 23, 80, 1, 29, 0, 0, 22, 20, 22, 
        dq 88, 31, 11, 88, 4, 13, 29, 80, 20, 13, 17, 1, 10, 17, 17, 13, 2, 0, 88, 31, 3, 88, 4, 13, 29, 80, 6, 17, 2, 6, 20, 21, 
        dq 75, 88, 62, 4, 21, 21, 9, 1, 92, 69, 12, 24, 0, 88, 3, 16, 21, 80, 10, 30, 80, 17, 16, 25, 22, 88, 29, 16, 20, 4, 12, 
        dq 8, 28, 12, 29, 20, 69, 26, 9, 69, 65, 64, 69, 31, 25, 19, 29, 3, 69, 12, 24, 0, 88, 18, 12, 9, 5, 4, 28, 2, 4, 12, 21, 
        dq 69, 80, 22, 10, 13, 2, 17, 16, 80, 21, 23, 7, 0, 10, 89, 69, 23, 22, 69, 12, 24, 0, 88, 19, 12, 10, 19, 16, 21, 22, 0, 
        dq 10, 21, 11, 27, 21, 69, 23, 22, 69, 12, 24, 0, 88, 0, 0, 10, 25, 8, 29, 4, 0, 10, 80, 10, 30, 80, 4, 88, 19, 12, 10, 19, 
        dq 9, 29, 80, 18, 16, 31, 22, 29, 80, 1, 17, 17, 8, 29, 4, 0, 10, 80, 12, 11, 80, 84, 86, 80, 36, 22, 20, 69, 26, 9, 69, 
        dq 11, 25, 8, 17, 28, 4, 10, 80, 23, 29, 17, 22, 23, 30, 12, 22, 23, 69, 49, 80, 13, 25, 6, 0, 88, 28, 12, 19, 21, 18, 17, 
        dq 3, 0, 88, 18, 0, 29, 30, 69, 25, 18, 9, 29, 80, 17, 23, 80, 1, 29, 4, 0, 10, 29, 12, 22, 21, 69, 12, 24, 0, 88, 3, 16, 
        dq 21, 3, 69, 23, 22, 69, 12, 24, 0, 88, 3, 16, 26, 3, 0, 9, 5, 0, 22, 4, 69, 11, 21, 23, 17, 21, 22, 88, 25, 11, 88, 7, 13, 
        dq 17, 19, 13, 88, 4, 13, 29, 80, 0, 0, 0, 10, 22, 21, 11, 12, 3, 69, 25, 2, 0, 88, 21, 19, 29, 30, 69, 22, 5, 8, 26, 21, 
        dq 23, 11, 94
encrypted_text_length:
        dq 1455

        SECTION .text

        global main
main:
        push rbp                       ; save rbp to stack (before function call)

        mov rdi, encrypted_text        ; first parameter of xds (address of encrypted_text)
        mov rsi, [encrypted_text_length] ; second parameter of xds (value of encrypted_text_length)
        call xds

        lea rdi, fmt                   ; first parameter of printf (format string)
        mov rsi, rax                   ; second parameter of printf (return value of xds)
        xor rax, rax                   ; 0 xmm register used (assign 0 to rax)
        call printf                    ; Call printf C function
        pop rbp                        ; load rbp from stack after using printf

        xor rax, rax                   ; return with exit code 0
        ret

xds:                                   ; xor_decrpyted_sum
        prologue
        sub rsp, 24
; rdi = first parameter of xds (address of encrypted_text),
; rsi = second parameter of xds (value of encrypted_text_length)

        prepare_fc
        xor rdx, rdx                   ; third parameter of cbm (starting index)
        call cbm
        mov qword [rbp-24], rax        ; save first chipher char to stack
        end_fc

        prepare_fc
        mov rdx, 1                     ; third parameter of cbm (starting index)
        call cbm
        mov qword [rbp-16], rax        ; save second chipher char to stack
        end_fc

        prepare_fc
        mov rdx, 2                     ; third parameter of cbm (starting index)
        call cbm
        mov qword [rbp-8], rax         ; save third chipher char to stack
        end_fc

        xor rdx, rdx                   ; encrypted_text_index
        xor rax, rax                   ; decrypted_text_char_sum = 0
        xor rbx, rbx                   ; cipher_letter_idx = 0
loop_sum:
        mov rcx, qword [rdi+rdx*8]     ; encrypted_char = encrypted_text[encrypted_text_index]
        xor rcx, qword [rbp+rbx*8-24]  ; (encrypted_char ^ cipher[cipher_letter_idx])
        add rax, rcx                   ; decrypted_text_char_sum += decrypted_char

        inc rbx                        ; cipher_letter_idx +=
        cmp rbx, 3                     ; if cipher_letter_idx != 3
        jne if_not_3

        xor rbx, rbx                   ; cipher_letter_idx = 0

if_not_3:
        inc rdx                        ; encrypted_text_index += 1
        cmp rdx, rsi                   ; encrypted_text_index != encrypted_text_length
        jne loop_sum

ret_xds:
        epilogue

cbm:                                   ; calc_best_match
        prologue
; rdi = first parameter of cbm (address of encrypted_text),
; rsi = second parameter of cbm (value of encrypted_text_length)
; rdx = third parameter of cbm (starting index)

        xor rcx, rcx                   ; best_score = 0

        mov r8, 97                     ; loop_cipher_letter index
loop_cipher_letter:
        xor r10, r10                   ; score = 0
        push rdx                       ; save encrypted_text_index to stack

loop_code:
        mov r11, qword [rdi+rdx*8]     ; r11 = encrypted_char
        xor r11, r8                    ; r11 = encrypted_char ^ cipher_letter

        cmp r11, 64                    ; 64 > decrypted_char
        jl if_32                       ; maybe its 32

        cmp r11, 90                    ; decrypted_char < 90
        jl if_good_char                ; its not in 64, 96 maybe its between 96, 123

        cmp r11, 96                    ; decrypted_char < 96
        jl if_not_good_char            ; its between 90, 96 so its not a good char

        cmp r11, 123                   ; decrypted_char >= 123
        jge if_not_good_char           ; its not a good if its greater equal than 123
        jmp if_good_char               ; its between 96, 123 so its a good char

if_32:
        cmp r11, 32                    ; decrypted_char != 32
        jne if_not_good_char

if_good_char:
        inc r10                        ; score += 1

if_not_good_char:

        add rdx, 3                     ; iterate next encrypted_char
        cmp rdx, rsi                   ; encrypted_text_index < encrypted_text_length
        jl loop_code

        pop rdx                        ; load first index of code array from stack

        cmp r10, rcx                   ; score > best_score
        jle not_best_score

        mov rcx, r10                   ; best_score = score
        mov rax, r8                    ; best_cipher_letter = cipher_letter

not_best_score:
        inc r8                         ; iterate next cipher_letter
        cmp r8, 123                    ; cipher_letter < loop_cipher_letter last index
        jne loop_cipher_letter

ret_bm:
        epilogue
