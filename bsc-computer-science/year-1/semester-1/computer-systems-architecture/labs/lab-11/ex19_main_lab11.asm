bits 32 ; assembling for the 32 bits architecture

global start        
extern exit, fopen, fread, fclose, fscanf, printf, adaugareneg, adaugarepoz    
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    nume_fisier db "data.txt", 0
    mod_acces db "r", 0
    descriptor_fis dd -1
    len equ 100
    lungime dd 0
    n dd 0
    format_citire db "%d", 0
    numere times len db 0 ; sirul in care se vor citi numerele
    pozitive times len db 0
    negative times len db 0
    lungime_pozitive dd 0
    lungime_negative dd 0

segment code use32 class=code; 19.Se citesc din fisierul numere.txt mai multe numere (pozitive si negative). Sa se creeze 2 siruri rezultat N si P    astfel: N - doar numere negative si P - doar numere pozitive. Afisati cele 2 siruri rezultate pe ecran.
    start:
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2; eliberam stiva
        
        mov [descriptor_fis], eax ; salvam valoarea returnata de fopen in variabila descriptor_fis
        cmp eax, 0
        je final
        
        mov edi, dword numere
        
        citire: ;citesc numar cu numar
        ; EAX = fscanf(descriptor_fisier, format_citire, &n)
        push dword n
        push dword format_citire   
        push dword [descriptor_fis]
        call [fscanf] ; n <- numar din fisier
        add esp, 3*4
        
        cmp eax, 1
        jne final
        mov eax, [n]
        
        cmp eax, 0
        jl aicia
        inc dword [lungime_pozitive];salvare lungimi siruri
        jmp dupa
        aicia:
        inc dword [lungime_negative]
        dupa:
        
        stosb; adaugare in numere
        inc dword [lungime]
        jmp citire
        final:
        
        mov edx, numere
        mov ebx, negative
        mov ecx, [lungime]
        call adaugareneg
        
        mov edx, numere
        mov ebx, pozitive
        mov ecx, [lungime]
        call adaugarepoz
        
        mov ecx, [lungime_negative]
        cld
        mov esi, negative
        repeta:
        lodsb
        cbw
        cwde
        push ecx
        push eax
        push dword format_citire
        call [printf] ; apelam functia printf pentru afisare
        add esp, 4*2
        pop ecx
        loop repeta
        
        mov ecx, [lungime_pozitive]
        cld
        mov esi, pozitive
        repeta1:
        lodsb
        cbw
        cwde
        push ecx
        push eax
        push dword format_citire
        call [printf] ; apelam functia printf pentru afisare
        add esp, 4*2
        pop ecx
        loop repeta1
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program 
