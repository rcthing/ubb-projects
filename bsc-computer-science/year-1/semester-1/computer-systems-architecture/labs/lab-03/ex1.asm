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
    c dd 14
    d dq 2

; our code starts here
segment code use32 class=code
    start:
    ;FARA SEMN
    ; c-(a+d)+(b+d)=13
        movzx eax, byte[a]; eax <- a;
        mov edx, 0; edx:eax <- a
        mov ecx, dword[d+4]
        mov ebx, dword[d+0]; ecx:ebx <- d
        add ebx, eax
        adc ecx, edx; ecx:ebx <- (a+d)
        mov eax,[c]; eax <- c
        mov edx, 0; edx:eax <- c
        sub eax, ebx
        sbb edx, ecx; edx:eax <- c-(a+d)
        mov ecx, edx
        mov ebx, eax; ecx:ebx <- c-(a+d)
        movzx eax, word[b]
        mov edx, 0; edx:eax <- b
        add eax, dword[d+0]
        adc edx, dword[d+4]; edx:eax <- (b+d)
        add eax, ebx
        adc edx, ecx; edx:eax <- c-(a+d)+(b+d)=13
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

