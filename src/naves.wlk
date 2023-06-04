class NaveEspacial {
	var velocidad = 0
	var  direccion = 0
	var combustible=0
	
	method cargarCombustible(cuanto){
			combustible += cuanto
	}
	method descargarCombustible(cuanto){
			combustible = (combustible -cuanto).max(0)
	}
	
	method acelerar(cuanto) {
		velocidad = 0.max((velocidad + cuanto).min(100000))
		
	}
	method desacelerar(cuanto) { 
		velocidad = 0.max(velocidad - cuanto.abs())
	}
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol(){
		direccion = (direccion + 1).min(10)
		//direccion = 10.min(direccion ++)
	}
	method alejarseUnPocoDelSol(){
		direccion = (direccion - 1).max(-10)
		//direccion = -10.max(direccion --)
	}
	method prepararViajeCondicionComun(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method prepararViajeCondicionParticular()
	
	method prepararViaje(){
		self.prepararViajeCondicionComun()
		self. prepararViajeCondicionParticular()
	}
	method estaTranquila(){
		return 	self.estaTranquilaCondicionComun() && 
				self.estaTranquilaCondicionParticular()
		
	}
	method estaTranquilaCondicionComun(){
		return combustible>=4000 && velocidad <=12000
	}
	
	method estaTranquilaCondicionParticular()
	
	
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	
	method escapar()  
	method avisar()
	
	method pocaActividad()
	
	method estaRelajada(){
		return self.estaTranquila() && self.pocaActividad()
		
	}
}


class NaveBaliza inherits NaveEspacial{
	var colorBaliza = rojo
	const property coloresCambiados =[]
	//var=coloresCambiados =0
	
	method cambiarColorBaliza(colorNuevo){
		colorBaliza = colorNuevo
		coloresCambiados.add(colorNuevo)
		//coloresCambiados++
	}
	method colorBaliza(){return colorBaliza}
	
	override method prepararViajeCondicionParticular(){
		
		self.cambiarColorBaliza(verde)
		coloresCambiados.add(verde)
		self.ponerseParaleloAlSol()
		//coloresCambiados++
	} 
	override method estaTranquilaCondicionParticular(){
		return colorBaliza !=rojo 
	}
	override method escapar(){
		self.irHaciaElSol()
		
	}
	override method avisar(){
		self.cambiarColorBaliza(rojo)
		coloresCambiados.add(rojo)
		//coloresCambiados++
	}
	override method pocaActividad(){
		return coloresCambiados.isEmpty()
			//coloresCambiados==0
	}
	
}


class NavePasajeros inherits NaveEspacial{
	const property cantPasajeros 
	var racionesComida=0
	var racionesBebida=0
	var comidaServida = 0
	
	method cargarComida(raciones){ 
		racionesComida +=raciones
	}
	method descargarComida(raciones){
		racionesComida = (racionesComida-raciones).max(0)
	}
	method racionesComida() = racionesComida
	
	method cargarBebida(raciones){
		racionesBebida +=raciones
	}
	method descargarBebida(raciones){
		racionesBebida = (racionesBebida-raciones).max(0)
		
	} 
	method racionesBebida() = racionesBebida
	
	override method prepararViajeCondicionParticular(){
		
		self.cargarComida(cantPasajeros*4)
		self.cargarBebida(cantPasajeros*6)
		self.acercarseUnPocoAlSol()
	}
	
	override method estaTranquilaCondicionParticular(){ return true} 
	
	override method escapar(){
		self.acelerar( velocidad*2 )
	}
	
	override method avisar(){
		self.descargarComida( cantPasajeros )
		self.descargarBebida(cantPasajeros * 2) 
		comidaServida = comidaServida + cantPasajeros
	}

	override method pocaActividad(){
		return comidaServida < 50
	}
	
}


class NaveCombate inherits NaveEspacial{
	 var esInvisible = false
	 var misilesDesplegados = true
	 const property mensajesEmitidos=[]
	
	method ponerseVisible(){  esInvisible = false }
	method ponerseInvisible(){  esInvisible = true }
	method estaInvisible(){ return esInvisible}
	method desplegarMisiles(){ misilesDesplegados = true }
	method replegarMisiles(){ misilesDesplegados = false }
	method misilesDesplegados(){ return misilesDesplegados  }
	
	method emitirMensaje(mensaje){
		mensajesEmitidos.add(mensaje)
	}
	method primerMensajesEmitido(){
		if (mensajesEmitidos.isEmpty()) self.error("no hay mensajes")
		return mensajesEmitidos.first() 
	}
	
	method ultimoMensajesEmitido(){
		if (mensajesEmitidos.isEmpty()) self.error("no hay mensajes")
		return mensajesEmitidos.last()
	}
	method esEscueta(){
		return !mensajesEmitidos.any( {mensaje => mensaje.length() > 30} )
	}
			//mensajesEmitidos.all( {mensaje => mensaje.size() <= 30}
				
	method emitioMensaje(mensaje){
		return mensajesEmitidos.any( {mens => mens.equals(mensaje)} )
		  // mensajesEmitidos.contains(mensaje) este es el ideal!
	}
	override method prepararViajeCondicionParticular(){
		
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión") 
	}
	override method estaTranquilaCondicionParticular(){
		return !self.misilesDesplegados()
	}
	
	override method escapar(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
		
	}
	override method avisar(){
		self.emitirMensaje("Amenaza Recibida")
		
	}
	
	override method pocaActividad(){
		return self.esEscueta()
	}
} 





class NaveCombateSigilosa inherits NaveCombate{
	
	override method estaTranquilaCondicionParticular(){
		return super() && !self.estaInvisible()
	}
	override method escapar(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
		
	}
}



class NaveHospital inherits NavePasajeros{
	var property  quirofanosPreparados = true

	
	
	override method estaTranquilaCondicionParticular(){
		return !quirofanosPreparados
	}
	
	override method recibirAmenaza(){
	 	super()
		self.quirofanosPreparados(true)
		}
	
	
}





object rojo{}
object verde{}
object azul{}
