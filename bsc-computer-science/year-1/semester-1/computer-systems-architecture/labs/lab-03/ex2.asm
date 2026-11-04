bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 5
    b dw 4
    c dd 23
    d dq 2

; our code starts here
segment code use32 class=code
    start:
    ; (c+b+a)-(d+d)=28
        movsx eax, word[b];eax <- b
        add eax, [c]; eax <- c+b
        movsx ebx, byte[a]; ebx <- a
        add eax, ebx; eax <- (c+b+a)
        cdq; edx:eax <- (c+b+a)
        mov ebx, [d+0]
        mov ecx, [d+4]; ecx:ebx <- d
        add ebx, ebx
        adc ecx, ecx; ecx:ebx <- (d+d)
        clc; CF <- 0
        sub eax, ebx
        sbb edx, ecx; edx:eax <- (c+b+a)-(d+d)
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

