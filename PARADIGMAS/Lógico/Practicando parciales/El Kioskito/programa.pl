%%% Parcial Paradigma Lógico - Pdep JM 2022 UTN.BA

%%% Apellido y nombre: Borda Juan Ignacio
%%% Legajo: 1732390

%Punto 1 --> Ver si tengo que agregar algo para separar las necesidades y niveles   
%necesidad(Necesidad, Nivel).
necesidad(respiracion, fisiologico).
necesidad(alimentacion, fisiologico).
necesidad(descanso, fisiologico).
necesidad(reproduccion, fisiologico).
necesidad(limpiarse, fisiologico). % Agregada

necesidad(integridadFisica, seguridad).
necesidad(empleo, seguridad).
necesidad(salud, seguridad).
necesidad(defensaPropia, seguridad). % Agregada

necesidad(amistad, social).
necesidad(afecto, social).
necesidad(intimidad, social).
necesidad(jugar, social). % Agregada

necesidad(confianza, reconocimiento).
necesidad(respeto, reconocimiento).
necesidad(exito, reconocimiento).
necesidad(companierismo, reconocimiento). %Agregada

necesidad(trabajar, autorrealizacion). %Agregada

necesidad(comprar,innecesario). %Nivel Agregado con necesidad

nivelSuperior(innecesario,autorrealizacion).
nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social).
nivelSuperior(social,seguridad).
nivelSuperior(seguridad,fisiologico).

%Punto 2
separacionDeNiveles(Necesidad1,Necesidad2,Separacion):-
    necesidad(Necesidad1,Nivel1),
    necesidad(Necesidad2,Nivel2),
    diferenciaDeNivel(Nivel1,Nivel2,Separacion).

diferenciaDeNivel(Nivel1,Nivel2,Separacion):-
    posicionNivel(Nivel1,Posicion1),
    posicionNivel(Nivel2,Posicion2),
    max_member(Maximo,[Posicion1,Posicion2]),
    min_member(Minimo,[Posicion1,Posicion2]),
    diferencia(Minimo,Maximo,Separacion).

diferencia(Numero1,Numero2,Diferencia):-
    posicionNivel(_,Numero1),
    posicionNivel(_,Numero2),
    Numero1\=Numero2,
    findall(Numero,between(Numero1,Numero2,Numero),Numeros),
    length(Numeros,DiferenciaExtra),
    Diferencia is DiferenciaExtra - 1.

diferencia(Numero1,Numero2,0):- Numero1 = Numero2.
    
posicionNivel(Nivel,0):- mayorNivel(Nivel).

posicionNivel(Nivel,PosicionTotal):-
    nivelSuperior(Nivel,NivelSuperior),
    posicionNivel(NivelSuperior,Posicion),
    PosicionTotal is Posicion + 1.

mayorNivel(Nivel):-
    necesidad(_,Nivel),
    not(nivelSuperior(Nivel,_)).


%Punto 3
/*
Carla necesita alimentarse, descansar y tener un empleo. 
Juan no necesita empleo pero busca alguien que le brinde afecto. Se anotó en la facu porque desea ser exitoso. 
Roberto quiere tener un millón de amigos. 
Manuel necesita una bandera para la liberación, no quiere más que España lo domine ¡no señor!.
Charly necesita alguien que lo emparche un poco y que limpie su cabeza.
*/

persona(Persona):-
    necesita(Persona,_).

necesita(carla,alimentacion).
necesita(carla,descanso).
necesita(carla,empleo).
necesita(juan,afecto).
necesita(juan,exito).
necesita(roberto,amistad).
necesita(manuel,libertad).
necesita(charly,serEmparchado).
necesita(charly,limpiarse).

necesita(nacho,respiracion).%Invento persona para punto 6 y 5
necesita(nacho,alimentacion).
necesita(nacho,descanso).
necesita(nacho,reproduccion).
necesita(nacho,limpiarse).


%Punto 4

/*
Encontrar la necesidad de mayor jerarquía de una persona. 
En el caso de Carla, es tener un empleo.
*/

deMayorJerarquia(Persona,Necesidad):-
    persona(Persona),
    necesita(Persona,Necesidad),
    necesidad(Necesidad,Nivel),
    posicionNivel(Nivel,Posicion),
    not((necesita(Persona,Necesidad2),necesidad(Necesidad2,NivelInferior),posicionNivel(NivelInferior,PosicionInferior),PosicionInferior<Posicion)).

%Punto 5
 

pudoSatisfacer(Persona,Nivel):-
    persona(Persona),
    necesidad(_,Nivel),
    pudoCompletarNivel(Persona,Nivel).

pudoCompletarNivel(Persona,Nivel):-
    forall(necesidad(Necesidad,Nivel),necesita(Persona,Necesidad)).

%Punto 6

% ------------ A -------------

cumpleTeoriaDeMasLow(Persona):- 
    persona(Persona),
    forall(necesita(Persona,Necesidad),completaNivelDeNecesidadSuperior(Necesidad,Persona)).

completaNivelDeNecesidadSuperior(Necesidad,Persona):-
    necesidad(Necesidad,Nivel),
    completoNivelesSuperior(Persona,Nivel).
% --------------------- B -------------
esCiertaLaTeoriaDeMaslowParaTodos :-    forall(persona(Persona),cumpleTeoriaDeMasLow(Persona)). %Devuelve False porque no es asi

% ------------------------ C ---------------------
esCiertaLaTeoriaDeMaslowParaLaMayoria:-  %Considero a la mayoria como mas de la mitad poblacional
    findall(Quien,cumpleTeoriaDeMasLow(Quien),Quienes),
    distinct(poblacion(Poblacion)),
    length(Quienes,CuantosCumplen),
    length(Poblacion,CantidadDePersonas),
    CuantosCumplen > (CantidadDePersonas / 2).

poblacion(Poblacion):-
    findall(Persona,persona(Persona),Poblacion).

completoNivelesSuperior(Persona,fisiologico):-
    pudoSatisfacer(Persona,fisiologico).

completoNivelesSuperior(Persona,Nivel):-
    pudoSatisfacer(Persona,Nivel),
    nivelSuperior(Nivel,NivelSuperior),
    completoNivelesSuperior(Persona,NivelSuperior).


%Punto 7

/*  ---------------- A ----------------
Elegi a evaDuarte y a Jesus de Nzareth
*/

% ---------------- B ----------------
personajeHistorico(Personaje):-
    personaje(Personaje,_).


personaje(evaDuarte,dijo(detrasDeCadaNecesidadHayUnDerecho)).
personaje(jesusDeNazareth,accion(pasarHambre,darDeComer)).
personaje(jesusDeNazareth,accion(pasarSed,darDeBeber)).
personaje(jesusDeNazareth,accion(serForastero,darAlojamiento)).
personaje(jesusDeNazareth,accion(necesitarRopa,serVestido)).
personaje(jesusDeNazareth,accion(estarEnfermo,serAtendido)).
personaje(jesusDeNazareth,accion(estarEnCarcel,serVisitado)).


% ---------------- C ----------------
/*
valorDeVerdad(Algo):-
    dijo
*/

/* --------  D ----------
El polimorfismo lo utilizamos para poder referirnos al hecho dijo(_,QUE) y poder deducir el valor de verdad de lo 
que dice independientemente de lo que diga (cambia con los functores).
*/

