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
    ; c-(a+d)+(b+d)
        movzx eax, byte[a]; eax <- a;
        cdq; edx:eax <- a
        mov ecx, dword[d+0]]
        mov ebx, dword[d+4]; ecx:ebx <- d
        add ebx, eax
        adc ecx, edx; ecx:ebx <- (a+d)
        movzx eax, dword[c]; eax <- c
        cdq; edx:eax <- c
        sub eax, ebx
        sbb edx, ecx; edx:eax <- c-(a+d)
        mov ecx, edx
        mov ebx, eax; ecx:ebx <- c-(a+d)
        movzx eax, dword[b]
        cdq; edx:eax <- b
        add eax, [d+0]
        adc edx, [d+4]; edx:eax <- (b+d)
        add eax, ebx
        adc edx, ecx; edx:eax <- c-(a+d)+(b+d)
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

