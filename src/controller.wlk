import wollok.game.*
import metodos.*
object controller {
	const filas = 12
	const columnas =9 
	var property bloquesDelTablero = []
	var property figuraActiva				  // Pieza activa del juego
	var property siguienteFigura					  // Siguiente Pieza
	const property listaDeFiguras = []
	
	method inicializarJuego(){
		listaDeFiguras.add(new FiguraCuadrada())
		figuraActiva = listaDeFiguras.head()
		figuraActiva.inicializarFigura()
		
	}
	method controlTeclado(){
		// Move and check collisions	
		keyboard.down().onPressDo({figuraActiva.MoveDown() if(self.colisionaCon(figuraActiva)){figuraActiva.MoveUp()}})	
		keyboard.left().onPressDo({figuraActiva.MoveLeft()if(self.colisionaCon(figuraActiva)){figuraActiva.MoveRight()}})	
		keyboard.right().onPressDo({figuraActiva.MoveRight()if(self.colisionaCon(figuraActiva)){figuraActiva.MoveLeft()}})
		}
	method colisionaCon(figura) = figura.bloqueFueraTabletoX(columnas) || figura.bloqueFueraTabletoY() || self.colisionConBloque(figura)
	
	method colisionConBloque(figura) = bloquesDelTablero.any({
		bloque => figura.colisionConBloque(bloque)			     
	})
		
	
	
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
