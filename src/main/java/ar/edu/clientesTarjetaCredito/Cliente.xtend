package ar.edu.clientesTarjetaCredito

import org.eclipse.xtend.lib.annotations.Accessors

interface Cliente {

	def void comprar(int monto)
	def void pagarVencimiento(int monto)
	def int getDeuda()
	def int getPuntos()
	def void sumarPuntos(int valor)

}

@Accessors
class ClientePosta implements Cliente {

	int deuda = 0
	int puntos = 0
	boolean contratoPromocion = false
	boolean contratoSafeShop = false	
	int montoSafeShop
	
	def void tienePromocion() {
		contratoPromocion = true
	}

	def void tieneSafeShop(int _montoSafeShop) {
		contratoSafeShop = true
		montoSafeShop = _montoSafeShop
	}

	override comprar(int monto) {
		// Safe shop
		if (contratoSafeShop && monto > montoSafeShop) {
			throw new RuntimeException("Supero el monto " + montoSafeShop + " al querer comprar $ " + monto)
		}
		deuda = deuda + monto
		// Promoción
		if (contratoPromocion && monto > 50) {
			this.sumarPuntos(15)
		}
	}

	override sumarPuntos(int valor) {
		puntos += valor
	}

	override pagarVencimiento(int monto) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
