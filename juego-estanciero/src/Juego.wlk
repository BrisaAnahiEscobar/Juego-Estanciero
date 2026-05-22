import src.Tablero.*
import src.jugador.*
import src.Propiedad.*

class Juego inherits Jugador{
  const property jugadores = []
  var property estaTerminado = false

  method empezar() {
    if (not self.estaTerminado()) {
      jugadores.forEach { jugador => self.queJuegue(jugador) }
    }
  }

  method queJuegue(unJugador) { 
  
  if(self.estaTerminado()) {
      self.error("GAME OVER (el juego esta terminado)")
    } else {
      unJugador.moverse(unJugador.tirarDados(), tablero)
    }
    
  }

  method casilleroDeLlegada(unJugador) = tablero.casillerosDesdeHasta(unJugador.casilleroActual(), unJugador.tirarDados()).last()

}


