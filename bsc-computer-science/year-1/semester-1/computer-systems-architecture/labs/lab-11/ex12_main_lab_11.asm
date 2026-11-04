bits 32 ; assembling for the 32 bits architecture

global start        

extern exit, printf, scanf, intercalare               
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
    start:
        ;punem pe stiva offsetul celor trei siruri si lungimea celor doua
        push dword sir1; esp +8
        push dword sir2; esp+4
        push dword sir3;esp
        mov ecx, len
        
        call intercalare
        
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
