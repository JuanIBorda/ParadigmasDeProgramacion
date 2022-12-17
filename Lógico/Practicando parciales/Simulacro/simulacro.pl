%Pitágoras inmortal

pitagoras(CatetoA,CatetoB,Hipotenusa):-
    esDigito(CatetoA),
    esDigito(CatetoB),
    CatetoB > CatetoA,
    esSiguiente(CatetoB,Hipotenusa),
    esHipotenusa(CatetoA,CatetoB,Hipotenusa).

esSiguiente(Cateto,Hipotenusa):-
    Hipotenusa is (Cateto + 1.0).

esDigito(Cateto):-
    member(Cateto,[0,1,2,3,4,5,6,7,8,9]).
    
esHipotenusa(CatetoA,CatetoB,Hipotenusa):-
    Hipotenusa is  sqrt((CatetoA**2)+(CatetoB**2)). 
    
    
% 24
encontrarClave(clave(Letra,Digito1,Digito2,Digito3),Capitulos):-
    findall(clave(Letra,Digito1,Digito2,Digito3), esClave(clave(Letra,Digito1,Digito2,Digito3)), Intentos),
    length(Intentos,Tiempo),
    Capitulos is Tiempo / 3600.

esClave(clave(Letra,Digito1,Digito2,Digito3)):-
    esVocalMinuscula(Letra),
    esDigitoClave(Digito1),
    esDigitoClave(Digito2),
    esDigitoClave(Digito3),
    Digito1 \= Digito2,
    Digito2 \= Digito3,
    Digito1 \= Digito3.

esVocalMinuscula(Letra):-
    member(Letra,[a,e,i,o,u]).

esDigitoClave(Digito):-
    esDigito(Digito),
    Digito \= 0,
    Digito \= 7.

/*
%Escoba del 15
mesa( [carta(7,oro), carta(3, copa), carta(1,oro)]).
enMano( jugador1, [carta(sota, copa), carta(5, basto)]).
enMano( jugador2, [carta(rey, copa), carta(4, espada)]).
enMano( jugador3, [carta(2, copa), carta(3, espada)]).

puedeHacerEscoba(Jugador,CartasMesa,CartasLevantada,CartaJugada):-
    enMano(Jugador, CartasJugador),
    mesa(CartasMesa),
    sumaDeCartas(CartasMesa,TotalMesa),
    TotalMesa<15,
    cartaParaHacerEscoba(TotalMesa,carta(Numero,_)),
    jugadorTieneNumero(CartasJugador,carta(Numero,_)).

cartaParaHacerEscoba(TotalMesa,carta(Numero,_)):-
    Numero is 15 - TotalMesa.

jugadorTieneNumero(CartasJugador,carta(Numero,_)):-
    member(carta(Numero,_),CartasJugador).

sumaDeCartas(Cartas,SumaDeCartas):- 
forall('Param1', append(File)).
*/
    