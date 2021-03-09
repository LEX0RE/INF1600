.text
.globl calcul_2

calcul_2 :
    movl $64, %ecx              # Initialisation du nombre d'itération
    movl $0, %ebx               # Initialisation du pointeur d'adresse
boucle: 
    movl adr_x(%ebx), %eax      # Sauvegarde dans un registre de la première valeur à additionner
    ADCl adr_y(%ebx), %eax      # Addition de la deuxième valeur avec la valeur dans le registre
    movl %eax, adr_z(%ebx)      # Sauvegarde de la valeur en mémoire
    INC %ebx                    # Déplacement du pointeur d'adresse
    INC %ebx                    # ''
    INC %ebx                    # ''
    INC %ebx                    # ''
    loop boucle                 # Boucler sur chaque int donné
    ret
