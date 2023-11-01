import wollok.game.*
//Todas las figuras del juego

object textoPuntos{
	var property position = new Position(x = 11, y = 12)
	var text = "puntaje: 0"
	method text() = text
	method cambiarPuntaje(puntaje){
		if(puntaje > 0){
			text = "puntos: " + puntaje
		}
	}
}
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
	
	// matriz 4 x 4 ==> matriz rotada 90 grados a la derecha
	/*
	 [ 1,  2,  3,  4] ==> [13,  9, 5, 1]
	 [ 5,  6,  7,  8] ==> [14, 10, 6, 2]
	 [ 9, 10, 11, 12] ==> [15, 11, 7, 3]
	 [13, 14, 15, 16] ==> [16, 12, 8, 4]
	 */

	//Pregunto si el bloque esta fuera del tablero con respecto al eje X
	method bloqueFueraTabletoX() = listaBloque.any({bloque => bloque.position().x() > 8 || bloque.position().x() < 0} )
 	//Pregunto si el bloque esta fuera del tablero con respecto al eje Y
 	method bloqueFueraTabletoY() = listaBloque.any({bloque => bloque.position().y() < 0})
	//Pregunto si el bloque colisiona con otro bloque
	method colisionConBloque(bloqueDelTablero) =  listaBloque.any({bloque => bloque.position().y() == bloqueDelTablero.position().y() && bloque.position().x() == bloqueDelTablero.position().x()})
	// Mover izquierda
	method moverIzquierda(){
		posicionX--
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


class FiguraCuadrada inherits Figura{
	const bloqueAmarillo = "assets/bloque_amarillo.jpg"
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
	const bloqueVioleta = "assets/bloque_violeta.png"
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
	const bloqueNaranja = "assets/bloque_naranja.png"
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = bloqueNaranja), new Bloque(position = new Position(x=posicionX, y=posicionY+1), image = bloqueNaranja),
							new Bloque(position = new Position(x=posicionX, y=posicionY-1), image = bloqueNaranja), new Bloque(position = new Position(x=posicionX-1, y=posicionY-1), image = bloqueNaranja)])
		self.mostrarFigura()
	}
}
class SiguienteFigura{
	var property posicionX = 12
	var property posicionY = 7
	var property listaDeBloques = []
	method inicializarSiguienteFigura(lista){
		lista.forEach({bloque =>game.addVisual(bloque)})
	}
}