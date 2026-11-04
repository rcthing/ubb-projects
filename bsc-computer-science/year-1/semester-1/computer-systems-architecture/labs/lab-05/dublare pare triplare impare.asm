bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 1,2,3,4,5,6; declaram sirul
    l equ $-s; lungimea sirului
    d resb l; sirul nou de lungime l

; our code starts here
segment code use32 class=code
    start:    ;Dublam numerele pare si le triplam pe cele imare
    
        mov ecx, l; ecx <- lungime sir
        mov esi, 0; index <- 0
        jecxz final; daca lungime sir == 0 sare la final
        
        inceput_loop:; face loop de ecx ori
            mov al, [s+esi]; al <- [s+esi]
            cbw; ax <- al
            mov bl, 2
            idiv bl; ah <- [s+esi]%2
            cmp ah, 0; compara restul cu 0
            je dublare; daca ah == 0 (nr par) il dubleaza
            jne triplare; daca ah != 0 (nr impar) il tripleaza
        
        dublare:
            mov al, [s+esi]
            add al, [s+esi]; in al avem nr x 2
            jmp adaugare; sare direct la adaugare ca sa nu faca si triplarea dupa dublare
        
        triplare:
            mov al, [s+esi]
            add al, [s+esi]
            add al, [s+esi]; in al avem nr x 3
        
        adaugare:
            mov[d+esi], al; il pune in d
            inc esi; esi++
            loop inceput_loop; reface loop-ul
            
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
