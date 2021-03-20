.data
        comparaison: .float 10.0

.text

.globl	_ZN18EtudiantEnMaitrise8admisasmEv

_ZN18EtudiantEnMaitrise8admisasmEv:
        push %ebp      /* sauver le pointeur ebp */
        mov %esp, %ebp /* ebp recoit esp */
        
        pushl %ebx
        movl 8(%ebp), %ebx

        flds (comparaison)
        pushl %ebx
        call _ZN8Etudiant10moyenneasmEv
        addl $4, %esp
        fcomi
        jb refuse

        fstps (comparaison)
        flds 144(%ebx)
        fcomi
        jb refuse

admis:
        movl $1, %eax
        jmp fin

refuse:
        movl $0, %eax
        
fin:
        popl %ebx
        leave          /* recuperer ebp et esp */
        ret          
