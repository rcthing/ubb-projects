bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 1100001110100110b
    b dw 1111100000001011b
    c resd 1

; our code starts here
segment code use32 class=code
    start:
        ; Se dau doua cuvinte A si B. Sa se obtina dublucuvantul C:
        
        ;bitii 0-6 ai lui C au valoarea 0
        mov ax, 0; ax <- 0
        
        ;- bitii 7-9 ai lui C coincid cu bitii 0-2 ai lui A
        mov bx, [a]; bx <- 1100001110100110b
        and bx, 0000_0000_0000_0111b; bx <- 0000 0000 0000 0110b
        shl bx, 7; bx <- 0000 0011 0000 0000b
        or ax, bx; ax <- 0000 0011 0000 0000b
        
        ;bitii 10-15 ai lui C coincid cu bitii 8-13 ai lui B
        mov bx, [b]
        and bx, 0011_1111_0000_0000b; bx <- 0011_1000_0000_0000b
        shl bx, 2; bx <- 1110_0000_0000_0000b
        or ax, bx; ax <- 1110_0011_0000_0000b
        
        ;bitii 16-31 ai lui C au valoarea 1
        mov bx, 1111_1111_1111_1111b
        mov [c], ax
        mov [c+4], bx; c <- 1111_1111_1111_1111_1110_0011_0000_0000b = FFFFE300h
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
