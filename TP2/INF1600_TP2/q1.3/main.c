#include <stdio.h>
#include<stdint.h>

extern void calcul_3(void );
extern int32_t check_res(int32_t a);

int main(void) {
	int j=2;
	calcul_3();
	printf("Le resultat de la 1ere puissance est : %d\n ", check_res(0));
	for (int i=256; i<2305; i=i+256){
      printf("Le resultat de la %deme puissance est : %d\n ",j, check_res(i));
      j=j+1;
	}
	return 0;
}
