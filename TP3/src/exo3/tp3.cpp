#include <iostream>
#include <cmath>
#include <cstdlib>
#include <sstream>

#include "etudiants.h"
#include "EtudiantEnMaitrise.h"

static const float EPSILON = 1e-4;

bool Equals(float a, float b) {
    if(a == b) 
        return true;

    if(::fabsf(a-b) < EPSILON) 
        return true;

   return false;
}




void Testetudiants(EtudiantEnMaitrise& s) {
   
   /* Determination si la personne est admis en CPP */
   int admiscpp = s.admiscpp();
   /* Determination si la personne est admis en Assembleur */
   int admisasm = s.admisasm();
   /* Print and test calculated values */
   std::cout <<  " admis qu doctorat :" << std::endl;
   std::cout << "\tC++ -> " << admiscpp << std::endl;
   std::cout << "\tASM -> " << admisasm << std::endl;
   if(admiscpp != admisasm)
      std::cerr << "ERREUR: Les resultats sont differents" << std::endl;
   else
      std::cout << "\tLes resultats sont egaux" << std::endl << std::endl;
}

void Testetudiant1() 
{
   EtudiantEnMaitrise etudiant1;
   etudiant1.saisie();
   Testetudiants(etudiant1);
}

int main()
 
{ 
  Testetudiant1();
  return 0;
}
