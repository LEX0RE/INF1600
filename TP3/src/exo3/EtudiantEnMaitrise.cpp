#include <iostream>
#include <cmath>
#include <cstdlib>
#include <sstream>

#include "EtudiantEnMaitrise.h"
#include "etudiants.h"

EtudiantEnMaitrise::~EtudiantEnMaitrise() {

}


void EtudiantEnMaitrise::saisie() {
    Etudiant::saisie();

    std::cout << "Donner la note du mémoire :" ;

    std::cin >> note_memoire ;

}

void EtudiantEnMaitrise::affichage () {
    Etudiant::affichage ();
    std::cout << "La note du mémoire :" 
              << note_memoire 
              << std::endl;

}

int EtudiantEnMaitrise::admiscpp() { 
    if ((moyennecpp() >= 10) && (note_memoire >=10))
        return (1); 
    else
        return (0);
}



