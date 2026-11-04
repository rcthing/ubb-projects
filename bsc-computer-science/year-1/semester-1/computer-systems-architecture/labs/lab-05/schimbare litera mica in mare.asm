bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 'a','B','C','d'; declaram sirul
    l equ $-s; lungimea sirului
    d resb l; sirul nou de lungime l

; our code starts here
segment code use32 class=code
    start:    ;Facem literele mici mari
    
        mov ecx, l; ecx <- lungime sir
        mov esi, 0; index <- 0
        jecxz final; daca lungime sir == 0 sare la final
        
        inceput_loop:; face loop de ecx ori
            mov al, [s+esi]; al <- [s+esi]
            cmp al, 'Z'; compara [s+esi] cu 'Z'
            jbe pune; daca al <= 'Z' il pune direct
            ja transforma; daca al > 'Z' il transforma si dupa il pune
        
        transforma:
            sub al, 'a'-'A'; face din litera mica litera mare
        
        pune:
            mov [d+esi], al; il pune in sirul d
            inc esi; esi++
            loop inceput_loop; reface loop-ul
            
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
