
.text
.globl	_ZN18EtudiantEnMaitrise8admisasmEv

_ZN18EtudiantEnMaitrise8admisasmEv:
        push %ebp      /* sauver le pointeur ebp */
        mov %esp, %ebp /* ebp recoit esp */
        
        / * Programme ici */
        
        leave          /* recuperer ebp et esp */
        ret          
