bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 5
    b db 8
    c db 2
    d dd 10
    e dq 7

; our code starts here
segment code use32 class=code
    start:
        ;CU SEMN
        ; 2/(a+b*c-9)+e-d = 
        mov al, [b]
        mov bl, [c]
        imul bl ; ax <- b*c
        movsx bx, byte[a] ; bx <- a
        add bx, ax ; bx <- a+b*c
        sub bx, 9 ; bx <- (a+b*c-9)
        mov ax, 2
        cwd ; dx:ax <- 2
        div bx ; ax rest dx
        movsx eax, ax ; eax <- 2/(a+b*c-9)
        cdq ; edx:eax <- 2/(a+b*c-9)
        mov ebx, dword[e+0]
        mov ecx, dword[e+4] ; ecx:ebx <- e
        add ebx, eax
        adc ecx, edx ; ecx:ebx <- 2/(a+b*c-9)+e
        mov eax, [d]
        cdq ; edx:eax <- d
        sub ebx, eax
        sbb ecx, edx ; ecx:ebx <- 2/(a+b*c-9)+e-d
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
