From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: spi: snps,dw-apb-ssi: document
 Microsemi integration
Date: Mon, 30 Jul 2018 11:13:17 +0100
Message-ID: <20180730101317.GE5789@sirena.org.uk>
References: <20180727195358.23336-1-alexandre.belloni@bootlin.com>
 <20180727195358.23336-3-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Cc: James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727195358.23336-3-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 27, 2018 at 09:53:55PM +0200, Alexandre Belloni wrote:

> +- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi"
> +- reg : The register base for the controller. For "mscc,<soc>-spi", a second
> +  register set is required (named ICPU_CFG:SPI_MST)

What are valid values for "<soc>"?

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte5LwACgkQJNaLcl1U
h9D31Af+MTQt/If39raq/xaFIc+F56f3Vh/tIl0YPba6fqwho2FURFiu124R/KMQ
U8N7eCxWjkcv2fT2Rv4GAmA3j5h44WBTdYY25rYR8Vp5b0p4yVduaXV63+CPTnjj
F+KhF7Wk0S28pEBKadLHYp33ed1VLtGS5lYga7g5JNXnjlppduKJxLIsppxa4XdB
9/eVJRhwELHqjucdZpx0smhhFKAr8i+jqKud0bjEy9PeUYcS/G41HaSalqBgHYsd
H8oHP1lx8odzkm7QR4eGHDRODw9pi2Lxpa0AAM6Chy3cYr2lLrQpbiRJKdN4Clt0
McOTx22z2AuJs1EQc8U+pt4lPeWKeg==
=rfC2
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
