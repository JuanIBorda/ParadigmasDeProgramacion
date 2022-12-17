herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustraspiradora3000, cera, aspiradora(300)]).

%Punto 1
tiene(egon,aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(peter, sopapa).
tiene(winston, varitaDeNeutrones).


tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

persona(Persona):-
    tiene(Persona,_).
%Punto 2
satisface(Persona,Herramienta):-
    tiene(Persona,Herramienta).

satisface(Persona,aspiradora(PotenciaRequerida)):-
    tiene(Persona,aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.

%Punto 3 -- Una 
puedeRealizar(Persona,Tarea):- 
    persona(Persona),
    herramientasRequeridas(Tarea,_),
    tiene(Persona,varitaDeNeutrones).

puedeRealizar(Persona,Tarea):- 
    persona(Persona),
    herramientasRequeridas(Tarea,HerramientaRequerida),
    forall(member(Herramienta,HerramientaRequerida),tiene(Persona,Herramienta)).


%Punto 4

cobrar(Cliente,Pedido,Monto):-
    cliente(Cliente),
    findall(Precio, (member(Tarea,Pedido),precioDeTarea(Cliente,Tarea,Precio)), Precios),
    sumlist(Precios,Monto).
    
precioDeTarea(Cliente,Tarea,Precio):-
    tareaPedida(Cliente,Tarea,SuperficieNecesaria),
    precio(Tarea,PrecioXmetroCuadrado),
    Precio is SuperficieNecesaria * PrecioXMetroCuadrado.

tareaPedida(Cliente,Tarea,Superficie).

precio(Tarea,PrecioXMetroCuadrado).

%Punto 5
Finalmente necesitamos saber quiénes aceptarían el pedido de un cliente. 
Un integrante acepta el pedido cuando puede realizar todas las tareas del pedido y además está dispuesto a aceptarlo.
Sabemos que Ray sólo acepta pedidos que no incluyan limpiar techos, Winston sólo acepta pedidos que paguen más de $500, 
Egon está dispuesto a aceptar pedidos que no tengan tareas complejas y Peter está dispuesto a aceptar cualquier pedido.
Decimos que una tarea es compleja si requiere más de dos herramientas. Además la limpieza de techos siempre es compleja.


aceptarPedido(Integrante,Pedido,_):-
    persona(Integrante),
    forall(member(Tarea,Pedido),puedeRealizar(Integrante,Tarea)),
    dispuestoAceptarlo(Integrante,Pedido).

dispuestoAceptarlo(Integrante,Pedido)


    

