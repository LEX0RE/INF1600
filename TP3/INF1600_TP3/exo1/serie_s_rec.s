.text
.globl serie_s_rec
serie_s_rec:
   pushl  %ebp
   movl   %esp, %ebp
   pushl %ebx
   
   movl 8(%ebp), %edx
   movl $1, %ebx

   cmpl $0, %edx
   jz N0

   cmpl $1, %edx
   jz N1

	decl %edx
	pushl %edx
	call serie_s_rec
   addl $4, %esp
   addl %eax, %ebx
   movl 8(%ebp), %edx
   subl $2, %edx
   pushl %edx
   call serie_s_rec
   addl $4, %esp
   addl %eax, %ebx
   movl %ebx, %eax
   jmp Retour
   
N0:
   movl   $1, %eax
   jmp    Retour     
   
N1:
   movl   $2, %eax
   jmp    Retour   
   
Retour:   
   pop %ebx
   leave
   ret

