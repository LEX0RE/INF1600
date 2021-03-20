.data
        factor: .float 2.0 /* use this to divide by two */
        comparaison: .float 10.0

.text
.globl	_ZN8Etudiant8admisasmEv

_ZN8Etudiant8admisasmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        movl 8(%ebp), %edx
        pushl %edx
        call _ZN8Etudiant10moyenneasmEv
        addl $4, %esp
        flds (comparaison)
        fcomip
        ja refuse

admis:
        movl $1, %eax
        jmp fin
refuse:
        movl $0, %eax
fin:        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
