bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 9
    b db 1
    c db 2
    d db 4
    e dw 3
    f dw 5
    g dw 8
    h dw 5

; our code starts here
segment code use32 class=code
    start:
    ; (f*g-a*b*e)/(h+c*d)
        mov ax,[f]; ax<- f
        mul word [g]; dx:ax<-ax*g (am vazut ca se pune in ax daca nu depaseste)
        push dx
        push ax
        pop ecx ;ecx <- ax*g
        mov al,[a]; al<- a
        mul byte [b]; ax<-a*b
        mul word [e]; dx:ax <-a*b*e
        push dx
        push ax
        pop edx ;edx <-a*b*e
        sub ecx,edx; ecx<- ecx-edx sau (f*g-a*b*e)
        mov al,[c]; al <- c
        mul byte [d]; ax<- c*d
        mov bx, [h]; bx <- h
        add ebx,eax; ebx <- (h+c*d)
        mov eax,ecx; eax <- ecx
        div ebx; ax <- eax/ebx

        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

