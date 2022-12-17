object homero {
	var cantDonas = 0
	// un objeto entiende mensajes
	// si tiene los métodos
	method comprar() {
		cantDonas = cantDonas + 12
	}
	
	// otro metodo distinto:
	// method comprar(cant) ...
	
	method comer() {
		cantDonas = cantDonas - 1
	}
	
	// este igual no es asignar, es devolver
	method cantDonas() = cantDonas

	method estaDistraido() = cantDonas < 2
}

object plantaNuclear {
	var encargado = homero
	var cantUranio = 0
	
	method estaEnPeligro() = 
		cantUranio > 10000 and encargado.estaDistraido()
		
	method comprarUranio(cuantoUranio){
		cantUranio = cantUranio + cuantoUranio
	} 
	
	method reemplazarEncargado(Encargado){
		encargado = Encargado
	}		
}

object patoBalancin{
	method estaDistraido() = false
}

object lenny{
	var cervezasTomadas = 0
	
	method tomar(){
		cervezasTomadas = cervezasTomadas + 1
	}
	method trabajar(){
		self.tomar()
	}
	method distraido() = cervezasTomadas > 3 
}

