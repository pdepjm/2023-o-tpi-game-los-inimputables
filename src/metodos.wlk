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

// aca esta lo que no me deja commitear

/*
import wollok.game.*

class FiguraT {
	
	const listaBloques = [new Bloque(position = game.at(3,11)), new Bloque(position = game.at(4,11)), new Bloque(position = game.at(5,11)), new Bloque(position = game.at(4,12))]
	
	method listaBloques() = listaBloques
	method init() = listaBloques.forEach({ bloque => game.addVisual(bloque) })
}
class Bloque {

	var position
	var color = "bloque_figura.jpg"
	
	method color() = color
	method color(nuevoColor) { color = nuevoColor }
	
	method position() = position
	method position(nuevaPosicion) { position = nuevaPosicion }
	
	method image() = color
	
	method hayAlguienAbajo(listaBloquesFigura, listaBloquesPuestos) = listaBloquesFigura.any({ bloqueFigura => bloqueFigura.position().y() == (listaBloquesPuestos.any({ bloquePuesto => bloquePuesto.position().y() - 1 })) and bloqueFigura.position().x() == (listaBloquesPuestos.any({ bloquePuesto2 => bloquePuesto2.position().x() }))
	
	method hayAlguienALaDerecha(listaBloquesFigura, listaBloquesPuestos) = listaBloquesFigura.any({ bloqueFigura => bloqueFigura.position().x() == (listaBloquesPuestos.any({ bloquePuesto => bloquePuesto.position().x() + 1 })) and bloqueFigura.position().y() == (listaBloquesPuestos.any({ bloquePuesto2 => bloquePuesto2.position().y() }))
	
	method hayAlguienALaIzquierda(listaBloquesFigura, listaBloquesPuestos) = listaBloquesFigura.any({ bloqueFigura => bloqueFigura.position().x() == (listaBloquesPuestos.any({ bloquePuesto => bloquePuesto.position().x() - 1 })) and bloqueFigura.position().y() == (listaBloquesPuestos.any({ bloquePuesto2 => bloquePuesto2.position().y() }))
	
	method moverseHaciaAbajo(listaBloquesFigura, listaBloquesPuestos){
		
		const listaDelMetodo = listaBloquesFigura.remove(listaBloquesFigura.first())
		
		if(listaBloquesFigura.first().position().y() > 0 and !self.hayAlguienAbajo(listaBloquesFigura, listaBloquesPuestos)) {
			self.position(position.down(1))
		} else if (listaBloquesFigura.first().position().y() == 0) {		
			game.schedule(1000, { listaDelMetodo.forEach({ bloque => bloque.position(position.down(1)) }) })
		}
	}
	
	method moverseHaciaIzquierda(listaBloquesFigura, listaBloquesPuestos){
		
		const listaDelMetodo = listaBloquesFigura.remove(listaBloquesFigura.first())
		
		if(listaBloquesFigura.first().position().x() > 0 and !self.hayAlguienALaIzquierda(listaBloquesFigura, listaBloquesPuestos)) {
			self.position(position.left(1))
		} else if (listaBloquesFigura.first().position().x() == 0) {
			game.schedule(1000, { listaDelMetodo.forEach({ bloque => bloque.position(position.left(1)) }) })
		}
	}
	
	method moverseHaciaDerecha(listaBloquesFigura, listaBloquesPuestos){
		
		const listaDelMetodo = listaBloquesFigura.remove(listaBloquesFigura.first())
		
		if (listaBloquesFigura.first().position().x() < 8 and !self.hayAlguienALaDerecha(listaBloquesFigura, listaBloquesPuestos)) {
			self.position(position.right(1))
		} else if (listaBloquesFigura.first().position().x() == 8) {
			game.schedule(1000, { listaDelMetodo.forEach({ bloque => bloque.position(position.right(1)) }) })
		}
	}

	method moverseHaciaArriba(){ 			
			self.position(position.up(1))
		}
	
}

//kaka
/*object figura2 {

	var position = game.at(5,12)
	
	const property estaActivo = true
	
	method position(nuevaPosicion) { position = nuevaPosicion }
	
	method position() = position
	
	method hayAlguienAbajo() = self.position().y() - 1 == figura2.position().y() and self.position().x() == figura2.position().x()
	
	method hayAlguienALaDerecha() = self.position().x() + 1 == figura2.position().x() and self.position().y() == figura2.position().y()
	
	method hayAlguienALaIzquierda() = self.position().x() - 1 == figura2.position().x() and self.position().y() == figura2.position().y()
	
	method moverseHaciaAbajo(){
		if (self.position().y() > 0 and not(self.hayAlguienAbajo())) {
			self.position(position.down(1))
		}
	}
	
	method moverseHaciaArriba(){
		self.position(position.up(1))
	}
	
	method moverseHaciaIzquierda(){
		if (self.position().x() > 0 and not(self.hayAlguienALaIzquierda()) and estaActivo) {
			self.position(position.left(1))
		}
	}
	
	method moverseHaciaDerecha(){
		if (self.position().x() < 8 and not(self.hayAlguienALaDerecha()) and estaActivo) {
			self.position(position.right(1))
		}
	}
	
	method image() = "bloque_figura.jpg"
}
*/
*/
