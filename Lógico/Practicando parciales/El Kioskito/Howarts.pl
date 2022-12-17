%Punto 1
mago(harry).
mago(draco).
mago(hermione).

sangre(harry,mestiza).
sangre(draco,pura).
sangre(hermione,impura).

odiaQuedar(harry,slytherin).
odiaQuedar(draco,hufflepuff).

caracteristicas(harry,[coraje,amistoso,orgullo,inteligente]).
caracteristicas(draco,[orgullo,inteligente]).
caracteristicas(hermione,[inteligente,orgullo,responsable]).


casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

masImportante(gryffindor,coraje).
masImportante(slytherin,orgullo).
masImportante(slytherin,inteligente).
masImportante(ravenclaw,responsable).
masImportante(ravenclaw,inteligente).
masImportante(hufflepuff,amistoso).

%Punto 1
permiteEntrar(Casa,Mago):-
    casa(Casa),
    Casa \= slytherin,
    mago(Mago).

permiteEntrar(slytherin,Mago):-
    mago(Mago),
    sangre(Mago,Tipo),
    Tipo \= impura.

%Punto 2

tieneCaracterApropiado(Mago,Casa):-
    mago(Mago),
    casa(Casa),
    caracteristicas(Mago,Caracteristicas),
    forall(masImportante(Casa,Que),member(Que,Caracteristicas)).

%Punto 3

puedeQuedar(Mago,Casa):-
    mago(Mago),
    casa(Casa),
    tieneCaracterApropiado(Mago,Casa),
    permiteEntrar(Casa,Mago),
    not(odiaQuedar(Mago,Casa)).

puedeQuedar(hermione,gryffindor).
    
%Punto 4
/*
Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos si todos ellos se caracterizan por ser amistosos y 
cada uno podría estar en la misma casa que el siguiente. No hace falta que sea inversible, se consultará de forma individual.
*/
cadenaDeAmistades(Magos):-
amistadAmistosa(Magos).



esAmistoso(Mago):- 
    caracteristicas(Mago,Caracteristicas),
    member(amistoso,Caracteristicas).


amistadAmistosa([Mago,MagoSiguiente|Magos]):-
    esAmistoso(Mago),
    puedeQuedar(Mago,Casa),
    puedeQuedar(MagoSiguiente,Casa),
    amistadAmistosa([MagoSiguiente|Magos]).

amistadAmistosa([_]).
amistadAmistosa([]).





