/** 
Apellido y nombre: Borda Juan Ignacio	
Nro de Legajo: 1732390
*/
/*
Los cocineros: 
-catan(califican) platos y cocinan platos
-Pueden ser pasteleros | chef --> Se puede agregar otro a futuro

Hay 3 tipos de platos: Entrada - Principales Postres 

 */
 // ----------------------- PUNTO 1 ------------------------
class Plato{
	const chef															// Para poder identificar de que chef es cada plato
	method calorias() = 3 * self.cantidadDeAzucar() + 100
	
	method cantidadDeAzucar() // Metodos que van a tener que entender todos los platos
	method esBonito() 

	method chef() = chef
}

class PlatoDeEntrada inherits Plato{
	
	override method cantidadDeAzucar() = 0
	
	override method esBonito() = true
}
class PlatoPrincipal inherits Plato{
	var cantidadDeAzucar
	var bonito
	
	override method cantidadDeAzucar() = cantidadDeAzucar
	override method esBonito() = bonito
}
class PlatoDePostre inherits Plato{
	var cantidadDeColores								//No importa cuales son, lo que importa es la cantidad
	override method cantidadDeAzucar() = 120
	override method esBonito() = cantidadDeColores > 3
}
// ----------------------- PUNTO 2 y 5 -----------------------
class Cocinero{
	var especialidad																	// Para que pueda ir cambiando, por eso no usamos herencia
	var property nombre																	// Para mostrar el nombre del ganador en el punto 6
	
	method catar(plato) = especialidad.calificar(plato)
	
	method cambiarDeEspecialidad(nuevaEspecialidad) {especialidad = nuevaEspecialidad}	// PUNTO 3
	
	method cocinar() =  especialidad.cocinar(self)

	method participar(torneo) {torneo.inscribir(self.cocinar())}
}


// ESPECIALIDADES DEL COCINERO
class Pastelero{
	var nivelDeseadoDeDulzor
	
	method calificar(plato) = 5 * plato.cantidadDeAzucar() / (nivelDeseadoDeDulzor.min(10))
	
	method cocinar(cocinero) = new PlatoDePostre(cantidadDeColores = nivelDeseadoDeDulzor / 50, chef = cocinero) 
}

class Chef{
	var cantidadDeCaloriasPreferida
	
	method calificar(plato) = if(self.cumpleExpectativa(plato)) self.puntuaSiCumple(plato) else 0
	
	method cumpleExpectativa(plato) = plato.esBonito() && (plato.calorias() <= cantidadDeCaloriasPreferida)
	
	method puntuaSiCumple(plato) = 10													// El valor que obtiene un plato al cumplir la expectativa

	method cocinar(cocinero) = new PlatoPrincipal(bonito = true, cantidadDeAzucar = cantidadDeCaloriasPreferida, chef = cocinero)	
}

class Souschef inherits Chef{															// Punto 4
	override method puntuaSiCumple(plato) = (plato.calorias() / 100).min(6)
	
	override method cocinar(cocinero) = new PlatoDeEntrada(chef = cocinero)
}

class Torneo{
	var catadores 
	var platos = new Set()
	
	method inscribir(plato) = platos.add(plato)
	
	method ganador() =  if(platos.isEmpty()) {self.error("No se presento ningun cocinero")} else self.platoGanador().chef().nombre()
	
	method platoGanador() = platos.max({plato => self.calificacionIndividual(plato)})
	
	method calificacionIndividual(plato) = catadores.sum({catador => catador.catar(plato)})
}