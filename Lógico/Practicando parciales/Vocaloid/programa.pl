% Base de conocimientos

vocaloid(Vocaloid):-
    canta(Vocaloid,_,_).
vocaloid(kaito).

canta(megurineLuka,nightFever,4).
canta(megurineLuka,foreverYoung,5).
canta(hatsuneMiku,tellYourWorld,4).
canta(gumi,foreverYoung,4).
canta(seeU,tellYourWorld,4).


% Punto 1
esNovedoso(Vocaloid):-
    cantaPorLoMenos2Canciones(Vocaloid),
    forall(canta(Vocaloid,_,Duracion), Duracion < 15).
    
cantaPorLoMenos2Canciones(Vocaloid):-
    canta(Vocaloid,Cancion1,_),
    canta(Vocaloid,Cancion2,_),
    Cancion1 \= Cancion2.
cantaPorLoMenos2Canciones(Vocaloid):-
    canta(Vocaloid,_,Duracion1),
    canta(Vocaloid,_,Duracion2),
    Duracion1 \= Duracion2.

%Punto 2

esAcelerado(Vocaloid):-
    canta(Vocaloid,_,_),
    not(cantaMasDe4Minutos(Vocaloid)).

cantaMasDe4Minutos(Vocaloid):-
    canta(Vocaloid,_,Duracion),
    Duracion >4.

%Punto 3

%concierto(Nombre,Pais,Fama,gigante(CantidadMinima,DuracionMinima)).
%concierto(Nombre,Pais,Fama,mediano(DuracionMaxima)).
%concierto(Nombre,Pais,Fama,pequeño(DuracionSolicitada)).
concierto(mikuExpo,estadosUnidos,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vevocalektVisions,estadosUnidos,1000,mediano(9)).	
concierto(mikuFest,argentina,100,pequenio(4)).	

puedeParticipar(hatsuneMiku,_).
puedeParticipar(Vocaloid,Concierto):-
    canta(Vocaloid,_,_),
    concierto(Concierto,_,_,Tipo),
    cumpleCondicion(Vocaloid,Tipo).

cumpleCondicion(Vocaloid,gigante(CantidadMinima,DuracionMinima)):-
    cantaEnTotal(Vocaloid,Cuantas),
    cantaEnMinutos(Vocaloid,DuracionTotal),
    DuracionTotal > DuracionMinima,
    Cuantas >= CantidadMinima.

cumpleCondicion(Vocaloid,mediano(DuracionMaxima)):-
    cantaEnMinutos(Vocaloid,DuracionTotal),
    DuracionTotal < DuracionMaxima.

cumpleCondicion(Vocaloid,pequenio(DuracionSolicitada)):-
    canta(Vocaloid,_,Duracion),
    Duracion > DuracionSolicitada.

cantaEnMinutos(Vocaloid,DuracionTotal):-
    findall(Duracion,canta(Vocaloid,_,Duracion),Duraciones),
    sumlist(Duraciones, DuracionTotal).

cantaEnTotal(Vocaloid,Cuantas):-
    findall(Cancion,canta(Vocaloid,Cancion,_),Canciones),
    length(Canciones, Cuantas).

%Punto 3
elMasFamoso(Vocaloid):-
    vocaloid(Vocaloid),
    not(esMasFamoso(_,Vocaloid)).

fama(Vocaloid,FamaTotal):-
    canta(Vocaloid,_,_),
    findall(FamaObtenida,(puedeParticipar(Vocaloid,Concierto),concierto(Concierto,_,FamaObtenida,_)),FamasObtenidas),
    sumlist(FamasObtenidas,FamaRecolectada),
    cantaEnTotal(Vocaloid,CancionesCantadas),
    FamaTotal is FamaRecolectada * CancionesCantadas.

esMasFamoso(Vocaloid1,Vocaloid2):-
    fama(Vocaloid1,Fama1),
    fama(Vocaloid2,Fama2),
    Fama1 > Fama2.


%Punto 4
conoceA(megurineLuka,hatsuneMiku).
conoceA(megurineLuka,gumi).
conoceA(gumi,seeU).
conoceA(seeU,kaito).


esElUnicoEnParticipar(Vocaloid,Concierto):-
    puedeParticipar(Vocaloid,Concierto),
    not(conocido(Vocaloid,Conocido),
    puedeParticipar(Conocido,Concierto)).

conocido(Vocaloid,Conocido):-
    conoceA(Vocaloid,Conocido).
conocido(Vocaloid,Conocido):-
    conoceA(Conocido,Otro),
    Otro \= Vocaloid.
