bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 1, 2, 3, 4; declaram sirul
    l equ $-s; lungimea sirului
    d resw l-1; sirul nou de lungime l-1

; our code starts here
segment code use32 class=code
    start:    ;Produsul dintre fiecare 2 elemente consecutive S(i) si S(i+1)
    
        mov ecx, l-1; ecx <- lungime sir nou (l-1)
        mov esi, 0; index <- 0
        jecxz final; daca lungime sir == 0 sare la final
        
        inceput_loop:; face loop de ecx ori
            mov al, [s+esi]; al <- [s+esi]
            mov bl, [s+esi+1]; bl <- urmatorul element
            imul bl; ax <- al*bl sau (s[i] * s[i+1])
            mov[d+esi], al; il pune in d
            inc esi; esi++
            loop inceput_loop; reface loop-ul
            
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
