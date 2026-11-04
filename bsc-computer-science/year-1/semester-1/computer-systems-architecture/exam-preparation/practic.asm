;Sa se scrie un program care citeste un fisier text care contine propozitii (propozitiile sunt separate de caracterul '/') si scrie intr-un alt fisier doar propozitiile de ordin de forma 2k+1 (i.e. scrie propozitia 1, 3, 5 ..). Numele celor 2 fisiere se dau in segmentul de date.

bits 32 

global start        

extern exit, fopen, fread, fclose, fprintf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "dat.txt", 0  ; numele fisierului care va fi deschis
    nume_fisier2 db "out.txt", 0  ; numele fisierului care va fi deschis
    mod_acces db "r", 0          ; modul de deschidere a fisierului - 
    mod_acces2 db "w", 0          ; modul de deschidere a fisierului - 
    
    descriptor_fis dd -1         ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
    descriptor_fis2 dd -1
    len equ 100                  ; numarul maxim de elemente citite din fisier.                            
    text times len db 0          ; sirul in care se va citi textul din fisier  
    rez times len db 0          ; sirul in care se vor pune propozitiile 
    doi db 2
    unu equ 1

segment code use32 class=code
    start:
        ; apelam fopen pentru a deschide fisierul dat.txt
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2    
        
        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je final

        ; apelam fopen pentru a deschide fisierul out.txt
        push dword mod_acces2     
        push dword nume_fisier2
        call [fopen]
        add esp, 4*2  

        mov [descriptor_fis2], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis2
        
        cmp eax, 0
        je final
        
        ; citim textul in fisierul deschis folosind functia fread
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4    

        mov ecx, eax
        mov eax, 0
        mov esi, text
        mov edi, rez
        mov bx, 1
        
        repeta:
        lodsb
        
        cmp al, '/'
        jne peste
        inc bx
        
        peste:
        
        push eax
        mov ax, bx
        div byte[doi]; in ah avem restul
        cmp ah, unu
        jne sari
        
        pop eax
        stosb
      
        sari:
        
        loop repeta
        
        ; adaugam/scriem textul in fisierul deschis folosind functia fprintf
        push dword rez
        push dword [descriptor_fis2]
        call [fprintf]
        add esp, 4*2
        
        
        ; apelam functia fclose pentru a inchide fisierul
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
      final:
        
        ; exit(0)
        push    dword 0      
        call    [exit]       
