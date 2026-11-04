;Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine litera mica (lowercase) cu cea mai mare frecventa ;si sa se afiseze acea litera, impreuna cu frecventa acesteia. Numele fisierului text este definit in segmentul de date.
bits 32 

global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "ana.txt", 0  ; numele fisierului care va fi creat
    mod_acces db "r",0
    descriptor_fis dd -1
    len equ 100
    lungime dd 0
    sir times len db
    cmax dd 0
    format_afisare dd "caracterul cu cea mai mare frecventa este %c, iar frecventa lui este de %d", 0

; our code starts here
segment code use32 class=code
    start:
        push dword mod_acces;deschidem fisierul
        push dword nume_fisier
        call [fopen]; in eax avem descriptorul
        add esp, 4*2
        
        mov [descriptor_fis], eax
        cmp eax, 0
        je final
        
        push dword [descriptor_fis];citim din fisier si punem in sir
        push dword len
        push dword 1
        push dword sir
        call [fread]
        add esp, 4*4
        
        mov edx, 0
        mov ecx, eax
        mov [lungime], al
        mov bl, 0
        mov dl, 0;aparitii maxime
        mov esi, 0
        
        loop1:
        push ecx
        mov ecx, [lungime]
        mov al, [sir+esi]
        mov edi, 0
        mov bl, 0
        
            loop2:
            cmp al, [sir+edi]
            jne sari
            inc bl
            sari:
            inc edi
            loop loop2
            
            cmp bl, dl
            jbe sari1
            mov dl, bl
            mov [cmax], al
            sari1:
            
        inc esi
        pop ecx
        loop loop1
        
        mov eax, 0
        mov al, [cmax]
        push edx
        push eax
        push dword format_afisare
        call [printf]
        add esp, 4*3
            
            
        
        
        
        
        
        
        
        
        
      final:
        
        ; exit(0)
        push    dword 0      
        call    [exit]       