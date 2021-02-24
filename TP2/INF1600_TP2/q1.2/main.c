#include <stdio.h>
#include<stdint.h>

extern int32_t calcul_2(void);
extern int32_t check(int32_t a);

int main(void) {
	calcul_2();
	printf("Les 4 octets LSB de z sont : 0x%x\n", check(0));
	printf("Les 4 octets Nº10 LSB de z sont : 0x%x\n", check(36));
	printf("Les 4 octets Nº20 LSB de z sont : 0x%x\n", check(76));
	printf("Les 4 octets MSB de z sont : 0x%x\n", check(252));
	return 0;
}
