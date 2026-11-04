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
    b db -4
    c db 2
    e dd 3
    x dq 12
    doi db 2

; our code starts here
segment code use32 class=code
    start:
    ; CU SEMN
    ; a/2+b*b-a*b*c+e+x = 2+16+40+15 = 73
        ;a/2
        mov al, [a]
        cbw; ax <- a
        idiv byte[doi]; al <- a/2
        cbw; ax <- a/2
        mov bx, ax; bx <- a/2
        
        ;b*b
        mov al, [b]
        imul al; ax <- b*b
        
        ;a/2+b*b
        add ax, bx; ax <- a/2+b*b
        cwde; eax <- a/2+b*b
        mov ecx, eax; ecx <- a/2+b*b
        
        ;a*b*c
        mov al, [a]; al <- a
        imul byte[b]; ax <- a*b
        mov bx, ax; bx <- a*b
        mov al, [c]; al <- c 
        cbw; ax <- c 
        imul bx; dx:ax <- a*b*c
        push dx
        push ax
        pop eax; eax <- a*b*c
        
        ;a/2+b*b-a*b*c
        sub ecx, eax; ecx <- a/2+b*b-a*b*c
        
        ;+x
        add ecx, [x]; ecx <- a/2+b*b-a*b*c+x
        mov eax, ecx; eax <- ecx
        cdq; edx:eax <- a/2+b*b-a*b*c+x
        
        ;+e 
        clc; CF <- 0
        add eax, [e+0]
        adc edx, [e+4]; edx:eax <- a/2+b*b-a*b*c+x+e = 73
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

