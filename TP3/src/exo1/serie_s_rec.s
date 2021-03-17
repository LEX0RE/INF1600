.text
.globl serie_s_rec
serie_s_rec:
   pushl  %ebp
   movl   %esp, %ebp
   
   # completer
   
N0:
   movl   $1, %eax
   jmp    Retour     
   
N1:
   movl   $2, %eax
   jmp    Retour   
   
Retour:   
   leave
   ret

