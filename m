From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
Date: Wed, 1 Aug 2018 18:27:47 +0100
Message-ID: <20180801172747.GJ5509@sirena.org.uk>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-6-bugalski.piotr@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4166929671864913717=="
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Piotr Bugalski <pbu@cryptera.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org,
 Tudor Ambarus <tudor.ambarus@microchip.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>
To: Piotr Bugalski <bugalski.piotr@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180627131609.13681-6-bugalski.piotr@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============4166929671864913717==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2018 at 03:16:08PM +0200, Piotr Bugalski wrote:
> Kernel contains QSPI driver strongly tied to MTD and nor-flash memory.
> New spi-mem interface allows usage also other memory types, especially
> much larger NAND with SPI interface. This driver works as SPI controller
> and is not related to MTD, however can work with NAND-flash or other
> peripherals using spi-mem interface.

This is fine from a SPI point of view but I'd like to apply it directly
to the SPI tree rather than ack it for merge via the MTD tree - can we
work something out with a shared branch or something?

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlth7ZIACgkQJNaLcl1U
h9DoyAf/axay4apJ06n4JCgJFvYwhcy//Lc98dvXcnht+N+o7q386hp2kgdobQQ6
DEtlMemWfYGAC+SKbOzlk81q5JL/+mP252rjCii5W9moO3Qm2TzCgKtjeWoH3/Va
cjIdVv0j1AeIuMK2H8I3jFOIh0W5ehXJsuNCwN6kf6E4/4w135XlQ7xOaA7hUjrW
UoqWfSkVkYLSHIMnUd7t2q5YVEKf3EoqYc/ddACPX1hwdTm3bE3KuWIwNyMomV1t
e1LAyQ6hMO5ZCU6+/8zjEw2avKuUUEQZRTiBBVyuk2zC1kTg+ARtYg6CbqD96r5J
p80N/6kIUIqOyajvbcgkUjZZCWpeow==
=Xusq
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--


--===============4166929671864913717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4166929671864913717==--
