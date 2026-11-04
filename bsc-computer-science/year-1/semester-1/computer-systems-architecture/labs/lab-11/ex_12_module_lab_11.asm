bits 32 ; assembling for the 32 bits architecture

global intercalare

segment code use32 class=code

    intercalare:
        mov esi, [esp+12]; esi <- sir1
        mov edi, [esp+4]; edi <- sir 3
        mov ebx, ecx
        repet:
            lodsb; al <- sir1[i]
            stosb; punem in sir 3
            inc edi; inc edi ca sa mergem din doi in doi pentru intercalare
        loop repet
        
        mov esi, [esp+8]; esi <- sir2
        mov edi, [esp+4]; edi <- sir 3
        mov ecx, ebx;ecx <- len
        inc edi; inc edi ca sa le intercalam
        
        repett:
            lodsb; al <- sir2[i]
            stosb; punem in sir 3
            inc edi; inc edi ca sa mergem din doi in doi pentru intercalare
        loop repett
        ret 4*3
    

