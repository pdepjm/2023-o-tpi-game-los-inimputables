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
		(0..14).forEach({fila => listaDeFilas.add(fila)})
	}
	//Inicializo el juego
	method inicializarJuego(){
		figuraActiva = listaDeFiguras.anyOne()
		self.construccionDeFilas()
		self.asignarSiguienteFigura()
		self.inicializarFiguras()
	}
	//asigno la siguiente figura
	method asignarSiguienteFigura(){
		siguienteFigura = [new FiguraCuadrada(), new FiguraT(), new FiguraZ(), new FiguraI(), new FiguraL(), new FiguraLReverse(), new FiguraZReverse()].anyOne()
	}
	//inicializo las figuras
	method inicializarFiguras(){
		figuraActiva.inicializarFigura()
		siguienteFigura.cambiarPosicionFigura(11, 4)
		siguienteFigura.inicializarFigura()
	}
	//cuando FiguraActica coliciona se asigna una nueva figura tanto a figuraActiva como a siguienteFigura
	method asignarNuevaFiguraActiva(){
		siguienteFigura.cambiarPosicionFigura(4,16)
		figuraActiva = siguienteFigura
		siguienteFigura.borrarFigura()
		self.asignarSiguienteFigura()
		self.inicializarFiguras()
	}
	//inputs del teclado
	method controlTeclado(){
		keyboard.down().onPressDo({figuraActiva.moverFiguraAbajo(bloquesDelTablero)})
		keyboard.left().onPressDo({figuraActiva.moverFiguraIzquierda(bloquesDelTablero)})
		keyboard.right().onPressDo({figuraActiva.moverFiguraDerecha(bloquesDelTablero)})
		keyboard.a().onPressDo({figuraActiva.rotarFigura90Grados(bloquesDelTablero)})
		keyboard.d().onPressDo({figuraActiva.rotarFigura90GradosContraReloj(bloquesDelTablero)})
		}
	//busco lineas completas para borrarlas
	method buscarLineasCompletas(){
		var lineas = 0
		listaDeFilas.forEach({
			fila => if(self.bloquesDeUnaFila(fila) != null && self.CantDeBloquesEnFila(fila) == 9){
				lineas++
				self.gestionarBorradoDeFila(fila)
			}
		})
	}
	//filtro solamente los bloques de la fila que estoy analizando
	method bloquesDeUnaFila(fila) = bloquesDelTablero.filter({bloque => bloque.position().y() == fila})
	//calculo la cantidad de bloques que hay en esa fila
	method CantDeBloquesEnFila(fila) = self.bloquesDeUnaFila(fila).size()
	//gestiono el borrado de la fila
	method gestionarBorradoDeFila(fila){
		self.borrarFila(fila)
		self.moverBloquesHaciaAbajo(fila)
	}
	//borra la fila entera
	method borrarFila(fila){
		bloquesDelTablero.forEach({bloque => if(bloque.position().y() == fila) 
			bloque.borrarBloque()
		})
		bloquesDelTablero.removeAll(self.bloquesDeUnaFila(fila))
		self.asignarPuntos()
	}
	method asignarPuntos(){
		puntaje += 100
		textoPuntos.cambiarPuntaje(puntaje.toString())
		highScore = [puntaje, highScore].max()
	}
	//muevo todos los bloques por arriba de la fila borrada, hacia abajo, la cantidad de filas que se borraron
	method moverBloquesHaciaAbajo(fila){
		bloquesDelTablero.forEach({bloque => if(bloque.position().y() > fila){
				bloque.mover(0, -1)
			}
		})
	}
	//pregunto si hay alguna figura sobresalida del tablero
	method hayUnaFiguraSobresalida() = bloquesDelTablero.any({bloque => bloque.position().y() >= 14})
	//analiza si perdiste, osea si sobresalio alguna figura
	method perder() = self.hayUnaFiguraSobresalida()
	//si perdiste, aparece el menu final
	method analizarPerder(){
		if(self.perder()){
			siguienteFigura.borrarFigura()
			figuraActiva.borrarFigura()
			game.removeTickEvent("gravedad")
			game.addVisual(menuFinal)
			game.removeVisual(textoPuntos)
			textoPuntos.position(new Position(x = 6, y = 8))
			game.addVisual(textoPuntos)
			textoHighscore.cambiarPuntaje(highScore.toString())
			game.addVisual(textoHighscore)
			self.salirOReiniciar()
		}
	}
	method salirOReiniciar(){
		var t = 0
		keyboard.space().onPressDo({
			if(t == 0){
				game.removeVisual(menuFinal)
				bloquesDelTablero.forEach({bloque => bloque.borrarBloque()})
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
	method inicioJuego(){
		var n = 0
		game.title("Tetris")
		game.width(14)
		game.height(15)
		game.cellSize(40)
		game.boardGround("assets/tablero.jpg")
		game.addVisual(menuInicial)
		self.controlTeclado()
		keyboard.space().onPressDo({
			if(n == 0){
				game.removeVisual(menuInicial)
				game.addVisual(textoPuntos)
				const musiquita = game.sound("musiquita_tetri.mp3")
    			musiquita.shouldLoop(true)
    			game.schedule(1, {musiquita.play()})
				self.empezarJuego()
			}
			n++
		})
		game.start()
	}
	//empieza el juego
	method empezarJuego(){
		self.inicializarJuego()
		game.onTick(500, "gravedad", {
			figuraActiva.moverFiguraAbajo(bloquesDelTablero)
			self.buscarLineasCompletas()
			if(figuraActiva.figuraColisiona(bloquesDelTablero) or figuraActiva.listaBloques().any({bloque => bloque.position().y() == 0})){
				bloquesDelTablero.addAll(figuraActiva.listaBloques())
				self.asignarNuevaFiguraActiva()
			}
			textoPuntos.cambiarPuntaje(puntaje.toString())
			self.analizarPerder()
		})
	}
}