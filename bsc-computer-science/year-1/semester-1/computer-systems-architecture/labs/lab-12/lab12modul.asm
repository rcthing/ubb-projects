bits 32 ; assembling for the 32 bits architecture

global _prefixcomun       

segment data public data use32
    
segment code public code use32

; int _prefixcomun(char s1[], char s2[])
        ;return l=lungimea prefixului
_prefixcomun:
    ;crearea cadrului de stiva
    push ebp
    mov ebp, esp
    
    mov eax, 0;in eax vom avea rezultatul
    mov edi, [esp+8];edi <- adresa primului sir
    mov esi, [esp+12];esi <- adresa de la al doilea sir
    mov ecx, [esp+16]; ecx <- lungime sir1
    mov edx, [esp+20];edx <- lungime sir 2
    
    add edi, ecx
    add esi, edx
    
    gasireprefix:
        mov bl, [edi]     ;sir1[i]
        cmp bl, 0         ;daca da de zero se termina
        je final
        
        cmp bl, [esi]     ;compara sir1[i] cu sir2[i]
        jne final         ;daca nu sunt egale sare la final
        
        dec esi           ;urm element
        dec edi           ;urm element
        inc eax           ;incrementam contorul
        jmp gasireprefix
        
final:
    mov esp, ebp
    pop ebp
    ret
