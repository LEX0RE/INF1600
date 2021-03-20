#ifndef ETUDIANTM_H
#define ETUDIANTM_H

#include "etudiants.h"

class EtudiantEnMaitrise : public Etudiant{ 
private:
    float note_memoire ;
public :
    virtual ~EtudiantEnMaitrise();
    virtual void saisie ();
    virtual void affichage();
    virtual int admiscpp();
    virtual int admisasm();
};

#endif
