import src.Propiedad.*
import src.provincia.*
import src.Juego.*
import src.jugador.*
import src.banco.*

class Campos inherits Propiedad {
    var property valorDeRentaFijo = 0 // valor de renta sin estancias
    var property costoDeConstruccion = 0 // costo de cada estancia
    var cantidadDeEstancias = 0
    var property provincia = 0 

    method cantidadDeEstancias() = cantidadDeEstancias

    method agregoUnaEstancia() {
      cantidadDeEstancias += 1
    }

    override method rentaPara(jugadorQueCayo) { 
      return if(jugadorQueCayo != self.dueño()) 2 ** cantidadDeEstancias * valorDeRentaFijo
    }
  
    override method sosEmpresa() = false

    method agregarEstancia() {
      if(self.provincia().puedeConstruirEstancia(self)) self.agregoUnaEstancia() else return "no se cumple la condicion"
    }
    
  override method calculoHipoteca() = (self.compraInicial() / 2 . floor()) + self.totalPorEstancias()

  method totalPorEstancias() = cantidadDeEstancias * (costoDeConstruccion / 2 . floor())
}

const campo1 = new Campos(provincia = chaco)
const campo2 = new Campos(provincia = chaco)
const campo3 = new Campos(provincia = chaco)

