#ifndef ETUDIANT_H
#define ETUDIANT_H

class Etudiant

{ 
    private:

        float tabnotes[10] ;

        char nom[50], prenom[50];        

    public :

        virtual void saisie () ;

        virtual ~Etudiant();
            
        virtual void affichage () ;

        float moyennecpp() ;
            
        virtual float moyenneasm() ;

        virtual int admiscpp() ;

        virtual int admisasm() ;

} ;

#endif
