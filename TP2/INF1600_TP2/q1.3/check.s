.text
.globl check_res

check_res :
   movl 4(%esp),%eax
   leal adr_res,%ecx
   addl %ecx,%eax
   movl (%eax),%eax
   ret
