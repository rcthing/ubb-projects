bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start   
extern exit, printf, scanf ; adaugam printf si scanf ca functii externa            
import exit msvcrt.dll    
import printf msvcrt.dll    ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll     ; similar pentru scanf    

; declare external functions needed by our program
extern exit, printf, scanf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    rezultat dq 0
    message1 db "a=", 0
    message2 db "b=", 0
    message3 db "a*b=", 0
    format db "%d", 0

; our code starts here
segment code use32 class=code
    start:
    
        ; vom apela printf(message) => se va afisa "a="
        ; punem parametrii pe stiva
        push dword message1 ; ! pe stiva se pune adresa string-ului, nu valoarea
        call [printf] ; apelam functia printf pentru afisare
        add esp, 4*1 ; eliberam parametrii de pe stiva
        ; vom apela scanf(format, a) => se va citi un numar in variabila a
        ; punem parametrii pe stiva de la dreapta la stanga
        push dword a ; ! adresa lui a, nu valoarea
        push dword format
        call [scanf] ; apelam functia scanf pentru citire
        add esp, 4*2 ; eliberam parametrii de pe stiva
        
        push dword message2
        call [printf] 
        add esp, 4*1 
        push dword b ; ! adresa lui b, nu valoarea
        push dword format
        call [scanf] 
        add esp, 4*2 ; eliberam parametrii de pe stiva
        
        mov eax, [a]
        imul dword [b]
        
        mov [rezultat + 4], edx
        mov [rezultat + 0], eax
       
        push dword message3
        call [printf]
        add esp, 4*1
       
        push dword [rezultat +4]
        push dword [rezultat]
        push dword format
        call [printf]
        add esp, 4*3
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
