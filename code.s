global main
extern printf
extern InitWindow
extern WindowShouldClose
extern BeginDrawing
extern ClearBackground
extern EndDrawing
extern CloseWindow
extern SetTargetFPS
extern DrawPixel
extern SetWindowPosition
extern IsKeyPressed
extern IsKeyDown
extern sinf

    ; rdi rsi rdx rcx r8 r9
    ; CVTSI2SD int to double
    ; CVTTSD2SI double to int

section .data
    title: db "Hello, raylib!", 0
    num: db "val = %.10f", 10, 0
    numi: db "val = %i", 10, 0
    col: dq 0xFFFFFFFF
    i: dq -250
    j: dq -250
    x: dq 0
    y: dq 0
    temp: dq 0

section .note.GNU-stack 

section .text
main:
    push rbp
    mov rbp, rsp
    and rsp, -16

    mov rdi, 500
    mov rsi, 500
    mov rdx, title
    call InitWindow

    mov rsi, 500
    mov rdx, 200
    call SetWindowPosition
    xor rax, rax

    mov rdi, 1200
    call SetTargetFPS

    ; init code

.loop:
    call WindowShouldClose
    test eax, eax
    jne .end

    call BeginDrawing

    mov qword [i], -250
    mov qword [j], -250

    .lopJ:
        mov qword [i], -250
        .lopI:
            CVTSI2SD xmm0, qword [i]
            mov rax, 200
            CVTSI2SD xmm3, rax
            divsd xmm0, xmm3
            CVTSI2SD xmm1, qword [j]
            mov rax, 200
            CVTSI2SD xmm3, rax
            divsd xmm1, xmm3
            
            mov qword [x], 0
            mov qword [y], 0

            mov rdx, 0
            .lopK:
                mov rax, qword [x]
                mov qword [temp], rax

                movsd xmm2, qword [temp]
                movsd xmm3, qword [y]

                ;; x = x*x
                mulsd xmm2, xmm2
                ;; y = y*y
                mulsd xmm3, xmm3
                ;; x = x*x-y*y
                subsd xmm2, xmm3
                ;; x = x + i/100.
                addsd xmm2, xmm0
                ;; x <= x
                movq rax, xmm2
                mov qword [x], rax
                
                movsd xmm2, qword [temp]
                movsd xmm3, qword [y]
                ;; x = x*y
                mulsd xmm2, xmm3
                ;; x = x*2
                mov rax, 2
                CVTSI2SD xmm3, rax
                mulsd xmm2, xmm3
                ;; x = x + j/100.
                addsd xmm2, xmm1
                ;; y <= x
                movq rax, xmm2
                mov qword [y], rax

                movsd xmm6, qword [x]
                movsd xmm7, qword [y]

                mulsd xmm6, xmm6
                mulsd xmm7, xmm7
    
                addsd xmm6, xmm7
    
                mov rax, 2
                CVTTSD2SI rbx, xmm6
    
                cmp rbx, rax
                jge .skip

                add rdx, 1
                cmp rdx, 100
                jle .lopK

            mov rdi, qword [i]
            add rdi, 250
            mov rsi, qword [j]
            add rsi, 250
            mov rdx, qword [col]
            call DrawPixel
            xor rax, rax

            .skip:

            add qword [i], 1
            cmp  qword [i], 250
            jnge .lopI
        add qword [j], 1
        cmp  qword [j], 250
        jnge .lopJ
    call EndDrawing
    
    mov rdi, 32
    call IsKeyPressed

    cmp al, 1
    jne .loop

    ; if pressed code

    jmp .loop

.end:
    call CloseWindow

    mov eax, 0
    mov rsp, rbp
    pop rbp
    ret
