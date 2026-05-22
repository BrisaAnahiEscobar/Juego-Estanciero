import src.jugador.*
import src.Propiedad.*

class Empresa inherits Propiedad {
    
    override method sosEmpresa() = true
    
    override method rentaPara(jugadorQueCayo) = if(jugadorQueCayo != self.dueño()) self.calculoDeRenta(jugadorQueCayo)
       
    method calculoDeRenta(jugadorQueCayo) =  jugadorQueCayo.tirarDados() * 30000 * self.dueño().cantidadDeEmpresas()
                                         
}

const empresa1 = new Empresa()