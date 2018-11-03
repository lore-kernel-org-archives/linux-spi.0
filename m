From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] spi: pxa2xx: Remove the shutdown callback
Date: Sat, 3 Nov 2018 20:13:46 +0100
Message-ID: <20181103191346.GF31179@amd>
References: <20180917121124.21305-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917121124.21305-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-17 14:11:24, Lubomir Rintel wrote:
> It makes no sense to remove the device on shutdown. And it break things
> when the hardware crucial for shutdown (such as the embedded controller)
> is attached to the SPI bus.

Again, are you sure?

On some hardware (sharp zaurus, phones) it is good idea to shut down
hardware before poweroff, as they don't have embedded controller that
would cut the power.

Will this increase power consumption while "off" on such platforms?
									Pavel

> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/spi/spi-pxa2xx.c | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 14f4ea59caff..b06f37fb29f6 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1764,14 +1764,6 @@ static int pxa2xx_spi_remove(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> -static void pxa2xx_spi_shutdown(struct platform_device *pdev)
> -{
> -	int status =3D 0;
> -
> -	if ((status =3D pxa2xx_spi_remove(pdev)) !=3D 0)
> -		dev_err(&pdev->dev, "shutdown failed with %d\n", status);
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int pxa2xx_spi_suspend(struct device *dev)
>  {
> @@ -1851,7 +1843,6 @@ static struct platform_driver driver =3D {
>  	},
>  	.probe =3D pxa2xx_spi_probe,
>  	.remove =3D pxa2xx_spi_remove,
> -	.shutdown =3D pxa2xx_spi_shutdown,
>  };
> =20
>  static int __init pxa2xx_spi_init(void)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvd82oACgkQMOfwapXb+vLaUwCfenRFkDxK+3sEu/J9yVsj+7QM
0pYAoKXD1uEnyLqJmfXI360WRKKZGlmk
=UbcJ
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
