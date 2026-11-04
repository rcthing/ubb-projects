bits 32 ; assembling for the 32 bits architecture

global start        

extern exit

import exit msvcrt.dll    

segment data use32 class=data
    a dw 1010110111000011b
    b dw 1000010111100110b
    c dd 0

; our code starts here
segment code use32 class=code                     001111000
; Se dau cuvintele A si B. Se cere dublucuvantul C:
; bitii 0-5 ai lui C coincid cu bitii 3-8 ai lui A
; bitii 6-8 ai lui C coincid cu bitii 2-4 ai lui B
; bitii 9-15 ai lui C reprezinta bitii 6-12 ai lui A 1111111111111111
; bitii 16-31 ai lui C sunt 0
    start:
        mov eax, 0
        mov ebx, 0
        mov ecx, 0; rezultatul
        
        mov ax, [a] ; bitii 0-5 ai lui C coincid cu bitii 3-8 ai lui A        
        and ax, 0000000111111000b 
        shr ax, 3
        or ecx, eax
        
        mov bx,[b]; bitii 6-8 ai lui C coincid cu bitii 2-4 ai lui B
        and bx, 0000000000011100b 
        rol bx, 4
        or ecx, ebx
        
        mov eax, 0
        mov ax, [a]
        and ax, 0001111111000000b
        rol ax, 3
        or ecx, eax; bitii 9-15 ai lui C reprezinta bitii 6-12 ai lui A
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
