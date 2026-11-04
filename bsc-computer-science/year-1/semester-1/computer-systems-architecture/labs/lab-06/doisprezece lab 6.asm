bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 12345678h, 1A2C3C4Dh, 98FCDD76h, 12783A2Bh
    l equ ($-a)/4; lungimea sirului in dwords
    b1 times l db 0; rezervam l OCTETI pentru stocarea sirului 
    b2 times l db 0; rezervam l OCTETI pentru stocarea sirului

; our code starts here
segment code use32 class=code
    start:
        ; 12. Se da un sir A de dublucuvinte. Cunstruiti doua siruri de octeti  
              ;- B1: contine ca elemente partea inferioara a cuvintelor inferioara din A
              ;- B2: contine ca elemente partea superioara a cuvintelor superioare din A
        mov esi, a; sirul sursa
        mov edi, b1; sirul destinatie
        cld;parcurgem sirul de la stanga la dreapta (DF=0)
        mov ecx, l; ecx <- lungime sir
        jecxz final
        
        repeta:
                lodsb; in al avem partea inferioara a cuvintelor inferioara din a
                stosb; stocam in b1
                lodsw
                lodsb
        loop repeta;daca mai sunt elemente de parcurs(ecx>0) reia ciclul
        
        mov esi, a; sirul sursa
        mov edi, b2; sirul destinatie
        cld;parcurgem sirul de la stanga la dreapta (DF=0)
        mov ecx, l; ecx <- lungime sir
        
        repeta1:
                lodsw
                lodsb
                lodsb; in al avem partea sup a cuvintelor sup din a
                stosb; stocam in b2
        loop repeta1;daca mai sunt elemente de parcurs(ecx>0) reia ciclul
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
