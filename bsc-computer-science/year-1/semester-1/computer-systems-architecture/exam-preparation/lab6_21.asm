bits 32 

global start        

extern exit               
import exit msvcrt.dll    
;Dandu-se un sir de cuvinte sa se obtina sirul (de octeti) cifrelor in baza zece ale fiecarui cuvant din acest sir.
; Exemplu:
; daca avem sirul:
;      sir DW 12345, 20778, 4596 
; obtinem rezultatul
;      1, 2, 3, 4, 5, 2, 0, 7, 7, 8, 4, 5, 9, 6.
segment data use32 class=data
    sir dw 12345, 20778, 4596 
    lensir equ ($-sir)/2
    len equ ($-sir)*5
    rez times len db 0
    z dw 10
    pasi db 0

segment code use32 class=code
    start:
    mov bx, 10
    mov esi, sir
    mov edi, rez
    mov ecx, lensir
    sus:
    push ecx
    mov ecx, 0
    lodsw
    cwd
    repeta:
        div bx
        push dx 
        inc ecx
        mov dx, 0
        cmp ax, 0
        jne repeta
    
    loop1:
    pop ax
    stosb
    loop loop1
    
    pop ecx
    loop sus
    
    
        
    
    push    dword 0      
    call    [exit]       
