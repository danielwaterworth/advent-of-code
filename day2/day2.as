section .text
    global _start

_start:
    ; alloca for the input buffer, 16 byte aligned
    sub rsp, 20624

    ; read into buffer. Yes, I did hardcode the size of the input
    mov rdx, 20618
    mov rsi, rsp
    xor rdi, rdi ; stdin
    xor rax, rax ; read
    syscall

    xor r8, r8 ; buffer offset
    xor r9, r9 ; line number
    xor r14, r14 ; part1 output
    xor r15, r15 ; part2 output

line_loop:
    lea rbx, [rsp+r8]
    call atoi
    mov r10, rax
    add r8, rcx
    inc r8
    lea rbx, [rsp+r8]
    call atoi
    mov r11, rax
    add r8, rcx
    inc r8
    movzx r12, byte [rsp+r8]
    inc r8
    inc r8
    inc r8

    lea rbx, [rsp+r8]
    xor r13, r13 ; number of matching characters

    movzx rsi, byte [rbx+r10-1]
    cmp rsi, r12
    sete cl
    movzx rsi, byte [rbx+r11-1]
    cmp rsi, r12
    sete dl

    xor cl, dl
    add r15, rcx

validate_loop:
    cmp byte [rsp+r8], 10
    je _done

    movzx rsi, byte [rsp+r8]
    cmp rsi, r12

    jne _ne
    inc r13
_ne:
    inc r8
    jmp validate_loop

_done:
    inc r8
    inc r9

    cmp r13, r10
    jl invalid

    cmp r13, r11
    jg invalid

    inc r14

invalid:
    cmp r8, 20618
    je line_loop_end
    jmp line_loop

line_loop_end:
    shr r15, 7
    and r15, 127
    mov rdi, r15
    mov rax, 60
    syscall

atoi:
    xor rax, rax
    xor rcx, rcx
_convert:
    movzx rsi, byte [rbx+rcx] ; Get the current character
    cmp rsi, 48               ; Anything less than 0 is invalid
    jl done
    cmp rsi, 57               ; Anything greater than 9 is invalid
    jg done
    sub rsi, 48               ; Convert from ASCII to decimal
    imul rax, 10              ; Multiply total by 10
    add rax, rsi              ; Add current digit to total
    inc rcx                   ; Get the address of the next character
    jmp _convert

done:
    ret                       ; Return total or error code
