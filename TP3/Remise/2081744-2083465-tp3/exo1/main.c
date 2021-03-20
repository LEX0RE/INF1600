#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned int serie_s_iter(unsigned int n);
unsigned int serie_s_rec(unsigned int n);

int main(int argc, char** argv) {

   printf("Approche iterative\n");
   for(int i=0; i<=6; i++){
      unsigned int s = serie_s_iter(i);
      printf("S(%d) = %d\n", i, s);
   }

   printf("Approche recursive\n");
   for(int i=0; i<=6; i++){
      unsigned int s = serie_s_rec(i);
      printf("S(%d) = %d\n", i, s);
   }

   return 0;
}

