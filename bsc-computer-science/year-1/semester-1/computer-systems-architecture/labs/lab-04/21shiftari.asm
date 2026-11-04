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
        ;Se dau cuvintele A si B. Se cere dublucuvantul C:
        mov ax, 0
        ;bitii 0-3 ai lui C coincid cu bitii 5-8 ai lui B
        mov bx, [b]; bx <- 1111100000001011b
        and bx, 0000_0001_1110_0000b
        shr bx, 5; bx <- 0000_0000_0000_0000
        or ax, bx
        
        ;bitii 4-10 ai lui C sunt invers fata de bitii 0-6 ai lui B
        mov bx, [b]; bx <- 1111100000001011b
        not bx; bx <- 0000_0111_1111_0100b
        or bx, 0000_0000_0111_1111b; bx <- 0000_0000_0111_0100b
        shl bx, 4; bx <- 0000_0111_0100_0000b
        or ax, bx; ax <- 0000_0111_0100_0000b
        
        ;bitii 11-18 ai lui C sunt 1
        or ax, 1111_1000_0000_0000b
        
        ;bitii 19-31 ai lui C coincid cu bitii 3-15 ai lui B
        mov bx, [b] 
        and bx, 1111_1111_1111_1000b
        or bx, 0000_0000_0000_0111b; bx <- 1111100000001111b
        
        mov [c], ax
        mov [c+4], bx; c <- 1111_1000_0000_1111_1111_1111_0100_0000b F80FFF40h
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
