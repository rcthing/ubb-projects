bits 32

global adaugareneg
global adaugarepoz

segment code use32 class=code
        adaugareneg:
            mov esi,edx
            mov edi, ebx
        adauganeg:
            lodsb
            cmp al, 0
            jge sari
            stosb
            sari:
           loop adauganeg
           ret
        
        
        adaugarepoz:
            mov esi,edx
            mov edi, ebx
        adaugapoz:
            lodsb
            cmp al, 0
            jl sari1
            stosb
            sari1:
           loop adaugapoz
           ret