;19.	Sa se citeasca de la tastatura un numar n, apoi sa se citeasca mai multe cuvinte, 
;pana cand se citeste cuvantul/caracterul "#". Sa se scrie intr-un fisier text toate cuvintele 
;citite care incep si se termina cu aceeasi litera si au cel putin n litere.
bits 32

global start        

extern exit, printf, scanf, fopen, fprintf, fclose 
import exit msvcrt.dll 
import printf msvcrt.dll 
import scanf msvcrt.dll 
import fopen msvcrt.dll 
import fprintf msvcrt.dll 
import fclose msvcrt.dll

segment data use32 class=data
    n dd 0
    cuvant times 30 db 0
    mesaj1 db "n= ",0
    mesaj2 db "cuvant: ", 0
    format1 db "%d", 0
    format2 db "%s", 0
    diez db '#', 0
    nume_fisier db "lalele.txt", 0
    mod_acces db "w", 0
    descriptor_fis dd -1

segment code use32 class=code
    start:
        ; deschidem fisier
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2  
        
        ;verificam daca s-a deschis
        mov [descriptor_fis], eax
        cmp eax, 0
        je final
        
        ;afisam "n= "
        push dword mesaj1
        call [printf]
        add esp, 4*1
        
        ;citim n
        push dword n
        push dword format1
        call [scanf]
        add esp, 4*2
        
        repeta:
        ;afisam "cuvant: "
        push dword mesaj2
        call [printf]
        add esp, 4*1
        
        ;cuvant <- citim cuvantul
        push dword cuvant
        push dword format2
        call [scanf]
        add esp, 4*2
        
        ;verif sa nu fie #
        mov bl, [cuvant]
        cmp bl, [diez]
        je afara
        
        ;calculare lungime in ecx
        mov esi, cuvant
        mov edi, esi
        
        repet:
        lodsb
        cmp byte[esi], 0
        je gata
        jmp repet
        
        gata:
        sub esi, edi
        mov ecx, esi
        
        
        ;verif lungime >= n
        cmp cl, [n]
        jb sari_peste_cuvant
        
        ;verif prima si ultima cifra
        dec ecx
        mov bl, [cuvant]
        cmp bl, [cuvant + ecx]
        jne sari_peste_cuvant
        
        ;adaugam cuvantul in fisier
        push dword cuvant
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*2
        
        sari_peste_cuvant:
        
        jmp repeta
        
        afara:
        
        ;inchidem fisierul
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
