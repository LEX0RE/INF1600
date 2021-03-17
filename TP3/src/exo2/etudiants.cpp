#include <iostream>
#include <cmath>
#include <cstdlib>
#include <sstream>

#include "etudiants.h"


Etudiant::~Etudiant() 
{

}

void Etudiant::saisie ()

{ 
    int i ;

    std::cout << "Saisie des notes \n" ;

    for (i = 0 ; i < 10 ; i++)

        {

            std::cout << "Donner la note N°" << i<< " : " ;

            std::cin >> tabnotes[i] ;

        }

    std::cout << "Donner le nom :" ;

    std::cin >> nom ;

    std::cout << "Donner le prénom :" ;

    std::cin >> prenom ;

}

void Etudiant::affichage ()

{ 
    int i ;

    std::cout << "Le nom :"<<nom<< std::endl ;

    std::cout << "Le prénom :" <<prenom<< std::endl ;

    for (i = 0 ; i < 10 ; i++)

        std::cout << "La note N°" << i << "est " << tabnotes[i]<< std::endl ;

}

float Etudiant::moyennecpp()

{ 
    int i ;

    float som = 0;

    for (i = 0 ; i < 10 ; i++)

        som  = som + tabnotes[i] ;

    return (som/10);

}

int Etudiant::admiscpp()

{   
    if (moyennecpp() >= 10) 
         return (1); 
    else 
         return (0);
}




