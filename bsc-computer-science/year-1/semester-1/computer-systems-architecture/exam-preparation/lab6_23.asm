bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Dandu-se un sir de octeti sa se obtina un sir de cuvinte care sa contina in octetii inferiori multimea caracterelor din sirul de octeti, iar octetul superior al unui cuvant sa contina numarul de aparitii al octetului inferior din acel cuvant in sirul de octeti dat.
;rez DW 0402h, 0304h, 0105h.
segment data use32 class=data
    sir db 2, 4, 2, 5, 2, 2, 4, 4
    len equ $-sir
    rez times len dw 0
    sir2 db 0

; our code starts here
segment code use32 class=code
    start:
        mov ecx, len
        dec ecx
        jecxz final
        mov esi, 0
        
        loop1: ;ordonare sir crescator
        mov al, [sir+esi]
        mov ebx, esi
        inc ebx
        
            loop2:
            mov dl, [sir+ebx]
            cmp al, dl
            jbe sari
            mov [sir+esi], dl
            mov [sir+ebx], al
            mov al, dl
            sari:
            inc ebx
            cmp ebx,len
            jb loop2
            
        inc esi    
        loop loop1
        
        mov esi, sir
        mov edi, rez
        mov ecx, 0
        
        sus:
        mov bl, [esi]
        mov edx, 0
        
        repeta:
        lodsb
        cmp al, bl
        jne aici
        inc edx
        jmp repeta  
        
        aici:
        dec esi
        mov eax, edx
        stosb
        mov al, bl
        stosb
        add ecx, edx
        cmp ecx, len
        jb sus
        
    final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
