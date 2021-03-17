.data
.globl adr
adr:
   .int 1,2,3,4,5,6,7,8,9,10,11,12,12,14,15,16,17,18    #Cases memoires debutant de l'adresse adr
   
.text
.globl calcul_1

calcul_1:
   movl $3, %eax           # Initialisation de la valeur initiale
   movl $17, %ecx          # Initialisation du nombre d'itération
   movl $0, %edx           # Initialisation du pointeur d'adresse
boucle:
   movl %eax, adr(%edx)    # Sauvegarde de la valeur initiale
   addl adr(%edx), %eax    # Ajout pour la première fois de la valeur initiale
   addl adr(%edx), %eax    # Ajout pour la deuxième fois de la valeur initia
   addl $4, %edx           # Déplacement du pointeur pour aller au prochain nombre
   loop boucle             # Permet de boucler selon le nombre d'itération
fin:
   movl %eax, adr(%edx)    # Sauvegarde de la dernière valeur
   ret
   
