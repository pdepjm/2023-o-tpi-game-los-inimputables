import wollok.game.*
import figuras.*
//Tablero-Controlador -> Controla todo lo que pasa en el juego

object controller{
	const listaDeFilas = []
	const bloquesDelTablero = [] // new Bloque(position = new Position(x = 1, y = 13),image = "assets/bloque_amarillo.jpg")
	var figuraActiva			// Pieza activa del juego
	const listaDeFiguras = [new FiguraCuadrada(), new FiguraT(), new FiguraZ(), new FiguraI(), new FiguraL(), new FiguraLReverse(), new FiguraZReverse()]
	var property siguienteFigura	// Siguiente Pieza
	var property puntaje = 0
	var highScore = 0
	//FILAS
	method construccionDeFilas(){
		(0..15).forEach({fila => listaDeFilas.add(fila)})
	}
	//Inicializo el juego
	method inicializarJuego(){
		self.construccionDeFilas()
		figuraActiva = listaDeFiguras.anyOne()
		self.asignarSiguienteFigura()
		figuraActiva.inicializarFigura()
		siguienteFigura.cambiarPosicion(11,3)
		siguienteFigura.inicializarFigura()
		
			
	}
	//cuando FiguraActica coliciona se asigna una nueva figura a: figuraActiva y siguienteFigura
	method asignarNuevaFiguraActiva(){
		siguienteFigura.cambiarPosicion(4,16)
		siguienteFigura.borrarVisual()
		figuraActiva = siguienteFigura
		figuraActiva.inicializarFigura()
		self.asignarSiguienteFigura()
		siguienteFigura.cambiarPosicion(11,3)
		siguienteFigura.inicializarFigura()
	}
	method asignarSiguienteFigura(){
		siguienteFigura = [new FiguraCuadrada(), new FiguraT(), new FiguraZ(), new FiguraI(), new FiguraL(), new FiguraLReverse(), new FiguraZReverse()].anyOne()
	}
	//Metodo para asignar una nueva figura a siguienteFigura
	//inputs del teclado
	method controlTeclado(){
		keyboard.down().onPressDo({figuraActiva.moverAbajo() if(self.colisionaCon(figuraActiva)){figuraActiva.moverArriba()}})	
		keyboard.left().onPressDo({figuraActiva.moverIzquierda() if(self.colisionaCon(figuraActiva)){figuraActiva.moverDerecha()}})	
		keyboard.right().onPressDo({figuraActiva.moverDerecha() if(self.colisionaCon(figuraActiva)){figuraActiva.moverIzquierda()}})
		keyboard.d().onPressDo({figuraActiva.rotar90Grados() if(self.colisionaCon(figuraActiva)){figuraActiva.rotar90GradosContraReloj()}})
		keyboard.a().onPressDo({figuraActiva.rotar90GradosContraReloj() if(self.colisionaCon(figuraActiva)){figuraActiva.rotar90Grados()}})
		}
	//Pregunto si la figura tiene algun tipo de colision
	method colisionaCon(figura) = figura.bloqueFueraTabletoX() || figura.bloqueFueraTabletoY() || self.colisionConBloque(figura)
	//Pregunto si la figura colisiona con otro bloque
	method colisionConBloque(figura) = bloquesDelTablero.any({bloque => figura.colisionConBloque(bloque)})
	method buscarLineasCompletas() {
		var lineas = 0
		listaDeFilas.forEach({
			fila => if(self.bloquesDeUnaFila(fila) != null && self.CantDeBloquesEnFila(fila) == 9) {
						lineas++
						self.gestionarBorradoDeFila(fila)				
					}
		})
		return lineas
	}
	method bloquesDeUnaFila(fila) = bloquesDelTablero.filter({
		bloque => bloque.position().y() == fila
	})
	method CantDeBloquesEnFila(fila) = self.bloquesDeUnaFila(fila).size()
	
	method gestionarBorradoDeFila(fila){
		self.borrarFila(fila)
		self.moverBloquesHaciaAbajo(fila)
	}
	method borrarFila(fila){
		bloquesDelTablero.forEach({bloque => if(bloque.position().y() == fila)game.removeVisual(bloque)})
		bloquesDelTablero.removeAll(self.bloquesDeUnaFila(fila))
		puntaje += 100
	}
	method moverBloquesHaciaAbajo(fila){
		bloquesDelTablero.forEach({bloque => if(bloque.position().y() > fila) {
											 	bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() - 1))
											 }
								  })
	}
	method hayUnaFiguraSobresalida() = bloquesDelTablero.any({bloque => bloque.position().y() >= 14})
	method perder() = self.hayUnaFiguraSobresalida()
	//Arranca el juego
	method arrancarJuego(){
		var n = 0
		game.title("Tetris")
		game.width(14)
		game.height(15)
		game.cellSize(40)
		game.boardGround("assets/tablero.jpg")
		self.controlTeclado()
		game.addVisual(menuInicial)
		keyboard.space().onPressDo({ 
			if(n == 0){
				game.removeVisual(menuInicial)
				self.empezarJuego()
			}
			n++
		})
		game.start()
	}
	method empezarJuego(){
		self.inicializarJuego()
		game.addVisual(textoPuntos)
		game.addVisual(textoSiguienteFigura)
		game.onTick(500, "gravedad",{
			textoPuntos.cambiarPuntaje(puntaje.toString())
			figuraActiva.moverAbajo()
			self.buscarLineasCompletas()
			if (bloquesDelTablero.any({ bloque => figuraActiva.colisionConBloque(bloque)}) or figuraActiva.bloqueFueraTabletoY()) {
				figuraActiva.moverArriba()
				bloquesDelTablero.addAll(figuraActiva.listaBloque())
				self.asignarNuevaFiguraActiva()
			}
			//perder
			if(self.perder()){
				var t = 0
				game.removeTickEvent("gravedad")
				game.addVisual(menuFinal)
				game.addVisual(textoFinJuego)
				textoFinJuego.text(puntaje)
				game.addVisual(textoFinJuego2)
				textoFinJuego2.text(highScore)
				game.addVisual(textoFinJuego3)
				
				keyboard.space().onPressDo({ 
					if(t == 0){
						game.removeVisual(menuFinal)
						bloquesDelTablero.forEach({bloque => game.removeVisual(bloque)})
						bloquesDelTablero.clear()
						//self.asignarSiguienteFigura()
						game.removeVisual(textoPuntos)
						game.removeVisual(textoSiguienteFigura)
						
						self.empezarJuego()
						t++
						if(puntaje > highScore){highScore = puntaje}
					}
				})
				keyboard.x().onPressDo({
					if(t == 0){
						game.stop()
					}
				})									   
			}
		})
	}
}				
		
