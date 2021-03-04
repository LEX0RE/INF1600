.data
.globl adr_temp,adr_res
adr_temp :
     .int 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,3,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64
adr_res:
     .int 1

.text     
.globl calcul_3



add_256 :
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
calcul_3 :
     pushl %ebx
     movl $3, adr_res(%ebx)
init :
     addl $4, %ebx
     movl $63, %ecx
     movl $0, adr_res(%ebx)
     loop init


   
     popl %ebx
     ret



   

