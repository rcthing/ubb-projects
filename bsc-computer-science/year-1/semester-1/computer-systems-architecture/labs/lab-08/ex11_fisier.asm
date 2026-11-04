bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, fopen, fclose, fprintf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se 
    ; citeasca de la tastatura cuvinte si sa se scrie in fisier cuvintele citite pana cand se citeste de la tastatura caracterul '$'
    
    
    nume_fisier db "output.txt", 0
    mod_acces db "a", 0
    descriptor_fisier dd -1
    format db "%s", 0
   
    
    len equ 50
    cuvant times len db 0, 0
    spatiu db " ", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; fopen(nume_fisier, mod_acces)
        
        push dword mod_acces
        push dword nume_fisier
        
        call[fopen]
        
        add esp, 2*4
        
        cmp eax, 0
        je final
        
        mov [descriptor_fisier], eax ; am salvat descriptorul de fisier in eax
        
        citire:
            ;citim un cuvant de la tastatura
            ;scanf("%s", cuvant)
            
            push dword cuvant
            push dword format
            
            call[scanf]
            
            add esp, 2*4
            
            mov al, byte[cuvant]
            cmp al, '$' ; daca ultimul cuvant consta in caracterul $, programul se termina
            je final
            
            ;adaugam cuvantul in fisier
            ;fprintf(file_descriptor, text)
            
            push dword cuvant
            push dword [descriptor_fisier]
            
            call[fprintf]
            
            add esp, 2*4
            
            ; adaugam un spatiu dupa cuvant
            push dword spatiu
            push dword [descriptor_fisier]
            
            call[fprintf]
            
            add esp, 2*4
            
            
            jmp citire
        
        
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
