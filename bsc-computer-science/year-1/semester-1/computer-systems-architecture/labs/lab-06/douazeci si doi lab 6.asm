bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    input db 12h, 40h, 05h, 33h
    l equ ($-input); lungimea sirului in bytes
    src db 12h, 41h, 05h, 99h
    dst db 15h, 87h, 34h, 52h
    output times l db 0; rezervam l OCTETI pentru stocarea sirului
    aux_edi_src resd 1
    aux_edi_output resd 1
    aux_esi_dst resd 1
    aux_esi_input resd 1
    

; our code starts here
segment code use32 class=code
    start:
        ; Se da un sir de octeti 'input' si inca doua siruri de dimensiune N fiecare, 'src' si 'dst'. Sa se obtina un nou sir 'output' din sirul 'input' in care se vor inlocui toti octetii cu valoarea src[i] cu dst[i], unde i=1..N.
        ;output va fi 15, 40, 34, 33
        mov [aux_esi_input], dword input
        mov [aux_esi_dst], dword dst
        mov [aux_edi_src], dword src
        mov [aux_edi_output], dword output
        cld; parcurgem sirul de la stanga la dreapta (DF=0)
        mov ecx, l; ecx <- lungime sir
        jecxz final
        
        cauta:
                mov esi, [aux_esi_input]
                mov edi, [aux_edi_src]
                lodsb; al <- input[i] si inc esi
                
                scasb; cmp input[i] cu src[i] si inc edi(src)
                je adauga
                
                mov edi, [aux_edi_output]
                stosb; adauga in output al
                inc dword [aux_edi_output]; actualizare aux_edi_output
                inc dword [aux_esi_input]; actualizare aux_esi_input
                inc dword [aux_edi_src]; actualizare aux_edi_src
                inc dword [aux_esi_dst]; actualizare aux_edi_dst
                loop cauta; dec ecx
                jmp final; nu mai executa adauga dupa ce s-a termina loop-ul
                
        adauga:
                mov esi, [aux_esi_dst]
                lodsb; al <- dst[i] si inc esi
                mov edi, [aux_edi_output]
                stosb; adauga in output al
                inc dword [aux_edi_output]; actualizare aux_edi_output
                inc dword [aux_esi_input]; actualizare aux_esi_input
                inc dword [aux_edi_src]; actualizare aux_edi_src
                inc dword [aux_esi_dst]; actualizare aux_edi_dst
                dec ecx; deoarece nu s-a mai decrementat automat
                jmp cauta
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
