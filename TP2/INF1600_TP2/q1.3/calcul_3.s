.data
.globl adr_temp,adr_res
adr_temp :
     .int 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,3,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64
adr_res:
     .int 1

.text     
.globl calcul_3

add_256 :                               # Fonction pour calculer le prochain nombre et le sauvegarder en mémoire
     pushl 4(%esp)                      # Incrémentation de esp
     pushl %ecx                         # Sauvegarde de ecx sur la pile
     pushl %ebx                         # Sauvegarde de ebx sur la pile
     pushl %eax                         # Sauvegarde de eax sur la pile
     movl $64, %ecx                     # Initialisation du nombre d'itération
     movl $0, %ebx                      # Initialisation du pointeur d'adresse pour les int
boucle_add :
     movl adr_temp(%ebx), %eax          # Sauvegarde de la valeur initiale dans un registre
     ADCl adr_temp(%ebx), %eax          # Addition pour la première fois avec la valeur initiale
     ADCl adr_temp(%ebx), %eax          # Addition pour la deuxième fois avec la valeur initiale
     movl %eax, adr_res(%ebx, %edx)     # Sauvegarde du résultat en mémoire selon la position
     INC %ebx                           # Déplacement du pointeur pour aller à la prochaine valeur
     INC %ebx                           # ''
     INC %ebx                           # ''
     INC %ebx                           # ''
     loop boucle_add                    # Boucler sur tous les int
     popl %eax                          # Remets le registre eax à son état d'origine
     popl %ebx                          # Remets le registre ebx à son état d'origine
     popl %ecx                          # Remets le registre ecx à son état d'origine
     addl $4, %esp                      # Décrémentation de esp
     ret                                # Retour à la dernière adresse dans la pile

copie :                                 # Fonction pour copier adr_res dans adr_temp
     pushl 4(%esp)                      # Incrémentation de esp
     pushl %ecx                         # Sauvegarde de ecx sur la pile
     pushl %ebx                         # Sauvegarde de ebx sur la pile
     pushl %eax                         # Sauvegarde de eax sur la pile
     movl $64, %ecx                     # Initialisation du nombre d'itération
     movl $0, %ebx                      # Initialisation du pointeur d'adresse pour les int
boucle_copie :
     movl adr_res(%ebx, %edx), %eax     # Sauvegarde de la valeur initiale dans un registre
     movl %eax, adr_temp(%ebx)          # Copie du registre dans adr_temp
     addl $4, %ebx                      # Déplacement du pointeur pour aller à la prochaine valeur
     loop boucle_copie                  # Boucle sur tout les int de adr_res
     popl %eax                          # Remets le registre eax à son état d'origine
     popl %ebx                          # Remets le registre ebx à son état d'origine
     popl %ecx                          # Remets le registre ecx à son état d'origine
     addl $4, %esp                      # Décrémentation de esp
     ret                                # Retour à la dernière adresse dans la pile

calcul_3 :                              # Début du programme
     pushl %ebx                         # Sauvegarde du registre ebx dans la pile
     movl $63, %ecx                     # Initialisation du nombre d'itération
     movl $0, %edx                      # Initialisation du pointeur d'adresse pour la sauvgarde de tous les nombres
     movl $0, %ebx                      # Initialisation du pointeur d'adresse pour les int
     movl $3, adr_res(%ebx)             # Initialisation de la valeur initiale

init :                                  # Remplissage des autres chiffres par 0
     addl $4, %ebx                      # Déplacement du pointeur d'adresse
     movl $0, adr_res(%ebx)             # Initialisation de 0 à la position indiquée
     loop init                          # Boucle pour tous les nombres dans adr_res
     movl $10, %ecx                     # Initialisation du nombre d'itération pour les nombres de puissance à effectuer

puissance :                             # Appel des fonctions pour le calcul de la puissance en base 3
     call copie                         # Appel de copie pour sauvegarder adr_res dans adr_temp
     addl $256, %edx                    # Déplacement du pointeur de résultat
     call add_256                       # Appel de add_256 pour calculer et sauvegarder le prochain nombre
     loop puissance                     # Boucle pour les nombres de puissance voulu
     popl %ebx                          # Remet le registre ebx à sa valeur initiale
     ret
