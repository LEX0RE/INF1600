.data
        factor: .float 10.0 /* utilisez ca pour diviser par 10*/


.globl	_ZN8Etudiant10moyenneasmEv

_ZN8Etudiant10moyenneasmEv :
        push %ebp      /* sauver le pointeur ebp */
        mov %esp, %ebp /* ebp recoit esp */
        
        / * Programme ici */

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
