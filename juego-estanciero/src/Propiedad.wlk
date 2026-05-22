import src.banco.*
import campos.*
import empresa.*
import jugador.*
import src.Estrategias.*

class Propiedad  {
     var property compraInicial = 0 
     var property dueño = banco
     var property estaHipotecada = false

     method sosPropiedad() = true

     method sosEmpresa() = false

     method rentaPara(jugadorQueCayo) {}
        
     method dueñoEs(otroJugador) = self.dueño() == otroJugador

     method cayo(unJugador){
        if(self.dueñoEs(banco)){
           unJugador.estrategia().aplicarEstrategia(unJugador, unJugador.casilleroActual())
        }
        else { 
           unJugador.pagar(unJugador.casilleroActual().rentaPara(unJugador), self.dueño())
        }
      }
     method paso(unJugador){

   }
  
     method hipotecar() {
      if(self.estaHipotecada()){
         self.error("La propiedad ya esta hipotecada")
      }
      else {
         self.dueño().recibirDinero(self.calculoHipoteca()) 
         self.dueño().propiedades().remove(self)
         self.dueño(banco)
         self.estaHipotecada(true)
      }
   }

   method levantarHipoteca(unJugador) {
      const monto = compraInicial * 1.5 
      unJugador.comprarPropiedad(self) 
      self.estaHipotecada(false) 
   }

   method calculoHipoteca() = (self.compraInicial() / 2).floor()
}



