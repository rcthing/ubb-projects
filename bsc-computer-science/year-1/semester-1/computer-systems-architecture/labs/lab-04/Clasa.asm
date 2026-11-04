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
    c resw 1

; our code starts here
segment code use32 class=code
    start:
        ; Se dau cuvintele A si B. Se cere cuvantul C format astfel:
        
        ;- bitii 0-2 ai lui C coincid cu bitii 10-12 ai lui B
        mov ax, 0
        mov bx, [b]; bx <- 1111100000001011b
        and bx, 0001110000000000b; bx <- 0001100000000000b 
        shr bx, 10; bx <- 0000000000000110b sau 0006h
        or ax, bx; ax <- 0000000000000110b sau 0006h
        
        ;- bitii 3-6 ai lui C au valoarea 1
        mov bx, 0000000001111000b
        or ax, bx; ax <- 0000000001111110b
        
        ;- bitii 7-10 ai lui C coincid cu bitii 1-4 ai lui A
        and cx, 0000011110000000b;
        shr cx, 6
        or cx, ax;
        
        ;- bitii 11-12 au valoarea 0
        and ax,1110011111111111b
        
        ;- bitii 13-15 ai lui C concid cu inverul bitilor 9-11 ai lui B
        mov dx, [b]; dx <- b
        not dx; s au inversat bitii lui dx
        and dx,0000111000000000b
        shl dx,4; dx <- 1110000000000000b
        or ax, dx
        mov [c], ax;
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
