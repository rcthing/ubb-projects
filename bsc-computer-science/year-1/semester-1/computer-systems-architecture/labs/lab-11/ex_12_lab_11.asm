bits 32
global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

;12. Se dau doua siruri de caractere de lungimi egale. Se cere sa se calculeze si sa se afiseze rezultatele intercalarii literelor, pentru cele doua intercalari posibile (literele din primul sir pe pozitii pare, respectiv literele din primul sir pe pozitii impare).

segment data use32 class=data
    sir1 db "abcdefg",13,10,0
    len equ $-sir1-1
    sir2 db "hijklmn",13,10,0
    sir3 times len*2 db 0,13,10,0
    message1 db "sir1= ",0
    message2 db "sir2= ",0
    message3 db "sir3= ",0
    

; our code starts here
segment code use32 class=code

    intercalarea1:
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
        
    intercalarea2:
        mov esi, [esp+8]; esi <- sir2
        mov edi, [esp+4]; edi <- sir3
        mov ebx, ecx
        repeta:
            lodsb; al <- sir1[i]
            stosb; punem in sir 3
            inc edi; inc edi ca sa mergem din doi in doi pentru intercalare
        loop repeta
        
        mov esi, [esp+12]; esi <- sir1
        mov edi, [esp+4]; edi <- sir3
        mov ecx, ebx;ecx <- len
        inc edi; inc edi ca sa le intercalam
        
        repetta:
            lodsb; al <- sir2[i]
            stosb; punem in sir 3
            inc edi; inc edi ca sa mergem din doi in doi pentru intercalare
        loop repetta
        ret 4*3
        
        
        
    start:
        ;punem pe stiva offsetul celor trei siruri si lungimea celor doua
        push dword sir1; esp +8
        push dword sir2; esp+4
        push dword sir3;esp
        mov ecx, len
        
        call intercalarea2
        
        push dword message1 ; ! pe stiva se pune adresa string-ului, nu valoarea
        call [printf] ; apelam functia printf pentru afisare
        add esp, 4*1
        push dword sir1 ; ! pe stiva se pune adresa string-ului, nu valoarea
        call [printf] ; apelam functia printf pentru afisare
        add esp, 4*1 ; eliberam parametrii de pe stiva
        
        push dword message2 ; ! pe stiva se pune adresa string-ului, nu valoarea
        call [printf] ; apelam functia printf pentru afisare
        add esp, 4*1
        push dword sir2 ; ! pe stiva se pune adresa string-ului, nu valoarea
        call [printf] ; apelam functia printf pentru afisare
        add esp, 4*1 
        
        push dword message3 ; ! pe stiva se pune adresa string-ului, nu valoarea
        call [printf] ; apelam functia printf pentru afisare
        add esp, 4*1
        push dword sir3 ; ! pe stiva se pune adresa string-ului, nu valoarea
        call [printf] ; apelam functia printf pentru afisare
        add esp, 4*1
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        
        
        
        
        
        
        
        
        
