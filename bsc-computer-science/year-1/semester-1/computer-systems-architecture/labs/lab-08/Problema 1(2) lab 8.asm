bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll


                          

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "vocale.txt", 0
    mod_acces db "r", 0
    descriptor_fis dd -1
    len equ 100
    vocale db "aeiou", 0
    text times len db 0 ; sirul in care se va citi textul din fisier
    aux_esi dd 0
    rez db 0

; our code starts here
segment code use32 class=code
    start:
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2 ; eliberam parametrii de pe stiva
        
        mov [descriptor_fis], eax ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        cmp eax, 0
        je final
        
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        mov esi, text
        
        citeste_caracter:
        lodsb; al <- byte de la adresa esi, inc esi
        cmp al, 0
        je final
        mov bl, al
        mov ecx, 5
        mov dword[aux_esi], esi
        mov esi, vocale
        
        repeta:
        lodsb
        cmp al, bl
        je incrementare
        jmp dupa
      
        incrementare:
        inc byte[rez]
        
        dupa:
        loop repeta
        
        mov esi, [aux_esi]
        
        jmp citeste_caracter
        
        
        final:
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
