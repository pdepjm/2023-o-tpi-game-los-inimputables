import wollok.game.*
import metodos.*
object controller {
	const filas = 12
	const columnas =9 
	var property bloquesDelTablero = []
	var property figuraActiva			// Pieza activa del juego
	var property siguienteFigura		// Siguiente Pieza
	const property listaDeFiguras = []
	
	//Inicializo el juego
	method inicializarJuego(){
		listaDeFiguras.add(new FiguraCuadrada())
		figuraActiva = listaDeFiguras.head()
		figuraActiva.inicializarFigura()
		
	}
	//inputs del teclado
	method controlTeclado(){
		keyboard.down().onPressDo({figuraActiva.moverAbajo() if(self.colisionaCon(figuraActiva)){figuraActiva.moverArriba()}})	
		keyboard.left().onPressDo({figuraActiva.moverIzquierda()if(self.colisionaCon(figuraActiva)){figuraActiva.moverDerecha()}})	
		keyboard.right().onPressDo({figuraActiva.moverDerecha()if(self.colisionaCon(figuraActiva)){figuraActiva.moverIzquierda()}})
		}
	//Pregunto si la figura tiene algun tipo de colision
	method colisionaCon(figura) = figura.bloqueFueraTabletoX(columnas) || figura.bloqueFueraTabletoY() || self.colisionConBloque(figura)
	//Pregunto si la figura colisiona con otro bloque
	method colisionConBloque(figura) = bloquesDelTablero.any({
		bloque => figura.colisionConBloque(bloque)			     
	})
	
	//Arranca el juego
	method start() {		
		game.title("Tetris")
		game.width(columnas)
		game.height(filas)
		game.cellSize(40)
		game.ground("fondo.jpg")
		self.inicializarJuego()	
		self.controlTeclado()
		const tablero1 = new Bloque(position =  new Position(x=4, y=0))
		game.addVisual(tablero1)
		bloquesDelTablero.add(tablero1)					
		game.start()								// Inicio de juego
	}
}
