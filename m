From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] SPI: control CS via standard GPIO operations
 instead of SPI-HW
Date: Wed, 04 Mar 2015 18:01:20 +0100
Message-ID: <54F73A60.9080403@pengutronix.de>
References: <1425487205-5477-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XRAbMkixDNslelQRWDwaNVGAAMVTHw8cO"
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425487205-5477-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XRAbMkixDNslelQRWDwaNVGAAMVTHw8cO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/2015 05:40 PM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> Allow the cs-gpios property in DT to be used instead of the
> fixed two chip-selects provided by the SPI-HW itself
>=20
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> ---
>=20
> There is the question if we still need to support the chip_selects
> provided by the hardware (plus the buggy CSPOL_HIGH support for those c=
ases)
> or if we could just make the cs-gpios a required setting for this drive=
r.
> Going with the GPIO only solution would clean up the code a bit.
>=20
>  drivers/spi/spi-bcm2835.c |   53 +++++++++++++++++++++++++++++++++++++=
++------
>  1 file changed, 46 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index 419a782..128a152 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) 2012 Chris Boot
>   * Copyright (C) 2013 Stephen Warren
> + * Copyright (C) 2015 Martin Sperl
>   *
>   * This driver is inspired by:
>   * spi-ath79.c, Copyright (C) 2009-2011 Gabor Juhos <juhosg-p3rKhJxN3nrF2uMehF1BdA@public.gmane.org=
g>
> @@ -30,6 +31,7 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  #include <linux/spi/spi.h>
> =20
>  /* SPI register offsets */
> @@ -116,6 +118,18 @@ static inline void bcm2835_wr_fifo(struct bcm2835_=
spi *bs, int len)
>  	}
>  }
> =20
> +/* ideally spi_set_cs would be exported by spi-core */
> +static inline void bcm2835_set_cs(struct spi_device *spi, bool enable)=

> +{
> +
> +	if (spi->mode & SPI_CS_HIGH)
> +		enable =3D !enable;
> +
> +	if (spi->cs_gpio >=3D 0)

You might want to use gpio_is_valid() instead of open coding it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--XRAbMkixDNslelQRWDwaNVGAAMVTHw8cO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU9zpqAAoJECte4hHFiupUesQQAI7MckaOvu8CDTlPPpVT0hXu
2OEZu1qiwSL7t0yvhzsKPRZwfwAN8Zy/VrMGaddFpnuxSrrriYp0XnG/54oV2Hpw
yrzCM6D33wyKMZ0zOGbOuNOwbLpczUId7Q6LU4WxKj1GKv8b7u/V54VcVCqkvnnG
GVLELCVtzCCFIDxSiGG/886r2JoTrYEwfHtqAx2oSOHBorlwQaxABt0BIL50kIO2
QKTbApifAYW3itu6ViTrMVSzU7OkIggE5y37Hc+YXbeasPpalmmXD8K0CDPbqBzo
9ZArrhBHBCCSFJB+J32hc4TZSCNJ1t8XxwqwRrzC2wvyZUnRYeeuIL4xWxQ/Tpx+
vZBAnXtANILLnpxEWlpYAAf4YCASlYFqd4NWJ4ss1JYgjstOfFIBs+/28hJUt04+
SisxBcgdAtQBHMkIqQ5dw/kzkkfqS2mlrg3D7doWHXQaX6RaoYIb25H9F8w0DU6g
LFr6quSFwevhvQ1BQLNGaJNfCy+tKfyEfL4YeI3wz22G0Ex//y9kwx6TqnuzKHBC
GC5m3wauaPim2u1dMVACB5GJBqUSv/slFk1PgkGdF6hvAiDixBZzCKDGst8LRrPT
fnx7xHsaoQfysSNV1inY2vWk0qV9gQC8geogUBN9tSGfNF4HzDRH2jiQz313T/TM
j/pncDCppwdcBvdMd+sv
=fNFw
-----END PGP SIGNATURE-----

--XRAbMkixDNslelQRWDwaNVGAAMVTHw8cO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
