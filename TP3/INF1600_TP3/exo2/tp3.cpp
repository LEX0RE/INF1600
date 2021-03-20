#include <iostream>
#include <cmath>
#include <cstdlib>
#include <sstream>

#include "etudiants.h"

static const float EPSILON = 1e-4;


bool Equals(float a, float b) 
{
   if(a == b) 
      return true;

   if(::fabsf(a-b) < EPSILON) 
      return true;

   return false;
}




void Testetudiants(Etudiant& s) 
{
   /* calcul de la moyenne et determination si la personne est admis en CPP */
   float moyennecpp = s.moyennecpp();
   int admiscpp = s.admiscpp();
   /* calcul de la moyenne et determination si la personne est admis en Assembleur */
   float moyenneasm = s.moyenneasm();
   int admisasm = s.admisasm();
   /* Caclul et affichage des valeurs */
   std::cout << " moyenne :" << std::endl;
   std::cout << "\tC++ -> " << moyennecpp << std::endl;
   std::cout << "\tASM -> " << moyenneasm << std::endl;
   if(!Equals(moyennecpp, moyenneasm))
      std::cerr << "ERREUR: Les moyennes sont differentes" << std::endl;
   else
      std::cout << "\tLes moyennes sont egales" << std::endl << std::endl;
   std::cout <<  " admis :" << std::endl;
   std::cout << "\tC++ -> " << admiscpp << std::endl;
   std::cout << "\tASM -> " << admisasm << std::endl;
   if(admiscpp != admisasm)
      std::cerr << "ERREUR: Les resultats sont differents" << std::endl;
   else
      std::cout << "\tLes resultats sont egaux" << std::endl << std::endl;

}

void Testetudiant1() 
{
   Etudiant etudiant1;
   etudiant1.saisie();
   Testetudiants(etudiant1);
}

int main()
 
{ 
  Testetudiant1();
  return 0;
}
