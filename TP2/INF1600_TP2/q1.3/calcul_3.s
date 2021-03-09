.data
.globl adr_temp,adr_res
adr_temp :
     .int 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,3,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64
adr_res:
     .int 1

.text     
.globl calcul_3


# ON sauvegarde les valeurs courantes dans les registres à l'intérieur de la pile, puis initialisons les registres %ecx et %ebx.
add_256 :
     pushl 4(%esp)
     pushl %ecx
     pushl %ebx
     pushl %eax
     movl $64, %ecx
     movl $0, %ebx
# Boucle qui permet de générer une puissance de 3 par appel et de la placer dans %eax, puis dans adr_res, en additionnant les valeurs se trouvant sous les étiquettes adr_res et adr_temp. 
boucle_add : 
     subl $256, %edx
     movl adr_res(%ebx, %edx), %eax
     ADCl adr_temp(%ebx), %eax
     ADCl adr_res(%ebx, %edx), %eax
     addl $256, %edx
     movl %eax, adr_res(%ebx, %edx)
     INC %ebx
     INC %ebx
     INC %ebx
     INC %ebx
     loop boucle_add
     popl %eax
     popl %ebx
     popl %ecx
     addl $4, %esp
     ret
# Effectue la même opération que add_256.
copie :
     pushl 4(%esp)
     pushl %ecx
     pushl %ebx
     pushl %eax
     movl $64, %ecx
     movl $0, %ebx
# Rend adr_temp exactement pareille à adr_res au niveau de leurs valeurs.
boucle_copie :
     movl adr_res(%ebx, %edx), %eax
     movl %eax, adr_temp(%ebx)
     addl $4, %ebx
     loop boucle_copie
     popl %eax
     popl %ebx
     popl %ecx
     addl $4, %esp
     ret
# Sauvegarde la valeur courante de %ebx dans la pile, puis initialise les autres registres en plus de placer la première puisssance dans adr_res.
calcul_3 :
     pushl %ebx
     movl $63, %ecx
     movl $0, %edx
     movl $0, %ebx
     movl $3, adr_res(%ebx)
# Initialise le reste de adr_res et indique la dernière puissance à calculer. 
init :
     addl $4, %ebx
     movl $0, adr_res(%ebx)
     loop init
     movl $10, %ecx
# Appel des fonctions afin de calculer les puissances de 3. 
puissance :
     call copie
     addl $256, %edx
     call add_256
     loop puissance
     popl %ebx
     ret




   

