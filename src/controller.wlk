import wollok.game.*
import figuras.*
//Tablero-Controlador -> Controla todo lo que pasa en el juego

object controller{
	const listaDeFilas = []
	const bloquesDelTablero = []
	const listaDeFiguras = [new FiguraCuadrada(), new FiguraT(), new FiguraZ(), new FiguraI(), new FiguraL(), new FiguraLReverse(), new FiguraZReverse()]
	var figuraActiva		// Pieza activa del juego
	var siguienteFigura		//Siguiente Pieza
	var puntaje = 0
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
		self.inicializarFiguras()
	}
	//inicializo las figuras
	method inicializarFiguras(){
		figuraActiva.inicializarFigura()
		siguienteFigura.cambiarPosicion(11, 4)
		siguienteFigura.inicializarFigura()
	}
	//cuando FiguraActica coliciona se asigna una nueva figura tanto a figuraActiva como a siguienteFigura
	method asignarNuevaFiguraActiva(){
		siguienteFigura.cambiarPosicion(4,16)
		figuraActiva = siguienteFigura
		siguienteFigura.borrarVisual()
		self.asignarSiguienteFigura()
		self.inicializarFiguras()
	}
	//asigno la siguiente figura
	method asignarSiguienteFigura(){
		siguienteFigura = [new FiguraCuadrada(), new FiguraT(), new FiguraZ(), new FiguraI(), new FiguraL(), new FiguraLReverse(), new FiguraZReverse()].anyOne()
	}
	//inputs del teclado
	method controlTeclado(){
		keyboard.down().onPressDo({figuraActiva.moverAbajo() if(self.colisionaCon(figuraActiva)){figuraActiva.moverArriba()}})	
		keyboard.left().onPressDo({figuraActiva.moverIzquierda() if(self.colisionaCon(figuraActiva)){figuraActiva.moverDerecha()}})	
		keyboard.right().onPressDo({figuraActiva.moverDerecha() if(self.colisionaCon(figuraActiva)){figuraActiva.moverIzquierda()}})
		keyboard.a().onPressDo({figuraActiva.rotar90Grados() if(self.colisionaCon(figuraActiva)){figuraActiva.rotar90GradosContraReloj()}})
		keyboard.d().onPressDo({figuraActiva.rotar90GradosContraReloj() if(self.colisionaCon(figuraActiva)){figuraActiva.rotar90Grados()}})
		}
	//Pregunto si la figura tiene algun tipo de colision
	method colisionaCon(figura) = figura.bloqueFueraTabletoX() || figura.bloqueFueraTabletoY() || self.colisionConBloque(figura)
	//Pregunto si la figura colisiona con otro bloque
	method colisionConBloque(figura) = bloquesDelTablero.any({bloque => figura.colisionConBloque(bloque)})
	//busco lineas completas para borrarlas
	method buscarLineasCompletas() {
		var lineas = 0
		listaDeFilas.forEach({ 
			fila => if(self.bloquesDeUnaFila(fila) != null && self.CantDeBloquesEnFila(fila) == 9){
				lineas++ 
				self.gestionarBorradoDeFila(fila)				
			}
		})
		return lineas
	}
	//filtro solamente los bloques de la fila que estoy analizando
	method bloquesDeUnaFila(fila) = bloquesDelTablero.filter({ bloque => bloque.position().y() == fila })
	//calculo la cantidad de bloques que hay en esa fila
	method CantDeBloquesEnFila(fila) = self.bloquesDeUnaFila(fila).size()
	//gestiono el borrado de la fila
	method gestionarBorradoDeFila(fila){
		self.borrarFila(fila)
		self.moverBloquesHaciaAbajo(fila)
	}
	//borra la fila entera
	method borrarFila(fila){
		bloquesDelTablero.forEach({bloque => if(bloque.position().y() == fila)game.removeVisual(bloque)})
		bloquesDelTablero.removeAll(self.bloquesDeUnaFila(fila))
		puntaje += 100
	}
	//muevo todos los bloques por arriba de la fila borrada, hacia abajo, la cantidad de filas que se borraron
	method moverBloquesHaciaAbajo(fila){
		bloquesDelTablero.forEach({bloque => if(bloque.position().y() > fila) {
				bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() - 1))
			}
		})
	}
	//pregunto si hay alguna figura sobresalida del tablero
	method hayUnaFiguraSobresalida() = bloquesDelTablero.any({bloque => bloque.position().y() >= 14})
	//analiza si perdiste, osea si sobresalio alguna figura
	method perder() = self.hayUnaFiguraSobresalida()
	//menu inicial
	method apareceMenuInicial(){
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
				game.addVisual(textoPuntos)
				const musiquita = game.sound("musiquita_tetri.mp3")
    			musiquita.shouldLoop(true)
    			game.schedule(1, { musiquita.play()} )
				self.empezarJuego()
			}
			n++
		})
		game.start()
	}
	//empieza el juego
	method empezarJuego(){
		self.inicializarJuego()
		game.onTick(500, "gravedad",{
			figuraActiva.moverAbajo()
			self.buscarLineasCompletas()
			textoPuntos.cambiarPuntaje(puntaje.toString())
			if (bloquesDelTablero.any({ bloque => figuraActiva.colisionConBloque(bloque)}) or figuraActiva.bloqueFueraTabletoY()) {
				figuraActiva.moverArriba()
				bloquesDelTablero.addAll(figuraActiva.listaBloque())
				self.asignarNuevaFiguraActiva()
			}
			//si perdiste, aparece el menu final
			if(self.perder()){
				var t = 0
				game.removeTickEvent("gravedad")
				game.addVisual(menuFinal)
				game.removeVisual(textoPuntos)
				textoPuntos.position(new Position(x = 6, y = 8))
				game.addVisual(textoPuntos)
				highScore = [puntaje, highScore].max()
				textoHighscore.cambiarPuntaje(highScore.toString())
				game.addVisual(textoHighscore)
				siguienteFigura.borrarVisual()
				figuraActiva.borrarVisual()				
				keyboard.space().onPressDo({ 
					if(t == 0){
						game.removeVisual(menuFinal)
						bloquesDelTablero.forEach({bloque => game.removeVisual(bloque)})
						bloquesDelTablero.clear()
						textoPuntos.position(new Position(x = 11, y = 0))
						game.removeVisual(textoHighscore)
						puntaje = 0
						t++
						self.empezarJuego()
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
