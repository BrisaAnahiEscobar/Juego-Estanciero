import src.Propiedad.*
import src.prision.*
import src.campos.*
import src.dado.*
import src.Estrategias.*
import src.empresa.*

class Jugador {
    var property nombre = ""
    var property casilleroActual = 0 
    var property estaPreso = false
    var property turnosEnPrision = 0
    var dinero = 0
    const propiedades = #{} 
    var estrategia = estandar
    
    method propiedades() = propiedades

    method propiedades(unaPropiedad) {
      propiedades.add(unaPropiedad)
    }

    method estrategia() = estrategia 

    method cambiarEstrategia(unaEstrategia){
      estrategia = unaEstrategia
    }

    method tienePropiedad(unaPropiedad) = propiedades.contains(unaPropiedad) 

    method cantidadPropiedades() = self.propiedades().size()

    method cantidadDeEmpresas() {
      return self.propiedades().filter({propiedad => propiedad.sosEmpresa()}).size()
    }
    
    method tirarDados() {
      return dado.tirarLosDados(self)
    }

    method tirarDobles() {
     return dado.tiroDobles(self)
    }

    method pagar(unMonto, otroJugador) { 
      if(self.dinero() >= unMonto){
        self.descontarDinero(unMonto)
        otroJugador.recibirDinero(unMonto)
      } else {
          self.intentaPagar(unMonto)
          if(self.cantidadPropiedades() == 0 && dinero < unMonto){
            self.error("No tiene dinero suficiente")
          }
      }
    }

    method dinero () {
      return dinero
    }

    method descontarDinero(unMonto) {
      dinero -= unMonto
    }

    method recibirDinero(unMonto){
      dinero += unMonto
    }

    method comprarPropiedad(unaPropiedad) {
      self.pagar(unaPropiedad.compraInicial(), unaPropiedad.dueño())
      unaPropiedad.dueño(self)
      self.propiedades(unaPropiedad) 
    }

    method moverse(cantidadDeCasilleros, tablero){ 
      const recorrido = tablero.casillerosDesdeHasta(self.casilleroActual(), cantidadDeCasilleros)
      self.avanzar(recorrido)
    }
   
    method avanzar(casilleros){
      casilleros.forEach({casilleros => casilleros.paso(self)})
      self.casilleroActual(casilleros.last())
      casilleroActual.cayo(self)
    }
    
    method irPreso(){
      self.casilleroActual(prision)
      self.estaPreso(true)
      self.turnosEnPrision(3)
    }

    method jugarTurnoEnPrision(){
      if(self.estaPreso()){
        self.aumentarTurnosEnPrision()
        self.tirarDados()
      
      if(self.tirarDobles() || self.turnosEnPrision() >= 3){  
        self.salirDePrision()
      }
    } 
      else{
        if(self.tirarDobles()){
          self.irPreso()
        }
    }
    
    }

    method salirDePrision(){
      self.estaPreso(false)
      self.turnosEnPrision() == 0
    }

    method aumentarTurnosEnPrision() {
      turnosEnPrision += 1
    }

    method turnosEnPrision() {
      return turnosEnPrision
    }

    method hipotecarPropiedad(unMonto) = propiedades.filter({propiedad => not propiedad.estaHipotecada()}).forEach {propiedad => if(dinero < unMonto) self.realizarHipoteca(propiedad)}

    method realizarHipoteca(propiedad) {
      if(self.cantidadPropiedades() > 0){
        propiedad.hipotecar()
      }
    }

    method intentaPagar(monto) {
      if( dinero < monto && self.propiedades().size() > 0){
        self.hipotecarPropiedad(monto)
      }
    }  
}