import src.campos.*

class Provincia {
  const campos = #{}
  var property propietarios = []
  var property cantidadDeEstancias = 0

  method campos() = campos
  
  method campos(unCampo) {
    campos.add(unCampo)
  }

  method propietariosSinRepetidos() {
    return campos.map({campo => campo.dueño()}).asSet()
  }

  method puedeConstruirEstancia(campo) = self.esMonopolio(campo.dueño()) && self.esConstruccionPareja(campo) 
  
  method esMonopolio(unJugador) {
    return self.campos().all({campo => campo.dueño() == unJugador})
  }

  method tieneMasDeUnCampo(unJugador, campoDondeCayo) = self.campos().any({campo => campo != campoDondeCayo && unJugador.tienePropiedad(campo)}) 
  
  method esConstruccionPareja(campo) = self.cantidadEstaciasPorCampo(campo).all({valor => valor <= campo.cantidadDeEstancias()})
  
  method cantidadEstaciasPorCampo(unCampo) =  campos.filter({campo => campo != unCampo}).map({campo => campo.cantidadDeEstancias()})
}

const chaco = new Provincia(campos = #{campo1,campo2,campo3}) 
