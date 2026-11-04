bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dd 127F5678h, 0ABCDABCDh
    l equ ($-s)/4
    b resd 1
    s_par dw 0
    s_impar dw 0

; our code starts here
segment code use32 class=code
    start:
        ;1. Se da un sir de dublucuvinte continand date impachetate (4 octeti scrisi ca un singur dublucuvant). Sa se obtina un nou sir de dublucuvinte, in care fiecare dublucuvant se va obtine dupa regula: suma octetilor de ordin impar va forma cuvantul de ordin impar, iar suma octetilor de ordin par va forma cuvantul de ordin par. Octetii se considera numere cu semn, astfel ca extensiile pe cuvant se vor realiza corespunzator aritmeticii cu semn.
    
        mov ecx, 4
        mov esi, s
        mov edi, b
        
        parcurge:
            mov [aux], ecx
            mov ax, 0
            mov [s_par], ax
            mov [s_impar], ax
        formare:
            mov al, cl 
            cbw; ax <- cl
            mov bl, 2
            idiv bl; ah <- cl%2
            cmp ah, 0
            je aduna_par
            jne aduna_impar
            
        aduna_par:
            lodsb; al <- b
            cbw
            add [s_par], ax
            jmp gata
        
        aduna_impar:
            lodsb
            cbw
            add[s_impar], ax
        
        gata:
        loop formare; ecx <- ecx-1
        mov edi, b
        mov ax, s_impar
        stosw;
        mov ax, [s_impar]
        stosw
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
