.data
        factor: .float 2.0 /* use this to divide by two */

.text
.globl	_ZN8Etudiant8admisasmEv

_ZN8Etudiant8admisasmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        / * Programme ici */
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
