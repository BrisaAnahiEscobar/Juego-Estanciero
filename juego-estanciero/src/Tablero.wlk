import src.salida.*
import src.premioGanadero.*
import src.campos.*
import src.banco.*
import src.empresa.*


class Tablero{
  const property casilleros = []
  method casillerosDesdeHasta(unCasillero, unNumero) {
    return self.casillerosDesde(casilleros.copy(), unCasillero).take(unNumero)
  }

  method casillerosDesde(unosCasilleros, unCasillero) {
    const primero = unosCasilleros.first()
    unosCasilleros.remove(primero) // Remueve el primero
    unosCasilleros.add(primero)    // Lo agrega al final
    return if (primero == unCasillero) unosCasilleros
           else self.casillerosDesde(unosCasilleros, unCasillero)
  }

  method hayEmpresaDeOtroJugador(unJugador) = self.empresasDelTablero().any({casillero => self.cumpleCondiciones(unJugador, casillero) })
  
  method empresasDelTablero() = casilleros.filter({casillero => casillero.sosPropiedad()}).filter({casillero => casillero.sosEmpresa()})
  
  method cumpleCondiciones(unJugador, casillero) = casillero.dueño() != unJugador && casillero.dueñoEs(banco)

}

const tablero = new Tablero(casilleros = [salida, premioGanadero, campo1, empresa1])