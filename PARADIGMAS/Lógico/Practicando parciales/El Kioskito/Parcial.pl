/*El punto de partida es que las necesidades humanas se jerarquizan en niveles: 
Respiración, alimentación, descanso y reproducción son necesidades del nivel más básico, llamado fisiológico.
Integridad física, empleo, salud son necesidades del nivel seguridad.
Amistad, afecto, intimidad son necesidades del nivel social.
Confianza, respeto y éxito son necesidades del nivel reconocimiento.
Hay un último nivel llamado de autorrealización, con sus correspondientes necesidades.
*/
necesidad(respiracion, fisiologico).
necesidad(alimentacion, fisiologico).
necesidad(descanso, fisiologico).
necesidad(reproduccion, fisiologico).


necesidad(integridadFisica, seguridad).
necesidad(empleo, seguridad).
necesidad(salud, seguridad).


necesidad(amistad, social).
necesidad(afecto, social).
necesidad(intimidad, social).

necesidad(confianza, reconocimiento).
necesidad(respeto, reconocimiento).
necesidad(exito, reconocimiento).

necesidad(comprar,innecesario). %Nivel Agregado con necesidad

nivelSuperior(innecesario,autorrealizacion).
nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social).
nivelSuperior(social,seguridad).
nivelSuperior(seguridad,fisiologico).

separacionDeNecesidades(Necesidad1,Necesidad2,Separacion):-
    necesidad(Necesidad1,Nivel1),
    necesidad(Necesidad2,Nivel2),
    Nivel2 \= Nivel1
    separacionDeNiveles(Nivel1,Nivel2,Separacion).

separacionDeNiveles(Nivel1,Nivel2,Separacion):-
    nivelSuperior(Nivel1,Nivel2)
    Separacion is Separacion + +1.