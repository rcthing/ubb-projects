bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db -5
    b dd 4
    c dq 1ad3fa44h
    sapte equ 7
    doi equ 2

; our code starts here
segment code use32 class=code
    start:
    ; CU SEMN
    ; c+(a*a-b+7)/(2+a)=14
        mov al, [a]; al <- a
        imul byte[a]; ax <- a*a
        sub ax, [b]; ax <- a*a-b
        add ax, sapte; ax <- (a*a-b+7)
        mov bl, [a]; bl <- a
        add bl, doi; bl <- (2+a)
        idiv bl; al <- (a*a-b+7)/(2+a)
        cbw; ax <- al
        cwde; eax <- ax
        cdq; edx:eax <- eax adica (a*a-b+7)/(2+a)
        mov ebx, [c+0]
        mov ecx, [c+4]; ecx:ebx <- c
        add eax, ebx
        adc edx, ecx; edx:eax <- c+(a*a-b+7)/(2+a)
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

