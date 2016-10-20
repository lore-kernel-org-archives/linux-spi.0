From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: sun6i: Support Allwinner H3 SPI controller
Date: Thu, 20 Oct 2016 17:50:02 +0200
Message-ID: <20161020155002.iogpkjgbvhnhexne@lukather>
References: <20161019140234.13518-1-woogyom.kim@gmail.com>
 <20161019140234.13518-3-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j5yshxtgzp2la6yj"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161019140234.13518-3-woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--j5yshxtgzp2la6yj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 19, 2016 at 11:02:33PM +0900, Milo Kim wrote:
> H3 has two SPI controllers. The size of the buffer is 64 * 8.
> (8 bit transfer by 64 entry FIFO)
> A31 has four controllers. The size of the buffer is 128 * 8.
> (8 bit transfer by 128 entry FIFO)
>=20
> Register maps are sharable, so sun6i SPI driver is reusable with
> device configuration.
>=20
> Use the variable, 'fifo_depth' instead of fixed value to support both SPI
> controllers.
>=20
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> Signed-off-by: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/Kconfig     |  4 ++--
>  drivers/spi/spi-sun6i.c | 38 +++++++++++++++++++++++++++-----------
>  2 files changed, 29 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index b799547..06d0845 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -610,11 +610,11 @@ config SPI_SUN4I
>  	  SPI driver for Allwinner sun4i, sun5i and sun7i SoCs
> =20
>  config SPI_SUN6I
> -	tristate "Allwinner A31 SPI controller"
> +	tristate "Allwinner A31/H3 SPI controller"
>  	depends on ARCH_SUNXI || COMPILE_TEST
>  	depends on RESET_CONTROLLER
>  	help
> -	  This enables using the SPI controller on the Allwinner A31 SoCs.
> +	  This enables using the SPI controller on the Allwinner A31/H3 SoCs.

Usually, we don't care about maintaining this. This is just going to
be a list that grows all the time, and is wrong most of the time.

>  config SPI_MXS
>  	tristate "Freescale MXS SPI controller"
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 9918a57..91235b2 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -17,6 +17,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> @@ -24,6 +25,7 @@
>  #include <linux/spi/spi.h>
> =20
>  #define SUN6I_FIFO_DEPTH		128
> +#define SUN8I_FIFO_DEPTH		64
> =20
>  #define SUN6I_GBL_CTL_REG		0x04
>  #define SUN6I_GBL_CTL_BUS_ENABLE		BIT(0)
> @@ -90,6 +92,7 @@ struct sun6i_spi {
>  	const u8		*tx_buf;
>  	u8			*rx_buf;
>  	int			len;
> +	int			fifo_depth;
>  };
> =20
>  static inline u32 sun6i_spi_read(struct sun6i_spi *sspi, u32 reg)
> @@ -155,7 +158,9 @@ static void sun6i_spi_set_cs(struct spi_device *spi, =
bool enable)
> =20
>  static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
>  {
> -	return SUN6I_FIFO_DEPTH - 1;
> +	struct sun6i_spi *sspi =3D spi_master_get_devdata(spi->master);
> +
> +	return sspi->fifo_depth - 1;
>  }
> =20
>  static int sun6i_spi_transfer_one(struct spi_master *master,
> @@ -170,7 +175,7 @@ static int sun6i_spi_transfer_one(struct spi_master *=
master,
>  	u32 reg;
> =20
>  	/* We don't support transfer larger than the FIFO */
> -	if (tfr->len > SUN6I_FIFO_DEPTH)
> +	if (tfr->len > sspi->fifo_depth)
>  		return -EINVAL;
> =20
>  	reinit_completion(&sspi->done);
> @@ -265,7 +270,7 @@ static int sun6i_spi_transfer_one(struct spi_master *=
master,
>  			SUN6I_BURST_CTL_CNT_STC(tx_len));
> =20
>  	/* Fill the TX FIFO */
> -	sun6i_spi_fill_fifo(sspi, SUN6I_FIFO_DEPTH);
> +	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
> =20
>  	/* Enable the interrupts */
>  	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
> @@ -288,7 +293,7 @@ static int sun6i_spi_transfer_one(struct spi_master *=
master,
>  		goto out;
>  	}
> =20
> -	sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
> +	sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);
> =20
>  out:
>  	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
> @@ -360,8 +365,16 @@ static int sun6i_spi_runtime_suspend(struct device *=
dev)
>  	return 0;
>  }
> =20
> +static const struct of_device_id sun6i_spi_match[] =3D {
> +	{ .compatible =3D "allwinner,sun6i-a31-spi", .data =3D (int *)SUN6I_FIF=
O_DEPTH },
> +	{ .compatible =3D "allwinner,sun8i-h3-spi", .data =3D (int *)SUN8I_FIFO=
_DEPTH },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sun6i_spi_match);
> +
>  static int sun6i_spi_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *id;
>  	struct spi_master *master;
>  	struct sun6i_spi *sspi;
>  	struct resource	*res;
> @@ -398,6 +411,15 @@ static int sun6i_spi_probe(struct platform_device *p=
dev)
>  	}
> =20
>  	sspi->master =3D master;
> +
> +	id =3D of_match_device(sun6i_spi_match, &pdev->dev);
> +	if (!id) {
> +		dev_err(&pdev->dev, "Cannot get device ID\n");
> +		goto err_free_master;
> +	}
> +
> +	sspi->fifo_depth =3D (int)id->data;
> +
>  	master->max_speed_hz =3D 100 * 1000 * 1000;
>  	master->min_speed_hz =3D 3 * 1000;
>  	master->set_cs =3D sun6i_spi_set_cs;
> @@ -469,12 +491,6 @@ static int sun6i_spi_remove(struct platform_device *=
pdev)
>  	return 0;
>  }
> =20
> -static const struct of_device_id sun6i_spi_match[] =3D {
> -	{ .compatible =3D "allwinner,sun6i-a31-spi", },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, sun6i_spi_match);
> -
>  static const struct dev_pm_ops sun6i_spi_pm_ops =3D {
>  	.runtime_resume		=3D sun6i_spi_runtime_resume,
>  	.runtime_suspend	=3D sun6i_spi_runtime_suspend,
> @@ -493,5 +509,5 @@ module_platform_driver(sun6i_spi_driver);
> =20
>  MODULE_AUTHOR("Pan Nan <pannan-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org>");
>  MODULE_AUTHOR("Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
> -MODULE_DESCRIPTION("Allwinner A31 SPI controller driver");
> +MODULE_DESCRIPTION("Allwinner A31/H3 SPI controller driver");

Ditto.

It looks good otherwise.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--j5yshxtgzp2la6yj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYCOeqAAoJEBx+YmzsjxAg4O4QAJ4D+PzGikl/xi+DDfRPuHfL
rAPEaJP81JLfyy3RsoAgGgXkyZPUW3GJJzxAY+d8FS8hvHhXppu3j9HngOjt56RY
HI72zoFLmBBfBG4PL9U1PVWzoRfurthNDtlxBYXboS3jwICGWHZlGVTIjnhsYbve
4rJ1PcfLXxgFefQfj2QvhAgE1NI1/8mV4vPU5muTNRriqgj62szuWEh65CKVc8fE
jRaCPgvgTNZ9eBw8tSujXlOxkKldJ+CLWnxUxWvprgHtgi8xTHR4N8YBjxc5G441
blMpmGRAg/pkDq/IJRwpLdQFKsrL2OkGHLGX66MO7vLN2aHHAmnF+iu8EOYhwJgI
eIuHjeJ8ZL1fQMhOkJVj9umzpJz1IaI9mmvor6L98/ZtJB00W87RBZZGrMjrjXUc
Bqn8FsUgGxGdwOr+p/cTUzgxPcFD/jGnmglMerbK2yNd8BefIa85T4assqUq72IW
ID8BvpJAU3YXlFSxIbrBUUrd3ZwyGsEuOcz0Di5fXJE75DDjG7JD7Kq1b8a62xP4
lqxVdn/nGyjyw9AUXNnZRlC5fLWbe86FqbNlPgMjtA0rK0nkTOXv1JPKeH+FIEou
zI3DTIXaOqlPHv70t8aXNWMtZ1HoTi2sRW8Zw/5v6GisncMXaJKpWa1zD7RPd2zT
QmlWE1ABn8Sj2nd4h0MV
=Dbat
-----END PGP SIGNATURE-----

--j5yshxtgzp2la6yj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
