.data
        factor: .float 10.0 /* utilisez ca pour diviser par 10*/
.text

.globl	_ZN8Etudiant10moyenneasmEv

_ZN8Etudiant10moyenneasmEv :
        push %ebp      /* sauver le pointeur ebp */
        mov %esp, %ebp /* ebp recoit esp */
        pushl %ebx
        
        movl 8(%ebp), %edx     
        addl $4, %edx
        fldz                    
        movl $0, %ebx           # i

for: 
        cmp $10, %ebx
        jge fin
        flds (%edx)
        faddp 
        inc %ebx
        addl $4, %edx
        jmp for

fin:
        flds (factor)
        fdivrp
        popl %ebx
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
