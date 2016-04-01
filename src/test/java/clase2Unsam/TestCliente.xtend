package clase2Unsam

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestCliente {

	Cliente clienteSinPromo
	Cliente clienteConPromo
	Cliente clienteConSafeShop
	Cliente clienteCombineta

	@Before
	def void init() {
		clienteSinPromo = new ClientePosta
		clienteConPromo = new ClientePromocion(new ClientePosta)
		clienteConSafeShop = new ClienteSafeShop(new ClientePosta, 60)
		clienteCombineta = new ClientePromocion(new ClienteSafeShop(new ClientePosta, 60))
	}

	@Test
	def void clienteSinPromoCompraYLeSubeLaDeuda() {
		clienteSinPromo.comprar(100)
		Assert.assertEquals(100, clienteSinPromo.deuda)
	}

	@Test
	def void clienteSinPromoCompraYNoLeSubeLosPuntos() {
		clienteSinPromo.comprar(100)
		Assert.assertEquals(0, clienteSinPromo.puntos)
	}

	@Test
	def void clienteConPromoCompraYLeSubeLosPuntos() {
		clienteConPromo.comprar(100)
		Assert.assertEquals(15, clienteConPromo.puntos)
	}

	@Test
	def void clienteConPromoCompraPocoYNoLeSubeLosPuntos() {
		clienteConPromo.comprar(10)
		Assert.assertEquals(0, clienteConPromo.puntos)
	}

	@Test
	def void clienteConPromoCompra2VecesYLeSubeLosPuntos() {
		clienteConPromo.comprar(100)
		clienteConPromo.comprar(100)
		Assert.assertEquals(30, clienteConPromo.puntos)
	}

	@Test(expected=typeof(RuntimeException))
	def void clienteConSafeShopCompraMuchoYCHAAAAAAAAAN() {
		clienteConSafeShop.comprar(100)
	}

	@Test
	def void clienteConSafeShopCompraPocoYTodoBIEN() {
		clienteConSafeShop.comprar(10)
		Assert.assertEquals(10, clienteConSafeShop.deuda)
	}

	@Test
	def void clienteCombinetaCompraYLeSubeLosPuntos() {
		clienteCombineta.comprar(51)
		Assert.assertEquals(15, clienteCombineta.puntos)
	}

	@Test
	def void clienteCombinetaCompraPocoYNoLeSubeLosPuntos() {
		clienteCombineta.comprar(10)
		Assert.assertEquals(0, clienteCombineta.puntos)
	}

	@Test(expected=typeof(RuntimeException))
	def void clienteCombinetaCompraMuchoYCHAAAAAAAAAN() {
		clienteCombineta.comprar(100)
	}

	@Test
	def void clienteCombinetaCompraMuchoYNoSumaPuntos() {
		try {
			clienteCombineta.comprar(100)
		} catch (Exception e) {
			Assert.assertEquals(0, clienteCombineta.puntos)
		}
	}
	
	@Test
	def void clienteConSafeShopCompraMuchoYNoLeSubeLaDeuda() {
		try {
			clienteConSafeShop.comprar(100)
		} catch (RuntimeException e) {
			Assert.assertEquals("Le subio la deuda al cliente safe shop cuando compro", 0, clienteConSafeShop.deuda)		
		}
	}
	
}
