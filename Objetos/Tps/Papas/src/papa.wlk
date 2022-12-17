// -------------- Impuestos --------------

object impuestoSimple{
	method valor(costoDeProduccion) = costoDeProduccion/ 10
}
	
object impuestoConGarantia{
	method valor(costoDeProduccion) = (costoDeProduccion * 0.05).max(100)
}

object impuestoInventado{
	method valor(costoDeProduccion)= impuestoConGarantia.valor(cosechaPapa.costoDeProduccion()) + 35
}

object impuestoCompuesto{
	method valor(costoDeProduccion){ 
		pepe.cotizacion(130 + cosechaBatata.costoDeProduccion())
		return pepe.cotizacion()
	} 
}	

// -------------- Retenciones --------------
	
object estatista{method retencion(cosecha) = if(cosecha.costoDeProduccion() > 1000) 200 else 300}	
	
object privatizador{method retencion(cosecha) = 50 + (cosecha.cantidad()/10)}
		
object demagogico{var property retencion = 100}	

object nulo{
	const retencion = 0
	method retencion() = retencion;
}
	
	
// -------------- Produccion --------------

object cosechaPapa {
	var calidad // Buena|Regular|Premium
	var property cantidad 
	var valorXUnidad
	var impuesto
	var retencion = 100
	
	method costoDeProduccion(){return cantidad * valorXUnidad}
	
	method importeTotal(){return (self.costoDeProduccion() + impuesto + retencion)}
	
	method calcularRetencion(tipoDeRetencion){
		retencion = tipoDeRetencion.retencion(self)
		return retencion
	}
	
	method calcularImpuesto(tipoDeImpuesto){
		impuesto = tipoDeImpuesto.valor(self.costoDeProduccion())
		return impuesto
	}
	
	method esCosechaBuena(){
		calidad = "buena"
		valorXUnidad = 3
	}
	
	method esCosechaRegular(){
		calidad = "regular"
		valorXUnidad = pepe.cotizacion()
	}
	
	method esCosechaPremium(){
		calidad = "premium"
		valorXUnidad = 4.5
	}
}

object pepe {
	var property cotizacion = 0
}

object cosechaBatata {
	var property costoDeProduccion
	var impuesto
	
	method importeTotal(){return (costoDeProduccion + impuesto)}
	
	method calcularImpuesto(tipoDeImpuesto){
		impuesto = tipoDeImpuesto.calcular(self.costoDeProduccion())
		return impuesto
	}
}
	
object cosechaZapallo {

	var property cantidad
	var retencion
	
	method costoDeProduccion(){
		return (cantidad * pepe.cotizacion()) 
	}
	
	method importeTotal(){
		return (self.costoDeProduccion() + retencion)
	}
	
	method calcularRetencion(tipoDeRetencion){
		retencion = tipoDeRetencion.retencion(self)/2
		return retencion
	}
	
}
