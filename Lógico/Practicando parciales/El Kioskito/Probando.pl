%Punto 1
trabaja(dodain,lunes,9,15).
trabaja(dodain,miercoles,9,15).
trabaja(dodain,viernes,9,15).

trabaja(lucas,martes,10,20).

trabaja(juanC,sabados,18,22).
trabaja(juanC,domingos,18,22).

trabaja(juanFdS,jueves,10,20).
trabaja(juanFdS,viernes,12,20).
trabaja(leoC,lunes,14,18).
trabaja(leoC,miercoles,14,18).

trabaja(martu,miercoles,23,24).

trabaja(vale, Dia, HorarioInicio, HorarioFinal):-trabaja(dodain, Dia, HorarioInicio, HorarioFinal).
trabaja(vale, Dia, HorarioInicio, HorarioFinal):-trabaja(juanC, Dia, HorarioInicio, HorarioFinal).

%Punto 2

quienAtiende(Dia,Hora,Atendedor):-
    trabaja(Atendedor,Dia,Inicio,Fin),
    between(Inicio,Fin,Hora).

%Punto 3
foreverAlone(Dia,Horario,Atendedor):-
    quienAtiende(Dia,Horario,Atendedor),
    not((quienAtiende(Dia,Horario,Atendedor2),Atendedor2 \= Atendedor)).


%Punto 4
%Dado un día, queremos relacionar qué personas podrían estar atendiendo el kiosko en algún momento de ese día. 
%Por ejemplo, si preguntamos por el miércoles, tiene que darnos esta combinatoria:
%nadie
%%dodain solo
%dodain y leoC
%dodain, vale, martu y leoC
%vale y martu
%etc.

puedeEstarAtendiendo(Dia,Personas):-
    
%Queremos saber todas las posibilidades de atención de ese día. 
%La única restricción es que la persona atienda ese día (no puede aparecer lucas, por ejemplo, porque no atiende el miércoles).

