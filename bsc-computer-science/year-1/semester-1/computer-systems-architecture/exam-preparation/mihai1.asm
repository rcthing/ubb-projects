bits 32 ;assembling for the 32 bits architecture

global start

; we ask the assembler to give global visibility to the symbol called start 
;(the start label will be the entry point in the program) 
extern exit, printf, scanf, fopen, fread, fprintf, fclose 
import exit msvcrt.dll 
import printf msvcrt.dll 
import scanf msvcrt.dll 
import fopen msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll 
import fclose msvcrt.dll

segment data use32 class=data
    final_string times 100 db 0
    rword dd 0

; Se citeste o propozitie de la tastatura. Sa se numere literele din fiecare cuvant si
; sa se afiseze aceste numere pe ecran.
segment code use32 class=code
    start:
        mov eax, 0
        mov edi, final_string
        
        ; exit(0)
        push dword 0 ; saves on stack the parameter of the function exit
        call [exit] ; function exit is called in order to end the execution of