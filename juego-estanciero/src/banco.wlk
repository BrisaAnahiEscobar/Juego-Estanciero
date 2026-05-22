object banco {
  var dinero = 0
  
  method cobrar(unMonto) {
    self.dinero(unMonto)
  }

  method dinero() {
    return dinero
  }
  
  method dinero(unMonto) {
    dinero += unMonto
  }

  method pagar(unMonto) {
    self.dinero() + unMonto 
  }

  method recibirDinero(unMonto) {
    self.dinero(unMonto)
  }
}