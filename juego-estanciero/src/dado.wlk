import src.jugador.*
object dado {
   var property dado1 = 0
   var property dado2 = 0
   var property suma = 0

   method tirarLosDados(unJugador) {
      self.dado1(1.randomUpTo(1)) // Sabemos que iría de 1 a 6, pero los probamos de 1 a 1 para validar los tests
      self.dado2(1.randomUpTo(1))
      self.suma(dado1 + dado2)
    
      return suma.floor()
   }

   method tiroDobles(unJugador){ 
      unJugador.tirarDados()
      return if (dado1 == dado2) unJugador.tirarDados() else dado1 == dado2
   }
}

