import wollok.game.*

object amarillo { 
	method image() = "bloque_amarillo"
		
	}

class Bloque {
	var property position
	method image() = "bloque_amarillo.jpg"
}

class FiguraCuadrada {
	
	const property listaBloque = []	
	var property posicionX = 4				//posicion relativa del eje X
	var property posicionY = 11				//posicion relativa del eje Y
	var property enUso = false
	
	//Inicializo la figura(FALTA VER HERENCIA)
	method inicializarFigura(){
		const bloque1 = new Bloque(position =  new Position(x=posicionX, y=posicionY))
		const bloque3 = new Bloque(position = new Position(x=posicionX, y=posicionY+1))
		const bloque2 = new Bloque(position = new Position(x=posicionX+1, y=posicionY))
		const bloque4 = new Bloque(position = new Position(x=posicionX+1, y=posicionY+1))
		game.addVisual(bloque1)
    	game.addVisual(bloque2)
    	game.addVisual(bloque3)
    	game.addVisual(bloque4)
    	listaBloque.add(bloque1)
		listaBloque.add(bloque2)
		listaBloque.add(bloque3)
		listaBloque.add(bloque4)
   
	}
	
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
		posicionX++
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x() + 1, y = bloque.position().y() ))
		})
	}
	// Mover arriba (se utiliza al chequear colision)
	method moverArriba() {
		posicionY++
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() + 1))
		})
	}
	// Mover abajo 
	method moverAbajo() {
		posicionY--
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() - 1))
		})
	}

}

class FiguraTe {
	
	const property listaBloque = []	
	var property posicionX = 4				//posicion relativa del eje X
	var property posicionY = 11				//posicion relativa del eje Y
	var property enUso = false
	
	//Inicializo la figura(FALTA VER HERENCIA)
	method inicializarFigura(){
		const bloque1 = new Bloque(position =  new Position(x=posicionX-1, y=posicionY))
		const bloque3 = new Bloque(position = new Position(x=posicionX, y=posicionY))
		const bloque2 = new Bloque(position = new Position(x=posicionX+1, y=posicionY))
		const bloque4 = new Bloque(position = new Position(x=posicionX, y=posicionY+1))
		game.addVisual(bloque1)
    	game.addVisual(bloque2)
    	game.addVisual(bloque3)
    	game.addVisual(bloque4)
    	listaBloque.add(bloque1)
		listaBloque.add(bloque2)
		listaBloque.add(bloque3)
		listaBloque.add(bloque4)
   
	}
	
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
		posicionX++
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x() + 1, y = bloque.position().y() ))
		})
	}
	// Mover arriba (se utiliza al chequear colision)
	method moverArriba() {
		posicionY++
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() + 1))
		})
	}
	// Mover abajo 
	method moverAbajo() {
		posicionY--
		listaBloque.forEach({		
			bloque => bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() - 1))
		})
	}

}
