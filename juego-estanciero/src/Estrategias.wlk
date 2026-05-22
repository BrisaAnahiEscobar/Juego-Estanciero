import src.Tablero.*
import src.Propiedad.*
import src.banco.*
import src.campos.*
import src.empresa.*
import src.provincia.*
import src.salida.*
import src.jugador.*


object estandar{
  
     method aplicarEstrategia(unJugador, casilleroActual) {
      if(casilleroActual.dueñoEs(banco)){
           unJugador.comprarPropiedad(unJugador.casilleroActual())
        }
    }
}

object garca{
    
    method cumpleCondicion(unJugador, casilleroActual) =  casilleroActual.provincia().campos().any({campo => self.campoCumple(campo, unJugador, casilleroActual)})
    
    method campoCumple(campo, unJugador, casilleroActual){
      return campo.dueño() != unJugador && not campo.dueñoEs(banco) && campo != casilleroActual
    }

    method aplicarEstrategia(unJugador, casilleroActual) {

      if(not casilleroActual.sosEmpresa() && self.cumpleCondicion(unJugador, casilleroActual)){
        unJugador.comprarPropiedad(casilleroActual)
      }
      else {
        if (tablero.hayEmpresaDeOtroJugador(unJugador)) {
          unJugador.comprarPropiedad(casilleroActual)
        }
       
      }
    }
}

object imperialista{

  method aplicarEstrategia(unJugador, casilleroActual){
        if(not casilleroActual.sosEmpresa()){
          if (casilleroActual.provincia().tieneMasDeUnCampo(unJugador, casilleroActual) || casilleroActual.provincia().esMonopolio(banco)){
        unJugador.comprarPropiedad(casilleroActual)
          }
        }else {
        if(tablero.empresasDelTablero().all({empresa => empresa.dueñoEs(banco)})){
            unJugador.comprarPropiedad(unJugador.casilleroActual())
            }
        }
    }
}
