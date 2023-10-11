import wollok.game.*

object figura {

	var position = game.at(4,12)
	
	method position(nuevaPosicion) { position = nuevaPosicion }
	
	method position() = position
	
	method moverseHaciaArriba(){
		self.position(position.up(1))
	}
	
	method moverseHaciaAbajo(){
		if (self.position().y() > 0) {
			self.position(position.down(1))
		}
	}
	
	method moverseHaciaIzquierda(){
		if (self.position().x() > 0) { self.position(position.left(1)) }
	}
	
	method moverseHaciaDerecha(){
		if (self.position().x() < 8) {self.position(position.right(1))}
	}
	
	method image() = "figura_ejemplo_inPixio.jpg"

}

object figura2 {

	var position = game.at(5,12)
	
	method position(nuevaPosicion) { position = nuevaPosicion }
	
	method position() = position
	
	method moverseHaciaArriba(){
		self.position(position.up(1))
	}
	
	method moverseHaciaAbajo(){
		if (self.position().y() > 0 and self.position().y() != figura.position().y() + 1 and self.position().x() != figura.position().x()) {
			self.position(position.down(1))
		}
	}
	
	method moverseHaciaIzquierda(){
		if (self.position().x() > 0) { self.position(position.left(1)) }
	}
	
	method moverseHaciaDerecha(){
		if (self.position().x() < 8) {self.position(position.right(1))}
	}
	
	method image() = "figura_ejemplo_inPixio_2.jpg"

}