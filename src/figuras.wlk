import wollok.game.*
//Todas las figuras del juego

class Bloque {
	var property image
	var property position
}

class Figura{
	var property listaBloque = []	
	var property posicionX = 4				//posicion relativa del eje X
	var property posicionY = 11				//posicion relativa del eje Y
	var property enUso = false
	
	// matriz 4 x 4 ==> matriz rotada 90 grados a la derecha
	/*
	 [ 1,  2,  3,  4] ==> [13,  9, 5, 1]
	 [ 5,  6,  7,  8] ==> [14, 10, 6, 2]
	 [ 9, 10, 11, 12] ==> [15, 11, 7, 3]
	 [13, 14, 15, 16] ==> [16, 12, 8, 4]
	 */

	//Pregunto si el bloque esta fuera del tablero con respecto al eje X
	method bloqueFueraTabletoX(columnas) = listaBloque.any({bloque => bloque.position().x() > columnas - 1 || bloque.position().x() < 0} )
 	
 	//Pregunto si el bloque esta fuera del tablero con respecto al eje Y
 	method bloqueFueraTabletoY() = listaBloque.any({bloque => bloque.position().y() < 0})
	
	//Pregunto si el bloque colisiona con otro bloque
	method colisionConBloque(bloquesDelTablero) =  listaBloque.any({bloque => bloque.position().y() == bloquesDelTablero.position().y() && bloque.position().x() == bloquesDelTablero.position().x()})
	
	// Mover izquierda
	method moverIzquierda() {
		posicionX--
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x() - 1, y = bloque.position().y() ))
		})
	}
	// Mover derecha
	method moverDerecha() {
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x() + 1, y = bloque.position().y() ))
		})
	}
	// Mover arriba (se utiliza al chequear colision)
	method moverArriba() {
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() + 1))
		})
	}
	// Mover abajo 
	method moverAbajo() {
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() - 1))
		})
	}
	
	method rotar90Grados() {
	    var centroX = listaBloque.get(0).position().x()
	    var centroY = listaBloque.get(0).position().y()
	    listaBloque.forEach({ bloque =>
	        var x = bloque.position().x()
	        var y = bloque.position().y()
	        bloque.position(new Position(x = centroX - (y - centroY), y = centroY + (x - centroX)))
	    })
	}
	
}


class FiguraCuadrada inherits Figura {
		
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = "assets/bloque_amarillo.jpg"), new Bloque(position = new Position(x=posicionX+1, y=posicionY), image = "assets/bloque_amarillo.jpg"),
						    new Bloque(position = new Position(x=posicionX, y=posicionY-1), image = "assets/bloque_amarillo.jpg"), new Bloque(position = new Position(x=posicionX+1, y=posicionY-1), image = "assets/bloque_amarillo.jpg")])
		listaBloque.forEach({bloque =>game.addVisual(bloque)})
    	
	}
}

class FiguraT inherits Figura{
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = "assets/bloque_azul.jpg"), new Bloque(position = new Position(x=posicionX-1, y=posicionY), image = "assets/bloque_azul.jpg"), 
							new Bloque(position = new Position(x=posicionX+1, y=posicionY), image = "assets/bloque_azul.jpg"), new Bloque(position = new Position(x=posicionX, y=posicionY-1), image = "assets/bloque_azul.jpg")])
		listaBloque.forEach({bloque =>game.addVisual(bloque)})
	
	}
}

class FiguraZ inherits Figura{
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = "assets/bloque_rojo.jpg"), new Bloque(position = new Position(x=posicionX, y=posicionY+1), image = "assets/bloque_rojo.jpg"),
						    new Bloque(position = new Position(x=posicionX-1, y=posicionY+1), image = "assets/bloque_rojo.jpg"), new Bloque(position = new Position(x=posicionX+1, y=posicionY), image = "assets/bloque_rojo.jpg")])
		listaBloque.forEach({bloque =>game.addVisual(bloque)})
	}
}

class FiguraI inherits Figura{
	
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = "assets/bloque_rosa.jpg"), new Bloque(position = new Position(x=posicionX, y=posicionY+1), image = "assets/bloque_rosa.jpg"),
							new Bloque(position = new Position(x=posicionX, y=posicionY+2), image = "assets/bloque_rosa.jpg"), new Bloque(position = new Position(x=posicionX, y=posicionY+3), image = "assets/bloque_rosa.jpg")])
		listaBloque.forEach({bloque =>game.addVisual(bloque)})	
	}
}

class FiguraL inherits Figura{
	
	method inicializarFigura(){
		listaBloque.addAll([new Bloque(position = new Position(x=posicionX, y=posicionY), image = "assets/bloque_verde.jpg"), new Bloque(position = new Position(x=posicionX, y=posicionY+1), image = "assets/bloque_verde.jpg"),
							new Bloque(position = new Position(x=posicionX, y=posicionY-1), image = "assets/bloque_verde.jpg"), new Bloque(position = new Position(x=posicionX+1, y=posicionY-1), image = "assets/bloque_verde.jpg")])
		listaBloque.forEach({bloque =>game.addVisual(bloque)})
	}
}