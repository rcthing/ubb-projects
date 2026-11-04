bits 32 

global start        

extern exit, fopen, fread, fclose,printf               
import exit msvcrt.dll    
import fopen msvcrt.dll   
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll 

segment data use32 class=data
    nume_fisier db "data.txt",0
    mod_acces db "r",0
    format_afisare db "Numarul de vocale din acest text este de %d",0
    len equ 100 ; nr max de elem din fisier
    sir times (len+1) db 0 ; sirul in care vom citi textul
    descriptor_fis dd -1
    vocale db 'a','e','i','o','u', 0
    

segment code use32 class=code
    start:
    push dword mod_acces
    push dword nume_fisier
    call [fopen]
    add esp, 4*2
    
    mov [descriptor_fis], eax
    cmp eax, 0
    je final
    
    push dword [descriptor_fis]
    push dword len
    push dword 1
    push dword sir
    call [fread]
    add esp, 4*4
    
    mov ecx, eax
    mov ebx, 0
    mov esi, 0
    
    loop_mare
    mov edi, 0
    
    loop_verif:
    mov al, [sir+esi]
    cmp al, [vocale+edi]
    je adauga
    inc edi
    cmp edi, 6
    jb loop_verif
    jmp sari
    
    adauga:
    inc ebx
    
    sari:
    
    inc esi
    loop loop_mare
    
    
    
    
    push ebx
    push dword format_afisare
    call [printf]
    add esp, 4*2
    
    push dword [descriptor_fis]
    call [fclose]
    add esp, 4
    
    final:
    push    dword 0      
    call    [exit]   