bits 32

global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

%include "ex13_module.asm"

; Se dau trei siruri de caractere. Sa se afiseze cel mai lung sufix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma.
    
segment data use32 class=data
    
    message db "Introduceti un sir de caractere: ", 0
    string_format db "%s", 0 
    display_format db "%s", 10, 0
    
    max equ 100
    
    str1 times max db 0
    str2 times max db 0
    str3 times max db 0
    
    len1 dd 0
    len2 dd 0
    len3 dd 0
    
    s12 times max db 0
    s23 times max db 0
    s31 times max db 0

segment code use32 class=code

    start:
        
        push dword message
        push dword string_format
        call [printf]
        add esp, 4*2
        
        ; Citim sirul 1
        push dword str1
        push dword string_format
        call [scanf]
        add esp, 4*2
        
        push dword message
        push dword string_format
        call [printf]
        add esp, 4*2
        
        ; Citim sirul 2
        push dword str2
        push dword string_format
        call [scanf]
        add esp, 4*2
        
        push dword message
        push dword string_format
        call [printf]
        add esp, 4*2
        
        ; Citim sirul 3
        push dword str3
        push dword string_format
        call [scanf]
        add esp, 4*2
        
        ; Aflam lungimea fiecarui sir, iar rezultatele se pastreaza in varibilele len
        push dword str1
        call get_len
        mov [len1], edx
        
        push dword str2
        call get_len
        mov [len2], edx
        
        push dword str3
        call get_len
        mov [len3], edx
        
        ; Pentru fiecare pereche de siruri se apeleaza functia si se scrie apoi rezultatul
        push dword s12
        push dword str1
        push dword str2
        push dword [len1]
        push dword [len2]
        call sufix_comun
        
        push dword s12
        push dword display_format
        call [printf]
        add esp, 4*2
        
        push dword s23
        push dword str2
        push dword str3
        push dword [len2]
        push dword [len3]
        call sufix_comun
        
        push dword s23
        push dword display_format
        call [printf]
        add esp, 4*2
        
        push dword s31
        push dword str3
        push dword str1
        push dword [len3]
        push dword [len1]
        call sufix_comun
        
        push dword s31
        push dword display_format
        call [printf]
        add esp, 4*2
        
        ; sufixele se afiseaza fiecare pe alt rand pentru perechile (sir1,sir2),(sir2,sir3),(sir3,sir1)
        
    push dword 0
    call [exit]