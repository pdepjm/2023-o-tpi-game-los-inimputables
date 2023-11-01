import wollok.game.*
//Todas las figuras del juego


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
class MenuFinal_MenuInicial {
	var property image
	var property position = new Position(x = 0, y = 0)
}
object menuInicial inherits MenuFinal_MenuInicial(image = "assets/imagen_presentacion.jpg"){}
object menuFinal inherits MenuFinal_MenuInicial(image = "assets/imagen_fin_juego.jpg"){}

class Bloque {
	var property image
	var property position
}
class Figura{
	var property listaBloque = []	
	var property posicionX = 4				//posicion relativa del eje X
	var property posicionY = 16 			//posicion relativa del eje Y
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
	// Mover izquierda
	method moverIzquierda(){
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x() - 1, y = bloque.position().y() ))
		})
	}
	// Mover derecha
	method moverDerecha(){
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x() + 1, y = bloque.position().y() ))
		})
	}
	// Mover arriba (se utiliza al chequear colision)
	method moverArriba(){
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() + 1))
		})
	}
	// Mover abajo 
	method moverAbajo(){
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() - 1))
		})
	}
	method rotar90Grados(){
	    const centroX = listaBloque.get(0).position().x()
	    const centroY = listaBloque.get(0).position().y()
	    listaBloque.forEach({ bloque =>
	        var x = bloque.position().x()
	        var y = bloque.position().y()
	        bloque.position(new Position(x = centroX - (y - centroY), y = centroY + (x - centroX)))
	    })
	}
	method rotar90GradosContraReloj(){
		const centroX = listaBloque.get(0).position().x()
	    const centroY = listaBloque.get(0).position().y()
	    listaBloque.forEach({ bloque =>
	        var x = bloque.position().x()
	        var y = bloque.position().y()
	        bloque.position(new Position(x = centroX + (y - centroY), y = centroY - (x - centroX)))
	    })
	}
	method mostrarFigura(){
		listaBloque.forEach({bloque =>game.addVisual(bloque)})
	}	
}

//como no tiene sentido que el cuadrado rote, decidimos que 
class FiguraCuadrada inherits Figura{
	const bloqueAmarillo = "assets/bloque_amarillo.jpg"
	override method rotar90Grados(){}
	override method rotar90GradosContraReloj(){}
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = bloqueAmarillo), new Bloque(position = new Position(x=posicionX+1, y=posicionY), image = bloqueAmarillo),
						    new Bloque(position = new Position(x=posicionX, y=posicionY-1), image = bloqueAmarillo), new Bloque(position = new Position(x=posicionX+1, y=posicionY-1), image = bloqueAmarillo)])
		self.mostrarFigura()
	}
}
class FiguraT inherits Figura{
	const bloqueAzul = "assets/bloque_azul.jpg"
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = bloqueAzul), new Bloque(position = new Position(x=posicionX-1, y=posicionY), image = bloqueAzul), 
							new Bloque(position = new Position(x=posicionX+1, y=posicionY), image = bloqueAzul), new Bloque(position = new Position(x=posicionX, y=posicionY-1), image = bloqueAzul)])
		self.mostrarFigura()
	}
}

class FiguraZ inherits Figura{
	const bloqueRojo = "assets/bloque_rojo.jpg"
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = bloqueRojo), new Bloque(position = new Position(x=posicionX, y=posicionY+1), image = bloqueRojo),
						    new Bloque(position = new Position(x=posicionX-1, y=posicionY+1), image = bloqueRojo), new Bloque(position = new Position(x=posicionX+1, y=posicionY), image = bloqueRojo)])
		self.mostrarFigura()
	}
}
class FiguraZReverse inherits Figura{
	const bloqueVioleta = "assets/bloque_gris.jpg"
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = bloqueVioleta), new Bloque(position = new Position(x=posicionX, y=posicionY+1), image = bloqueVioleta),
						    new Bloque(position = new Position(x=posicionX+1, y=posicionY+1), image = bloqueVioleta), new Bloque(position = new Position(x=posicionX-1, y=posicionY), image = bloqueVioleta)])
		self.mostrarFigura()
	}
}
class FiguraI inherits Figura{
	const bloqueRosa = "assets/bloque_rosa.jpg"
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = bloqueRosa), new Bloque(position = new Position(x=posicionX, y=posicionY+1), image = bloqueRosa),
							new Bloque(position = new Position(x=posicionX, y=posicionY+2), image = bloqueRosa), new Bloque(position = new Position(x=posicionX, y=posicionY+3), image = bloqueRosa)])
		self.mostrarFigura()	
	}
}
class FiguraL inherits Figura{
	const bloqueVerde = "assets/bloque_verde.jpg"
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = bloqueVerde), new Bloque(position = new Position(x=posicionX, y=posicionY+1), image = bloqueVerde),
							new Bloque(position = new Position(x=posicionX, y=posicionY-1), image = bloqueVerde), new Bloque(position = new Position(x=posicionX+1, y=posicionY-1), image = bloqueVerde)])
		self.mostrarFigura()
	}
}
class FiguraLReverse inherits Figura{
	const bloqueNaranja = "assets/bloque_naranja.jpg"
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = bloqueNaranja), new Bloque(position = new Position(x=posicionX, y=posicionY+1), image = bloqueNaranja),
							new Bloque(position = new Position(x=posicionX, y=posicionY-1), image = bloqueNaranja), new Bloque(position = new Position(x=posicionX-1, y=posicionY-1), image = bloqueNaranja)])
		self.mostrarFigura()
	}
}

