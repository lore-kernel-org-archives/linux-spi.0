From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: fsl-dspi: Fixes warning due to devm_kzalloc on
 unbound device
Date: Mon, 25 May 2015 15:12:23 +0100
Message-ID: <20150525141223.GZ21391@sirena.org.uk>
References: <1417723755-5372-1-git-send-email-mirza.krak@hostmobility.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z0JXx0QNa4/JeB8y"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417723755-5372-1-git-send-email-mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--z0JXx0QNa4/JeB8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2014 at 09:09:15PM +0100, Mirza Krak wrote:

> ------------[ cut here ]------------
> WARNING: at drivers/base/dd.c:286 driver_probe_device+0x1b4/0x22c()
> Modules linked in:
> Backtrace:

Please don't paste entire backtraces into commit messages, they're large
and make it hard to find the content - if one  is useful please paste
the relevant portions only.

> Inspired by: 10aa5a35e34f ("SPI: fix over-eager devm_xxx()
> conversion")
>=20
> Signed-off-by: Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>

Your commit message should describe what the problem was and how it is
being fixed (ie, describe the change) rather than simply stating that it
is fixing an issue unless the change is really obvious.

> @@ -342,7 +342,7 @@ static int dspi_setup_transfer(struct spi_device *spi=
, struct spi_transfer *t)
>  	/* Only alloc on first setup */
>  	chip =3D spi_get_ctldata(spi);
>  	if (chip =3D=3D NULL) {
> -		chip =3D devm_kzalloc(&spi->dev, sizeof(struct chip_data),
> +		chip =3D kzalloc(sizeof(struct chip_data), GFP_KERNEL);
>  				    GFP_KERNEL);
>  		if (!chip)
>  			return -ENOMEM;

This is good.

> @@ -382,6 +382,11 @@ static int dspi_setup(struct spi_device *spi)
>  	return dspi_setup_transfer(spi, NULL);
>  }
> =20
> +static void dspi_cleanup(struct spi_device *spi)
> +{
> +	spi_bitbang_cleanup(spi);
> +}
> +
>  static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>  {
>  	struct fsl_dspi *dspi =3D (struct fsl_dspi *)dev_id;
> @@ -465,6 +470,7 @@ static int dspi_probe(struct platform_device *pdev)
>  	dspi->bitbang.setup_transfer =3D dspi_setup_transfer;
>  	dspi->bitbang.txrx_bufs =3D dspi_txrx_transfer;
>  	dspi->bitbang.master->setup =3D dspi_setup;
> +	dspi->bitbang.master->cleanup =3D dspi_cleanup;
>  	dspi->bitbang.master->dev.of_node =3D pdev->dev.of_node;

Why not just assign spi_bitbang_cleanup() directly?

--z0JXx0QNa4/JeB8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYy3GAAoJECTWi3JdVIfQ3uUH/j9GlnvfnOxQWVx1vNT74gut
EYAC3ZJ8FdYdXh5IA4wKjzqyggq2u7R+bcYZWtlQw0TxGhKzQ6peZaUJMmiPMqU0
O8nEg6DVx7BRGZjOTajlhndaxPKn7mAmkcs6rBfD3UWboCxnlrS9RAJdyPA+D3AU
O5NwpkiDfkjG1LXygRudZnDd7Xwbx6LG1aCADkq4Wv1OlVgi97CKrKDMeXcBW1lA
8wBDjSEGPZPT/CeZRv/vXurIjkhmmc7OujAo+zAcdKy0dodhhSOFkWzfqlSqzvlO
Qcnkq/IW5p2X7LfTN62n36QO61U7Axx+dQWus13/MUPZRuDCeEQiLi+Lm8gb+aY=
=rNpH
-----END PGP SIGNATURE-----

--z0JXx0QNa4/JeB8y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
