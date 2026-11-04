bits 32

global start

extern exit, printf, scanf, fopen, fread, fprintf, fclose
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

%include "ex18_module.asm"

; Se citeste de la tastatura un sir de numere in baza 10 fara semn. Sa se determine valoarea minima din sir si sa se afiseze in fisierul min.txt (fisierul va fi creat) valoarea minima, in baza 16
    
segment data use32 class=data
    
    len db 0
    input dd 0
    min dd 0xFFFFFFFF
    
    dformat db '%d', 0
    hformat db '%x', 0
    
    access_mode db 'w', 0
    file_name db 'min.txt', 0
    file_descriptor resd 1 
    
    how_many db "Introduceti numarul de numere dorit: ", 10, '   > ', 0
    give_number db "Introduceti un numar pozitiv in baza 10: ", 0

segment code use32 class=code

    start:
        
        push dword how_many
        call [printf]
        add esp, 4*1
        
        push dword len
        push dword dformat
        call [scanf]
        add esp, 4*2
        
        mov ecx, [len]
    read:

        PUSHAD
        
        push dword give_number
        call [printf]
        add esp, 4*1
            
        push dword input
        push dword dformat
        call [scanf]
        add esp, 4*2

        push dword [input]
        push dword [min]
        call function
        add esp, 4*2
            
        mov [min], eax
            
        POPAD
    
        loop read

        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        push dword [min]
        push dword hformat
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*3
        
        push dword [file_descriptor]
        call [fclose]
        
    push dword 0
    call [exit]