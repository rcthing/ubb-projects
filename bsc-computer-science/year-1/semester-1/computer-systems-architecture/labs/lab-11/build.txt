nasm -fobj ex12_main_lab_11.asm
nasm -fobj ex_12_module_lab_11.asm

alink ex12_main_lab_11.obj ex_12_module_lab_11.obj -oPE -subsys console -entry start