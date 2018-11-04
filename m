From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 09/11] dt-bindings: spi/spi-pxa2xx: Add ready GPIO signal
Date: Sun, 4 Nov 2018 13:13:14 +0100
Message-ID: <20181104121314.GU23864@amd>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-10-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kbZGpL0ScFxCd8mt"
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
In-Reply-To: <20181010170936.316862-10-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--kbZGpL0ScFxCd8mt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:09:34, Lubomir Rintel wrote:
> This this is used to let the SPI master know that our FIFO is filled and
> we're ready to service a transfer. Only useful in slave mode.
>=20
> A signal like this is used by an embedded controller on a OLPC XO 1.75
> machine, that happens to be a SPI master.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Docum=
entation/devicetree/bindings/spi/spi-pxa2xx.txt
> index 89b2832283e3..681a82b40e6f 100644
> --- a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> @@ -12,6 +12,8 @@ Optional properties:
>  - cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
>    Documentation/devicetree/bindings/spi/spi-bus.txt
>  - spi-slave: Empty property indicating the SPI controller is used in sla=
ve mode.
> +- ready-gpio: GPIO used to signal a SPI master that the FIFO is filled
> +  and we're ready to service a transfer. Only useful in slave mode.
> =20
>  Child nodes represent devices on the SPI bus
>    See ../spi/spi-bus.txt

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kbZGpL0ScFxCd8mt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve4loACgkQMOfwapXb+vJAEACeLnzOenWyJ9mVWkVKlX/SZ0BI
BgQAn1ykaXNIbZT3Pw/0VFrLn8Nqqw8D
=Wloq
-----END PGP SIGNATURE-----

--kbZGpL0ScFxCd8mt--
