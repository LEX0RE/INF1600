#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "exo1.h"

short parity(const short c){
   short p = 0;  
   
   // Completer la fonction ici
   for(unsigned int i = 0; i < 16; i++)
      p = ((c >> i) & 0b1) ^ p;

   return p;
}

short hamming_encoding(const char c){
   short code = 0;
   
   // Completer la fonction ici
   code = (c & 0b11110000);
   code <<= 1;
   code |= c & 0b1110;
   code <<= 1;
   code |= c & 0b1;
   code <<= 2;

   code |= parity(code & 0b111111100000000) << 7;
   code |= parity(code & 0b111100001110000) << 3;
   code |= parity(code & 0b110011001100100) << 1;
   code |= parity(code & 0b101010101010100);

   return code;
}

char hamming_decoding(const short c){   
   // Completer la fonction ici
   short mot = parity(c & 0b101010101010101);
   mot |= parity(c & 0b110011001100110) << 1;
   mot |= parity(c & 0b111100001111000) << 2;
   mot |= parity(c & 0b111111110000000) << 3;

   short cc = c;

   cc = cc ^ (0b1 << (mot - 1));

   char code = 0;
   code |= (cc & 0x0004) >> 2;
   code |= (cc & 0x0070) >> 3;
   code |= (cc & 0x0F00) >> 4;
   
   return code;
}

