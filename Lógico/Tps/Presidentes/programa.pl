% Punto 1

%La base de los conocimientos

%presidencia(Presidente,Inicio,Fin,Identificacion).
presidencia(alfonsin,1983,1989,"Recuperacin de la democracia").
presidencia(menem,1990,1995,"Convertibilidad 1 peso = 1 dólar").
presidencia(menem,1996,1999,"Desocupación récord").
presidencia(deLaRua,2000,2001,"Salida en helicóptero").
presidencia(homero,2005,2010,"s").
presidencia(homero,2010,2014,"s").
presidencia(marge,2015,2018,"s").
presidencia(marge,2019,2023,"s").
%accion(Identifiaccion,Año,GenteBeneficiada).
accion("Juicio a las juntas",1985,30000000). %alfonsin
accion("Hiperinflacion",1989,10). %alfonsin
accion("Privatización de YPF",1992,1).%menem
accion("Creo la llamarada Moe",2009,30000000).
accion("Arreglo el reactor nuclear",2006,1000000). 
accion("Contamino un lago",2012,10).
accion("Se caso con homero",2016,30000000).
accion("Nose",2020,543534534534). 
accion("Ejemplo3",2023,1000000).


% ----------- Delegando predicados -----------
esBuena(Accion):-
    accion(Accion,_,GenteBeneficiada),
    GenteBeneficiada > 100000.

%Hizo algo si Existe alguna presidencia del presidente que en su periodo haya realizado una accion.
hizoAlgo(Presidente):-
    presidencia(Presidente,Inicio,Fin,_),
    between(Inicio,Fin,Fecha),
    accion(_,Fecha,_).

hizoAlgoBueno(Presidente):-
    presidencia(Presidente,Inicio,Fin,_),
    ocurrioAlgoBueno(Inicio,Fin).

ocurrioAlgoBueno(Inicio,Fin):-
    between(Inicio,Fin,Fecha),
    accion(Accion,Fecha,_),
    esBuena(Accion).

ocurrioAlgoMalo(Inicio,Fin):-
    between(Inicio,Fin,Fecha),
    accion(Accion,Fecha,_),
    not(esBuena(Accion)).

soloOcurrieronCosasBuenas(Inicio,Fin):-
    ocurrioAlgoBueno(Inicio,Fin),
    not(ocurrioAlgoMalo(Inicio,Fin)).

% ----------- Conclusiones de los presidentes ----------- PUNTO  2
insulso(Presidente):- 
    presidencia(Presidente,_,_,_),
    not(hizoAlgo(Presidente)).
    
malo(Presidente):- 
    hizoAlgo(Presidente),
    forall(presidencia(Presidente,Inicio,Fin,_),not(ocurrioAlgoBueno(Inicio,Fin))). %Puede ser ,(ocurrioAlgoMalo(Inicio,Fin)).

regular(Presidente):- 
    forall(presidencia(Presidente,Inicio,Fin,_),ocurrioAlgoBueno(Inicio,Fin)).

bueno(Presidente):- 
    presidencia(Presidente,Inicio,Fin,_),
    soloOcurrieronCosasBuenas(Inicio,Fin).
      
muyBueno(Presidente):- 
    presidencia(Presidente,_,_,_),
    forall(presidencia(Presidente,Inicio,Fin,_),soloOcurrieronCosasBuenas(Inicio,Fin)).
    
% Punto 3
% Para probar que un predicado es inversible, debo poder enviarle una variable anonima (Por ejemplo Quien), la cual va en mayusculas,
% y el predicado me devolvera las posibles entradas al predicado basandose en la base de los conocimientos definida anteriormente.

% El predicado "muyBueno(Presidente)" es inversible, debido a que se instancia el presidente en presidencia y luego se verifica
% el for all con el presidente instanciado. Si se quitara el "presidencia(Presidente,_,_,_)" dejaria de ser inversible ya que no puede
% verificar el forall sin antes instanciar la variable.

% Otro predicado podria ser malo(Presidente). En donde instancio a la variable presidente con hizoAlgo (Que esta instancia la variable en presidencia)
% y luego puedo corroborrar el forall.

% b) El predicado "regular(Presidente)" no es inversible ya que no puede comprobar si se cumple el forall, sin antes tener instanciada la variable.
% Una forma de convertirlo en inversible seria agregando presidencia(Presidente,_,_,_), y asi instanciaria al presidente antes del forall.

%  Punto 4

:- begin_tests(insulso).
test(deLaRua_es_un_presidente_insulso):-
    insulso(deLaRua).
test(alfonsin_es_un_presidente_insulso):-
    not(insulso(alfonsin)).
test(quienes_son_los_presidentes_insulsos, set(Presidentes == [deLaRua])):-
    insulso(Presidentes).
:- end_tests(insulso).

:- begin_tests(malo).
test(menem_es_un_presidente_malo,nondet):-
    malo(menem).
test(alfonsin_es_un_presidente_malo, fail):-
    malo(alfonsin).
test(quienes_son_los_presidentes_insulsos, set(Presidentes == [menem])):-
    malo(Presidentes).
:- end_tests(malo).