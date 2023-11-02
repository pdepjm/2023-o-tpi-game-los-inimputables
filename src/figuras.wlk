import wollok.game.*
//Todas las figuras del juego

//textos del puntaje actual y del highScore
class Textos{
	var property position
	var text = ""
	method text() = text
	method textColor() = "FFFFFFF"
	method cambiarPuntaje(puntaje){
			text = puntaje
	}
}
object textoHighscore inherits Textos(position = new Position(x = 6, y = 3)){}
object textoPuntos inherits Textos(position = new Position(x = 11, y = 0)){}
//menu inicial y final
class Menus {
	var property image
	var property position = new Position(x = 0, y = 0)
}
object menuInicial inherits Menus(image = "assets/imagen_presentacion.jpg"){}
object menuFinal inherits Menus(image = "assets/imagen_fin_juego.jpg"){}
class Bloque {
	var property image
	var property position
}
class Figura{
	var property listaBloque = []	
	var property posicionX = 4			//posicion relativa del eje X
	var property posicionY = 16 		//posicion relativa del eje Y
	var property enUso = false
	var property visual = true
	method borrarVisual() {
		listaBloque.forEach({bloque => game.removeVisual(bloque)})
		listaBloque.clear()
	}
	 method cambiarPosicion(x,y) {
		posicionX = x
		posicionY = y
	}
	//Pregunto si el bloque esta fuera del tablero con respecto al eje X
	method bloqueFueraTabletoX() = listaBloque.any({bloque => bloque.position().x() > 8 || bloque.position().x() < 0} )
 	//Pregunto si el bloque esta fuera del tablero con respecto al eje Y
 	method bloqueFueraTabletoY() = listaBloque.any({bloque => bloque.position().y() < 0})
	//Pregunto si el bloque colisiona con otro bloque
	method colisionConBloque(bloqueDelTablero) =  listaBloque.any({bloque => bloque.position().y() == bloqueDelTablero.position().y() && bloque.position().x() == bloqueDelTablero.position().x()})
	method mover(cantEjeX, cantEjeY){
		listaBloque.forEach({
			bloque => bloque.position(new Position(x = bloque.position().x() + cantEjeX, y = bloque.position().y() + cantEjeY ))
		})
	}
	method moverIzquierda(){
		self.mover(-1, 0)
	}
	method moverDerecha(){
		self.mover(1, 0)
	}
	// Mover arriba se utiliza al chequear colision
	method moverArriba(){
		self.mover(0, 1)
	}
	method moverAbajo(){
		self.mover(0, -1)
	}
	method rotar(sentidoReloj, sentidoContraReloj){
		const centroX = listaBloque.get(0).position().x()
	    const centroY = listaBloque.get(0).position().y()
	    listaBloque.forEach({ bloque =>
	        var x = bloque.position().x()
	        var y = bloque.position().y()
	        bloque.position(new Position(x = centroX + sentidoReloj * (y - centroY), y = centroY + sentidoContraReloj * (x - centroX)))
	    })
	}
	method rotar90Grados(){
	    self.rotar(-1, 1)
	}
	method rotar90GradosContraReloj(){
		self.rotar(1, -1)
	}
	method mostrarFigura(){
		listaBloque.forEach({bloque =>game.addVisual(bloque)})
	}
	method formaFigura(x1, y1, x2, y2, x3, y3, colorBloque){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = colorBloque), new Bloque(position = new Position(x=posicionX + x1, y=posicionY + y1), image = colorBloque),
						    new Bloque(position = new Position(x=posicionX + x2, y=posicionY + y2), image = colorBloque), new Bloque(position = new Position(x=posicionX + x3, y=posicionY + y3), image = colorBloque)])
		self.mostrarFigura()
	}
} 
class FiguraCuadrada inherits Figura{
	const bloqueAmarillo = "assets/bloque_amarillo.jpg"
	override method rotar90Grados(){}
	method inicializarFigura(){
		self.formaFigura(1, 0, 0, -1, 1, -1, bloqueAmarillo)
	}
}
class FiguraT inherits Figura{
	const bloqueAzul = "assets/bloque_azul.jpg"
	method inicializarFigura(){
		self.formaFigura(-1, 0, 1, 0, 0, -1, bloqueAzul)
	}
}
class FiguraZ inherits Figura{
	const bloqueRojo = "assets/bloque_rojo.jpg"
	method inicializarFigura(){
		self.formaFigura(0, 1, -1, 1, 1, 0, bloqueRojo)
	}
}
class FiguraZReverse inherits Figura{
	const bloqueVioleta = "assets/bloque_gris.jpg"
	method inicializarFigura(){
		self.formaFigura(0, 1, 1, 1, -1, 0, bloqueVioleta)
	}
}
class FiguraI inherits Figura{
	const bloqueRosa = "assets/bloque_rosa.jpg"
	method inicializarFigura(){
		self.formaFigura(0, 1, 0, 2, 0, 3, bloqueRosa)
	}
}
class FiguraL inherits Figura{
	const bloqueVerde = "assets/bloque_verde.jpg"
	method inicializarFigura(){
		self.formaFigura(0, 1, 0, -1, 1, -1, bloqueVerde)
	}
}
class FiguraLReverse inherits Figura{
	const bloqueNaranja = "assets/bloque_naranja.jpg"
	method inicializarFigura(){
		self.formaFigura(0, 1, 0, -1, -1, -1, bloqueNaranja)
	}
}
