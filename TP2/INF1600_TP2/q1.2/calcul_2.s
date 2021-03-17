.text
.globl calcul_2

calcul_2 :
    movl $64, %ecx
    movl $0, %ebx
boucle: 
    movl adr_x(%ebx), %eax
    ADCl adr_y(%ebx), %eax
    movl %eax, adr_z(%ebx)
    INC %ebx
    INC %ebx
    INC %ebx
    INC %ebx
    loop boucle
    ret
