From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
Date: Sun, 4 Nov 2018 13:00:42 +0100
Message-ID: <20181104120042.GM23864@amd>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-2-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8m/hfNLtAhX2NvnO"
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010170936.316862-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--8m/hfNLtAhX2NvnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:09:26, Lubomir Rintel wrote:
> This is the SPI controller found on Marvel MMP2 and perhaps more
> platforms.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

Rob, do you want to apply this?

								Pavel

> @@ -0,0 +1,24 @@
> +PXA2xx SSP SPI Controller
> +
> +Required properties:
> +- compatible: Must be "marvell,mmp2-ssp".
> +- reg: Offset and length of the device's register set.
> +- interrupts: Should be the interrupt number.
> +- clocks: Should contain a single entry describing the clock input.
> +- #address-cells:  Number of cells required to define a chip select addr=
ess.
> +- #size-cells: Should be zero.
> +
> +Optional properties:
> +- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
> +  Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Child nodes represent devices on the SPI bus
> +  See ../spi/spi-bus.txt
> +
> +Example:
> +	ssp1: spi@d4035000 {
> +		compatible =3D "marvell,mmp2-ssp";
> +		reg =3D <0xd4035000 0x1000>;
> +		clocks =3D <&soc_clocks MMP2_CLK_SSP0>;
> +		interrupts =3D <0>;
> +	};

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8m/hfNLtAhX2NvnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve32oACgkQMOfwapXb+vIi4gCfVvj8ZjGL/YFOeuBKWR7IP0Ln
BYYAoIGdgdjSkBKZ3Jj23rkfqzuoJ5SC
=xhUs
-----END PGP SIGNATURE-----

--8m/hfNLtAhX2NvnO--
