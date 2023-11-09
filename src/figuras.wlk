import wollok.game.*
import controller.*
//Todas las figuras del juego

//textos del puntaje actual y del highScore
class Textos{
	var property position
	var text = ""
	method textColor() = "FFFFFFF"
	method cambiarPuntaje(puntaje){
			text = puntaje
	}
	method text() = text
}
object textoHighscore inherits Textos(position = new Position(x = 6, y = 3)){}
object textoPuntos inherits Textos(position = new Position(x = 11, y = 0)){}


//menu inicial y final
class Menus{
	var property image
	var property position = new Position(x = 0, y = 0)
}
object menuInicial inherits Menus(image = "assets/imagen_presentacion.jpg"){}
object menuFinal inherits Menus(image = "assets/imagen_fin_juego.jpg"){}


class Bloque{
	var property image
	var property position
	
	//Pregunto si el bloque esta fuera del tablero con respecto al eje X
	method bloqueFueraTableroX() = self.position().x() > 8 or self.position().x() < 0
 	//Pregunto si el bloque esta fuera del tablero con respecto al eje Y
 	method bloqueFueraTableroY() = self.position().y() < 0
 	method bloqueEnBordeTableroY() = self.position().y() == 0
 	method bloqueSobresalidoY() = self.position().y() >= 14
 	method colisionConAlgunBloque(bloquesDelTablero) = bloquesDelTablero.any({bloque => self.position().y() == bloque.position().y() and self.position().x() == bloque.position().x()})
 	method colisiona(bloquesDelTablero) = self.bloqueFueraTableroX() or self.bloqueFueraTableroY() or self.colisionConAlgunBloque(bloquesDelTablero)
 	method mover(cantEjeX, cantEjeY){
 		self.position(new Position(x = self.position().x() + cantEjeX, y = self.position().y() + cantEjeY))
 	}
 	method moverBloqueIzquierda(bloquesDelTablero, figura){
 		self.mover(-1, 0)
 		if(self.colisiona(bloquesDelTablero)){
				figura.moverFiguraDerecha(bloquesDelTablero)
		}
 	}
 	method moverBloqueDerecha(bloquesDelTablero, figura){
 		self.mover(1, 0)
 		if(self.colisiona(bloquesDelTablero)){
				figura.moverFiguraIzquierda(bloquesDelTablero)
		}
 	}
 	method moverBloqueAbajo(){
 		self.mover(0, -1)
 	}
 	method moverBloqueArriba(){
 		self.mover(0, 1)
 	}
	method rotarBloque(valorX, valorY, figura, bloquesDelTablero){
		const centroX = figura.listaBloques().get(0).position().x()
	    const centroY = figura.listaBloques().get(0).position().y()
		var x
		var y
		x = self.position().x()
	    y = self.position().y()
	    self.position(new Position(x = centroX + valorX * (y - centroY), y = centroY + valorY * (x - centroX)))
	}
	method rotarBloque90Grados(figura, bloquesDelTablero){
		self.rotarBloque(-1, 1, figura, bloquesDelTablero)
		if(self.colisiona(bloquesDelTablero)){
	    		self.rotarBloque90GradosContraReloj(figura, bloquesDelTablero)
	    }
	}
	method rotarBloque90GradosContraReloj(figura, bloquesDelTablero){
		self.rotarBloque(1, -1, figura, bloquesDelTablero)
		if(self.colisiona(bloquesDelTablero)){
	    		self.rotarBloque90Grados(figura, bloquesDelTablero)
	    }
	}
	method borrarBloque(){
		game.removeVisual(self)
	}
	method mostrarBloque(){
		game.addVisual(self)
	}
}


class Figura{
	var property image
	var property listaBloques = []
	//posicion relativa del eje X
	var property posicionX = 4
	//posicion relativa del eje Y
	var property posicionY = 16
	
	method cambiarPosicionFigura(nuevaPosicionX, nuevaPosicionY){
		posicionX = nuevaPosicionX
		posicionY = nuevaPosicionY
	}
	method moverFiguraIzquierda(bloquesDelTablero){
		listaBloques.forEach({bloque => 
			bloque.moverBloqueIzquierda(bloquesDelTablero, self)
		})
	}
	method moverFiguraDerecha(bloquesDelTablero){
		listaBloques.forEach({bloque => 
			bloque.moverBloqueDerecha(bloquesDelTablero, self)
		})
	}
	method moverFiguraAbajo(){
		listaBloques.forEach({bloque => 
			bloque.moverBloqueAbajo()
		})
	}
	method moverFiguraArriba(){
		listaBloques.forEach({bloque => 
			bloque.moverBloqueArriba()
		})
	}
	method rotarFigura90Grados(bloquesDelTablero){
		listaBloques.forEach({bloque =>
	   		bloque.rotarBloque90Grados(self, bloquesDelTablero)
		})
	}
	method rotarFigura90GradosContraReloj(bloquesDelTablero){
		self.listaBloques().forEach({bloque => 
			bloque.rotarBloque90Grados(self, bloquesDelTablero)
			
		})
	}
	method figuraColisiona(bloquesDelTablero) = self.listaBloques().any({bloque => bloque.colisiona(bloquesDelTablero)})
	method figura(x1, y1, x2, y2, x3, y3, colorBloque){
		listaBloques.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = colorBloque), new Bloque(position = new Position(x=posicionX + x1, y=posicionY + y1), image = colorBloque),
		 					 new Bloque(position = new Position(x=posicionX + x2, y=posicionY + y2), image = colorBloque), new Bloque(position = new Position(x=posicionX + x3, y=posicionY + y3), image = colorBloque)])
		self.mostrarFigura()
	}
	method mostrarFigura(){
		listaBloques.forEach({bloque => bloque.mostrarBloque()})
	}
	method borrarFigura(){
		listaBloques.forEach({bloque => bloque.borrarBloque()})
		listaBloques.clear()
	}
}


class FiguraCuadrada inherits Figura(image = "assets/bloque_amarillo.jpg"){
	override method rotarFigura90Grados(bloquesDelTablero){
		self.moverFiguraArriba()
	}
	override method rotarFigura90GradosContraReloj(bloquesDelTablero){
		self.moverFiguraAbajo()
	}
	method inicializarFigura(){
		self.figura(1, 0, 0, -1, 1, -1, image)
	}
}
class FiguraT inherits Figura(image = "assets/bloque_azul.jpg"){
	method inicializarFigura(){
		self.figura(-1, 0, 1, 0, 0, -1, image)
	}
}
class FiguraZ inherits Figura(image = "assets/bloque_rojo.jpg"){
	method inicializarFigura(){
		self.figura(0, 1, -1, 1, 1, 0, image)
	}
}
class FiguraZReverse inherits Figura(image = "assets/bloque_gris.jpg"){
	method inicializarFigura(){
		self.figura(0, 1, 1, 1, -1, 0, image)
	}
}
class FiguraI inherits Figura(image = "assets/bloque_rosa.jpg"){
	method inicializarFigura(){
		self.figura(0, 1, 0, 2, 0, 3, image)
	}
}
class FiguraL inherits Figura(image = "assets/bloque_verde.jpg"){
	method inicializarFigura(){
		self.figura(0, 1, 0, -1, 1, -1, image)
	}
}
class FiguraLReverse inherits Figura(image = "assets/bloque_naranja.jpg"){
	method inicializarFigura(){
		self.figura(0, 1, 0, -1, -1, -1, image)
	}
}