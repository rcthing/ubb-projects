bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir dw 12345, 20778, 4596
    l equ ($-sir); lungimea sirului in bytes    
    sir_nou times l db 0; rezervam l OCTETI pentru stocarea sirului

; our code starts here
segment code use32 class=code
    start:
        ;21. Dandu-se un sir de cuvinte sa se obtina sirul (de octeti) cifrelor in baza zece ale fiecarui cuvant din acest sir.
        mov esi, sir
        mov edi, sir_nou
        cld; parcurgem sirul de la stanga la dreapta (DF=0)
        mov ecx, l; ecx <- lungime sir
        jecxz final
        
        repeta:
                lodsb;al <- primul octet
                loop repeta; cat timp ecx>0
    
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
