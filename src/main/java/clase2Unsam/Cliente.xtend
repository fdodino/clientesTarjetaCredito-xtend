package clase2Unsam

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
	
	override comprar(int monto) {
		deuda = deuda + monto
	}
	
	override sumarPuntos(int valor) {
		puntos += valor
	}
	
	override pagarVencimiento(int monto) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}

abstract class ClienteConCondicionComercial implements Cliente {
	protected Cliente decorado
	
	override getDeuda() {
		decorado.deuda
	}
	
	override pagarVencimiento(int monto) {
		decorado.pagarVencimiento(monto)
	}
	
	override getPuntos() {
		decorado.puntos
	}
	
	override sumarPuntos(int valor) {
		decorado.sumarPuntos(valor)
	}
	
}

@Accessors
class ClientePromocion extends ClienteConCondicionComercial {
	
	new(Cliente _decorado) {
		this.decorado = _decorado
	}
	
	override comprar(int monto) {
		decorado.comprar(monto)
		if (monto > 50) {
			decorado.sumarPuntos(15)
		}
	}
	
}

class ClienteSafeShop extends ClienteConCondicionComercial {
	int montoSafeShop = 0
	
	new(Cliente _decorado, int _montoSafeShop) {
		this.decorado = _decorado
		this.montoSafeShop = _montoSafeShop
	}
	
	override comprar(int monto) {
		if (monto > montoSafeShop) {
			throw new RuntimeException("Supero el monto " + montoSafeShop + " al querer comprar $ " + monto)
		}
		decorado.comprar(monto)
	}
	
}
