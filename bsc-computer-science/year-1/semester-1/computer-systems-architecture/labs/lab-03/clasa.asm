bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dq 1122334455667788h
    b dq 49588723F1AABBCCh
    rez resq 1
    ct equ 10

; our code starts here
segment code use32 class=code
    start:
        ;edx:eax <- a
        mov eax, [a+0]
        mov edx, [a+4]
        ;ebx:ecx <- b
        mov ebx, [b+0]
        mov ecx, [b+4]
        clc; CF <- 0
        add eax, ebx; CF <-1
        adc edx, ecx ;edx <- edx+ecx+CF
                     ;edx:eax <- a+b
        ;Salvare in memorie
        mov [rez+0], eax
        mov [rez+4], edx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

