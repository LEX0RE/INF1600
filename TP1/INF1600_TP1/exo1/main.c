#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "exo1.h"

int main(int argc, char** argv) {

   short c, d;
   char  chr;
   
   printf("Q1 \n");   
   c = 14; 
   printf("parity(%d) retourne %d\n", c, parity(c));
   c = 15; 
   printf("parity(%d) retourne %d\n", c, parity(c));
   
   printf("Q2 \n");
   chr = 'a';
   c = hamming_encoding(chr);
   printf("Le code hexadecimal de '%c' est 0x%02x\n", chr, chr);
   printf("Le code de Hamming de '%c' donne 0x%04x\n", chr, c);
   
   printf("Q3 \n");
   d = hamming_decoding(c);
   printf("Le code hexadecimal de '%c' est 0x%02x\n", chr, chr);
   printf("Le code de Hamming de '%c' donne 0x%04x\n", chr, c);
   printf("Une fois decode, on obtient 0x%02x, cad '%c'\n", d, d);
   for(int i=0; i<15; i++){
      c = hamming_encoding(chr) ^ (1 << i);
      d = hamming_decoding(c);      
      printf("Et meme altere comme ceci 0x%04x, on retrouve '%c'\n", c, d);
   }
   

   return 0;
}

