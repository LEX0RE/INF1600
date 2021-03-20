.text
.globl serie_s_iter
serie_s_iter:
   pushl  %ebp
   movl   %esp, %ebp
   pushl %ebx
   
   movl 8(%ebp), %edx

   cmpl $0, %edx
   jz N0

   cmpl $1, %edx
   jz N1

   movl $2, %eax        #c
   movl $2, %ebx        #i
   movl $1, %edx        #p

for:
   cmpl 8(%ebp), %ebx
   jg Retour

   pushl %eax
   addl $1, %eax
   addl %edx, %eax
   popl %edx
   inc %ebx
   loop for
   
N0:
   movl   $1, %eax
   jmp    Retour     
   
N1:
   movl   $2, %eax
   jmp    Retour   
   
Retour:   
   pop    %ebx
   leave
   ret

