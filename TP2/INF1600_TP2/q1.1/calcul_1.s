.data
.globl adr
adr:
   .int 1,2,3,4,5,6,7,8,9,10,11,12,12,14,15,16,17,18    #Cases memoires debutant de l'adresse adr
   
.text
.globl calcul_1

calcul_1:
   movl $3, %eax
   movl $17, %ecx
   movl $0, %edx
boucle:
   movl %eax, adr(%edx)
   addl adr(%edx), %eax
   addl adr(%edx), %eax
   addl $4, %edx
   loop boucle
fin:
   movl %eax, adr(%edx)
   ret


   



   

