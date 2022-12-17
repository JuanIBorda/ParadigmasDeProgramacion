%Punto 1

persona(bakunin).
persona(ravachol).
persona(rosaDubovsky).
persona(judithButler).
persona(elisaBachofen).
persona(juanSuriano).
persona(sebastienFaure).

trabajo(bakunin,aviacionMilitar).
trabajo(ravachol,inteligenciaMilitar).
trabajo(rosaDubovsky,recolectorDeBasura).
trabajo(rosaDubovsky,asesinaASueldo).
trabajo(emmaGoldman,profesoraJudo).
trabajo(emmaGoldman,cineasta).
trabajo(judithButler,profesoraJudo).
trabajo(judithButler,inteligenciaMilitar).
trabajo(elisaBachofen,ingenieraMecanica).

gusto(ravachol,juegosDeAzar).
gusto(ravachol,ajedrez).
gusto(ravachol,tiroAlBlanco).
gusto(rosaDubovsky,construirPuentes).
gusto(rosaDubovsky,mirarPeppaPig).
gusto(rosaDubovsky,fisicaCuantica).
gusto(judithButler,judo).
gusto(judithButler,carrerasAutomovilismo).
gusto(elisaBachofen,fuego).
gusto(elisaBachofen,destruccion).
gusto(juanSuriano,judo).
gusto(juanSuriano,armarBombas).
gusto(juanSuriano,ringRaje).
gusto(emmaGoldman,Gusto) :- gusto(judithButler,Gusto).

habilidad(bakunin,conduciendoAutos).
habilidad(ravachol,tiroAlBlanco).
habilidad(rosaDubovsky,construirPuentes).
habilidad(rosaDubovsky,mirarPeppaPig).
habilidad(emmaGoldman, Habilidad) :- habilidad(elisaBachofen,Habilidad).
habilidad(emmaGoldman, Habilidad) :- habilidad(judithButler,Habilidad).
habilidad(judithButler,judo).
habilidad(elisaBachofen,armarBombas).
habilidad(juanSuriano,judo).
habilidad(juanSuriano,armarBombas).
habilidad(juanSuriano,ringRaje).

crimen(bakunin,roboDeAeronaves).
crimen(bakunin,fraude).
crimen(bakunin,tenenciaDeCafeina).
crimen(ravachol,falsificacionDeVacunas).
crimen(ravachol,fraude).
crimen(judithButler,falsificacionCheques).
crimen(judithButler,fraude).
crimen(juanSuriano,falsificacionDinero).
crimen(juanSuriano,fraude).

/*
Lo diseñamos de esta forma ya que al indicar las habilidades, los gustos y los crímenes separados de la declaración de las personas, le permitimos al motor de Prolog conocer al universo de personas, independientemente de que se sepan sus habilidades, crímenes o gustos (por ejemplo sebastienFaure).
*/

%Punto 2

% viveEn(nombrePersona,nombreCasa)
viveEn(bakunin,laSeverino).
viveEn(elisaBachofen,laSeverino).
viveEn(rosaDubovsky,laSeverino).
viveEn(ravachol,comisaria48).
viveEn(emmaGoldman,casaDePapel).
viveEn(juanSuriano,casaDePapel).
viveEn(judithButler,casaDePapel).
% Para el punto 6
viveEn(sebastianFaure,laCasaDePatricia). 


% tunel: metros de largo, estado
% pasadizo: cantidad
% cuarto secreto: medidaX, medidaY
habitacion(laSeverino,tunel(1,noConstruido)).
habitacion(laSeverino,tunel(8,construido)).
habitacion(laSeverino,tunel(5,construido)).
habitacion(laSeverino,cuartoSecreto(4,8)). 
habitacion(laSeverino,pasadizo(1)). 
habitacion(casaDePapel,pasadizo(2)).
habitacion(casaDePapel,cuartoSecreto(5,3)). 
habitacion(casaDePapel,cuartoSecreto(4,7)).
habitacion(casaDePapel,tunel(9,construido)).
habitacion(casaDePapel,tunel(2,construido)).
habitacion(casaDelSolNaciente,pasadizo(1)).
habitacion(casaDelSolNaciente,tunel(3,sinConstruir)).

% del punto 6
habitacion(laCasaDePatricia,bunker(10,2)).
habitacion(laCasaDePatricia,pasadizo(1)).

vivienda(comisaria48).
vivienda(laSeverino).
vivienda(casaDePapel).
vivienda(casaDelSolNaciente).



ocupantes(Personas,Casa):-
    vivienda(Casa),
    findall(Ocupante,viveEn(Ocupante,Casa),Personas).


%Punto 3

viviendaPotencialmenteRebelde(Vivienda) :-
    posibleDisidente(Persona),
    viveEn(Persona,Vivienda),
    superficieClandestina(Vivienda,Superficie),
    Superficie > 50.

superficieClandestina(Vivienda,SuperficieTotal):-
    findall(Superficie,superficie(Vivienda,Superficie),Superficies),
    sumlist(Superficies,SuperficieTotal).

    
superficie(Vivienda,SuperficieCuarto):-
    habitacion(Vivienda,cuartoSecreto(Largo,Ancho)),
    SuperficieCuarto is Largo * Ancho.

superficie(Vivienda,SuperficieTunel):-
    habitacion(Vivienda,tunel(Longitud,construido)),
    SuperficieTunel is Longitud * 2.

superficie(Vivienda,SuperficiePasadizo):-
    habitacion(Vivienda,pasadizo(Cantidad)),
    SuperficiePasadizo is Cantidad.

% del punto 6
superficie(Vivienda, SuperficieBunker) :-
    habitacion(Vivienda, bunker(SuperficieInterna,PerimetroAcceso)),
    SuperficieBunker is SuperficieInterna + PerimetroAcceso.


%Punto 4

viveAlguien(Vivienda):-
    viveEn(_,Vivienda).

noViveNadie(Vivienda):-
    vivienda(Vivienda),
    not(viveAlguien(Vivienda)).

tienenGustoEnComun(Vivienda,Gusto):-
    viveEn(Alguien,Vivienda),
    gusto(Alguien,Gusto),
    forall(viveEn(Persona,Vivienda),gusto(Persona,Gusto)).

todosCoincidenEnAlgunGusto(Vivienda) :- tienenGustoEnComun(Vivienda,_).

%Punto 5

habilidadTerrorista(armarBombas).
habilidadTerrorista(tiroAlBlanco).
habilidadTerrorista(mirarPeppaPig).

posibleDisidente(Persona):-
    persona(Persona),
    tieneHabilidadTerrorista(Persona),
    gustosTerroristas(Persona),
    historialTerrorista(Persona).

tieneHabilidadTerrorista(Persona):- 
    habilidad(Persona,Habilidad),
    habilidadTerrorista(Habilidad).

gustosTerroristas(Persona):-
    persona(Persona),
    not(gusto(Persona,_)).

gustosTerroristas(Persona):-
    persona(Persona),
    forall(habilidad(Persona,Actividad),gusto(Persona,Actividad)).


historialTerrorista(Persona):-
    persona(Persona),
    tieneAntecedentes(Persona).

historialTerrorista(Persona):-
    viveEn(Persona,Vivienda),
    viveEn(Otro,Vivienda),
    Persona \= Otro,
    tieneAntecedentes(Otro).

tieneAntecedentes(Persona):-
    findall(Crimen,crimen(Persona,Crimen),Crimenes),
    length(Crimenes,Cuantos),
    Cuantos>1.


%Punto 6

/*
Deberíamos agregar al predicado superficie el cálculo de la superficie del bunker.
No se debe modificar nada de la solución actual. Los cambios fueron realizados en los respectivos predicados.
*/


%Punto 7    

/*
Reutilizamos código de lo realizado previamente.
historialTerrorista(Persona)

Para resolver este requerimiento entra en juego el concepto de combinatoria, ya que necesitamos saber todas las combinaciones posibles de personas para luego saber si pueden formar un batallón.

Todos los miembros del batallon tienen que ser personas
Todas las personas del batallon deben ser distintas
*/

batallonRebeldes(Batallon):-
    findall(Persona,persona(Persona),Personas),
    batallonPosible(Personas,Batallon),
    masDeTresHabilidades(Batallon),
    forall((member(Persona2,Batallon)),historialTerrorista(Persona2)).

masDeTresHabilidades(Personas):-
    findall(Habilidad,(member(Persona2,Personas),habilidad(Persona2,Habilidad)),Habilidades),
    length(Habilidades,Cuantas),
    Cuantas > 3.

sonPersonas([Persona]):- persona(Persona).
sonPersonas([Persona|Personas]):- 
    persona(Persona),
    sonPersonas(Personas).

% "Devuelve" subconjuntos de la lista de personas
batallonPosible([Persona|_],[Persona]).
batallonPosible([_|Personas],Integrantes) :-
    batallonPosible(Personas,Integrantes).
batallonPosible([Persona|Personas],[Persona|Integrantes]) :-
   batallonPosible(Personas,Integrantes).


%Tests
:-begin_tests(tests).
%Tests punto 1
test(habilidades_de_Emma_Goldman_deben_ser_armar_bombas_y_el_judo,nondet,set(Habilidades == [armarBombas, judo])):-
    habilidad(emmaGoldman,Habilidades).
test(gustos_de_Emma_Goldman_deben_ser_carreras_de_automovilismo_y_el_judo,nondet,set(Gustos == [carrerasAutomovilismo, judo])):-
    gusto(emmaGoldman, Gustos).
    
%Tests punto 3
test(superficie_destinada_a_actividades_clandestinas_de_La_Severino_es_de_59):-
    superficieClandestina(laSeverino,59).
test(superficie_destinada_a_actividades_clandestinas_de_la_comisaria_48_es_de_0):-
    superficieClandestina(comisaria48,0).
test(la_casa_de_papel_y_la_Severino_tienen_potencial_rebelde,nondet):-
    viviendaPotencialmenteRebelde(casaDePapel),
    viviendaPotencialmenteRebelde(laSeverino).
%Tests punto 4
test(en_la_casa_del_sol_naciente_no_vive_nadie,fail):-
    viveAlguien(casaDelSolNaciente).
test(los_que_viven_en_casaDePapel_tienen_gustos_en_comun,nondet):-
    tienenGustoEnComun(casaDePapel,_).
test(los_que_viven_en_la_comisaria_48_tienen_gustos_en_comun,nondet):-
tienenGustoEnComun(comisaria48,_).

test(si_eliminamos_el_gusto_de_juanSuriano_por_el_judo_la_casaDePapel_no_deberia_ser_una_vivienda_con_gustos_en_comun,fail):-
    tienenGustoEnComun(casaDePapel,Gusto),
    Gusto \= judo.
%Tests punto 5
test(elisaBachofen_tiene_alguna_habilidad_considerada_terrorista,nondet):-
    tieneHabilidadTerrorista(elisaBachofen).
test(emmaGoldman_tiene_alguna_habilidad_considerada_terrorista,nondet):-
    tieneHabilidadTerrorista(emmaGoldman).
test(juanSuriano_tiene_alguna_habilidad_considerada_terrorista,nondet):-
    tieneHabilidadTerrorista(juanSuriano).
test(ravachol_tiene_alguna_habilidad_considerada_terrorista,nondet):-
    tieneHabilidadTerrorista(ravachol).
test(rosaDubovsky_tiene_alguna_habilidad_considerada_terrorista,nondet):-
    tieneHabilidadTerrorista(rosaDubovsky).

test(bakunin_no_tiene_gustos_registrados_o_bien_le_gusta_todo_en_lo_que_es_bueno,fail):-
    gusto(bakunin,_),
    habilidad(bakunin,AlgoEnLoQueEsBueno),
    not(gusto(bakunin,AlgoEnLoQueEsBueno)).
test(juanSuriano_no_tiene_gustos_registrados_o_bien_le_gusta_todo_en_lo_que_es_bueno,fail):-
    gusto(juanSuriano,_),
    habilidad(juanSuriano,AlgoEnLoQueEsBueno),
    not(gusto(juanSuriano,AlgoEnLoQueEsBueno)).
test(judithButler_no_tiene_gustos_registrados_o_bien_le_gusta_todo_en_lo_que_es_bueno,fail):-
    gusto(judithButler,_),
    habilidad(judithButler,AlgoEnLoQueEsBueno),
    not(gusto(judithButler,AlgoEnLoQueEsBueno)).
test(ravachol_no_tiene_gustos_registrados_o_bien_le_gusta_todo_en_lo_que_es_bueno,fail):-
    gusto(ravachol,_),
    habilidad(ravachol,AlgoEnLoQueEsBueno),
    not(gusto(ravachol,AlgoEnLoQueEsBueno)).
test(rosaDubovsky_no_tiene_gustos_registrados_o_bien_le_gusta_todo_en_lo_que_es_bueno,fail):-
    gusto(rosaDubovsky,_),
    habilidad(rosaDubovsky,AlgoEnLoQueEsBueno),
    not(gusto(rosaDubovsky,AlgoEnLoQueEsBueno)).
test(sebastienFaure_no_tiene_gustos_registrados_o_bien_le_gusta_todo_en_lo_que_es_bueno,fail):-
    gusto(sebastienFaure,_),
    habilidad(sebastienFaure,AlgoEnLoQueEsBueno),
    not(gusto(sebastienFaure,AlgoEnLoQueEsBueno)).

test(bakunin_tiene_mas_de_un_registro_en_su_historieal_criminal_o_vive_con_alguien_que_si_lo_tiene,fail):-
    not(historialTerrorista(bakunin)),
    not(tieneAntecedentes(bakunin)).
test(elisaBachofen_tiene_mas_de_un_registro_en_su_historieal_criminal_o_vive_con_alguien_que_si_lo_tiene,fail):-
    not(historialTerrorista(elisaBachofen)),
    not(tieneAntecedentes(elisaBachofen)).
test(emmaGoldman_tiene_mas_de_un_registro_en_su_historieal_criminal_o_vive_con_alguien_que_si_lo_tiene,fail):-
    not(historialTerrorista(emmaGoldman)),
    not(tieneAntecedentes(emmaGoldman)).
test(juanSuriano_tiene_mas_de_un_registro_en_su_historieal_criminal_o_vive_con_alguien_que_si_lo_tiene,fail):-
    not(historialTerrorista(juanSuriano)),
    not(tieneAntecedentes(juanSuriano)).
test(judithButler_tiene_mas_de_un_registro_en_su_historieal_criminal_o_vive_con_alguien_que_si_lo_tiene,fail):-
    not(historialTerrorista( judithButler)),
    not(tieneAntecedentes( judithButler)).
test(ravachol_tiene_mas_de_un_registro_en_su_historieal_criminal_o_vive_con_alguien_que_si_lo_tiene,fail):-
    not(historialTerrorista(ravachol)),
    not(tierravacholneAntecedentes(ravachol)).
test(rosaDubovsky_tiene_mas_de_un_registro_en_su_historieal_criminal_o_vive_con_alguien_que_si_lo_tiene,fail):-
    not(historialTerrorista(rosaDubovsky)),
    not(tieneAntecedentes(rosaDubovsky)).

test(rosaDubovsky_juanSuriano_y_ravachol_son_posibles_disidentes,nondet):-
    posibleDisidente(rosaDubovsky),
    posibleDisidente(juanSuriano),
    posibleDisidente(ravachol).
:-end_tests(tests).


