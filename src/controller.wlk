import wollok.game.*
import figuras.*
//Tablero-Controlador -> Controla todo lo que pasa en el juego
object controller {
	const filas = 12
	const listaDeFilas = []
	const columnas =9 
	var property bloquesDelTablero = []
	var property figuraActiva			// Pieza activa del juego
	const listaDeFiguras = [new FiguraCuadrada(), new FiguraT(), new FiguraZ(), new FiguraI(), new FiguraL(), new FiguraLReverse(), new FiguraZReverse()]
	var property siguienteFigura		// Siguiente Pieza
	//FILAS
	method construccionDeFilas(){
		(0..filas).forEach({fila => listaDeFilas.add(fila)})
	}
	//Inicializo el juego
	method inicializarJuego(){
		self.construccionDeFilas()
		figuraActiva = listaDeFiguras.anyOne()
		self.asignarSiguienteFigura()
		figuraActiva.inicializarFigura()	
	}
	
	//cuando FiguraActica coliciona se asigna una nueva figura a: figuraActiva y siguienteFigura
	method asignarNuevaFiguraActiva(){
		figuraActiva = siguienteFigura
		self.asignarSiguienteFigura()
		figuraActiva.inicializarFigura()
	}
	
	//Metodo para asignar una nueva figura a siguienteFigura
	method asignarSiguienteFigura(){
		siguienteFigura = [new FiguraCuadrada(), new FiguraT(), new FiguraZ(), new FiguraI(), new FiguraL(), new FiguraLReverse(), new FiguraZReverse()].anyOne()
	}
	
	//inputs del teclado
	method controlTeclado(){
		keyboard.down().onPressDo({figuraActiva.moverAbajo() if(self.colisionaCon(figuraActiva)){figuraActiva.moverArriba()}})	
		keyboard.left().onPressDo({figuraActiva.moverIzquierda()if(self.colisionaCon(figuraActiva)){figuraActiva.moverDerecha()}})	
		keyboard.right().onPressDo({figuraActiva.moverDerecha()if(self.colisionaCon(figuraActiva)){figuraActiva.moverIzquierda()}})
		keyboard.space().onPressDo({figuraActiva.rotar90Grados()if(self.colisionaCon(figuraActiva)){figuraActiva.rotar90GradosContraReloj()}})
		keyboard.up().onPressDo({figuraActiva.rotar90GradosContraReloj()if(self.colisionaCon(figuraActiva)){figuraActiva.rotar90Grados()}})
		}
	//Pregunto si la figura tiene algun tipo de colision
	method colisionaCon(figura) = figura.bloqueFueraTabletoX(columnas) || figura.bloqueFueraTabletoY() || self.colisionConBloque(figura)
	//Pregunto si la figura colisiona con otro bloque
	method colisionConBloque(figura) = bloquesDelTablero.any({bloque => figura.colisionConBloque(bloque)})
	method buscarLineasCompletas() {
		var lineas = 0
		listaDeFilas.forEach({
			fila => if(self.bloquesDeUnaFila(fila)!= null && self.CantDeBloquesEnFila(fila) == columnas) {
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
	}
	method moverBloquesHaciaAbajo(fila){
		bloquesDelTablero.forEach({bloque => if(bloque.position().y() > fila) {
			bloque.position(new Position(x = bloque.position().x(), y = bloque.position().y() - 1))}})
	}
	//Arranca el juego
	method start() {		
		game.title("Tetris")
		game.width(columnas)
		game.height(filas)
		game.cellSize(40)
		game.ground("assets/fondo.jpg")
		self.inicializarJuego()	
		self.controlTeclado()
		game.onTick(750, "gravedad",{
			figuraActiva.moverAbajo()
			self.buscarLineasCompletas()
			if (bloquesDelTablero.any({ bloque => figuraActiva.colisionConBloque(bloque)}) or figuraActiva.bloqueFueraTabletoY()) {
				figuraActiva.moverArriba()
				bloquesDelTablero.addAll(figuraActiva.listaBloque())
				self.asignarNuevaFiguraActiva()
				
		}})		
		
				
		game.start()								// Inicio de juego
	}
}
