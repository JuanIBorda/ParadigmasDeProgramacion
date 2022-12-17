class Personaje{
	var property copas
	
		method jugar(mision,equipo){
		if(equipo.contains(self)){
		mision.realizar(equipo)} else self.error("Error al intentar jugar")
		}
	}
	
}

class Arquero inherits Personaje{
	var agilidad
	var rango
	method destreza() = agilidad * rango
	method estrategia() = rango > 100
}

class Guerrera inherits Personaje{		
	var fuerza
	const property estrategia = true
	method destreza() = fuerza + fuerza * 0.5
}

class Ballestero inherits Arquero{
	override method destreza() = super() * 2
}


object comun{
	method potenciar(copasAPotenciar,cantidadPersonajes) = copasAPotenciar
}
class Boost{
	var property multiplicador
	method potenciar(copasAPotenciar,cantidadPersonajes) = copasAPotenciar * multiplicador
}
object bonus{
	method potenciar(copasAPotenciar,cantidadPersonajes) = copasAPotenciar + cantidadPersonajes.size()
}

class Mision {
	var property tipoDeMision // Comun ,Boost Bonus
	
	method cumpleCondicionMinima(personaje) = null
	
	method puedeSerSuperada(personaje) = null
	
	method sumarCopas(personaje){}
	
	method restarCopas(personaje){}
	
	method realizar(personaje){
		if(self.cumpleCondicionMinima(personaje)){
			if(self.puedeSerSuperada(personaje)){self.sumarCopas(personaje)} else {self.restarCopas(personaje)}
			}else self.error("Mision no puede comenzar") 
		}
	
}

class MisionIndividual inherits Mision{
	var property dificultad 
	method copasEnJuego() =  2 * dificultad 
	
	override method cumpleCondicionMinima(personaje) = personaje.get(0).copas() > 10 && personaje.size() == 1
	
	override method puedeSerSuperada(jugador) = jugador.get(0).estrategia() || jugador.get(0).destreza() > self.dificultad()
	
	override method restarCopas(jugador){
		jugador.get(0).copas((jugador.get(0).copas() - tipoDeMision.potenciar(self.copasEnJuego(),[jugador.get(0)])).max(0))
	}
	
	override method sumarCopas(jugador){
		jugador.get(0).copas(jugador.get(0).copas() + tipoDeMision.potenciar(self.copasEnJuego(),[jugador.get(0)]))
	}
}


class MisionPorEquipo inherits Mision{
	
	method copasEnJuego(personajes) = 50 / personajes.size()
	
	override method puedeSerSuperada(personajes) = personajes.all({personaje => 400 < personaje.destreza()})  || personajes.filter({personaje => personaje.estrategia()}).size() > (personajes.size() / 2)
		
	override method cumpleCondicionMinima(personajes) = personajes.map({personaje => personaje.copas()}).sum() > 60
	
	override method restarCopas(personajes){
		personajes.forEach({personaje => personaje.copas(( personaje.copas() - tipoDeMision.potenciar(self.copasEnJuego(personajes),personajes)).max(0))})
	}
	override method sumarCopas(personajes){
		personajes.forEach({personaje => personaje.copas(personaje.copas() + tipoDeMision.potenciar(self.copasEnJuego(personajes),personajes))})
	}
}
