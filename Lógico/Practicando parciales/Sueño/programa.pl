persona(diego).
persona(Persona):- creeEn(Persona,_).
personaje(Personaje):- creeEn(_,Personaje).

creeEn(gabriel,campanita).
creeEn(gabriel,magoDeOz).
creeEn(gabriel,cavenaghi).
creeEn(juan,conejoDePascua).
creeEn(macarena,reyesMagos).
creeEn(macarena,magoCapria).
creeEn(macarena,campanita).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).

suenio(gabriel,ganarLoteria([3,9])).
suenio(gabriel,jugadorDeFutbol(arsenal)).
suenio(juan,cantante(100000)).
suenio(macarena,cantante(10000)).

amigo(campanita,reyesMagos).
amigo(campanita,conejoDePascua).
amigo(conejoDePascua,cavenaghi).


%Punto 2
esAmbiciosa(Persona):-
    persona(Persona),
    dificultadPersona(Persona,Dificultad),
    Dificultad > 20.

dificultadPersona(Persona,Dificultad):-
    findall(Dificultadsuenio,(suenio(Persona,Suenio),dificultad(Suenio,Dificultadsuenio)), Dificultades),
    sum_list(Dificultades, Dificultad).

dificultad(ganarLoteria(Numeros),Dificultad):-
    length(Numeros, Cantidad),
    Dificultad is Cantidad * 10.

dificultad(jugadorDeFutbol(Equipo),3):-
    esEquipoChico(Equipo).

dificultad(jugadorDeFutbol(Equipo),16):-
    suenio(_,jugadorDeFutbol(Equipo)),
    not(esEquipoChico(Equipo)).

dificultad(cantante(Ventas),6):- 
    suenio(_,cantante(Ventas)),
    Ventas > 500000.

dificultad(cantante(Ventas),4):- 
    suenio(_,cantante(Ventas)),
    Ventas =< 500000.

esEquipoChico(arsenal).
esEquipoChico(aldosivi).

%Punto 3

tienenQuimica(campanita,Persona):-
    persona(Persona),
    creeEn(Persona,campanita),
    suenio(Persona,Suenio),
    dificultad(Suenio,Dificultad),
    Dificultad < 5.

tienenQuimica(Personaje,Persona):-
    persona(Persona),
    creeEn(Persona,Personaje),
    forall(suenio(Persona,Suenio), suenioPuro(Suenio)),
    not(esAmbiciosa(Persona)).
    
suenioPuro(jugadorDeFutbol(_)).
suenioPuro(cantante(Discos)):- Discos < 200000.

%Punto 4

puedeAlegrar(Personaje,Persona):-
    persona(Persona),
    creeEn(Persona,Personaje),
    suenio(Persona,_).

puedeAlegrar(Personaje,Persona):-
    persona(Persona),
    personaje(Personaje),
    tienenQuimica(Personaje,Persona),
    not(enfermo(Personaje)).

puedeAlegrar(Personaje,Persona):-
    tienenQuimica(Personaje,Persona),
    backup(Personaje,Amigo),
    not(enfermo(Amigo)).

backup(Personaje,AmigoDirecto):-
    personaje(Personaje),
    amigo(Personaje,AmigoDirecto).

backup(Personaje,AmigoIndirecto):-
    personaje(Personaje),
    amigo(Personaje,AmigoDirecto),
    amigo(AmigoDirecto,AmigoIndirecto),
    AmigoIndirecto \= Personaje.


    