From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: atmel: improve internal vs gpio chip-select
 choice
Date: Tue, 12 Jan 2016 09:52:02 +0100
Message-ID: <5694BEB2.4000603@atmel.com>
References: <1452528102-26458-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452528102-26458-1-git-send-email-mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 11/01/2016 17:01, Mans Rullgard a =E9crit :
> The driver currently chooses between internal chip-select or gpio
> based on the existence of the cs-gpios DT property which fails on
> non-DT systems and also enforces the same choice for all devices.
>=20
> This patch makes the method per device instead of per controller
> and fixes the selection on non-DT systems.

Sorry Mans, but it's still a NACK for me on this "mixed CS feature" (Cf=
=2E
my answer to the previous version).

Bye,

>  With these changes,
> the chip-select method for each device is chosen according to the
> following priority:
>=20
> 1. GPIO from device tree
> 2. GPIO from platform data
> 3. Internal chip-select
>=20
> Tested on AVR32 ATSTK1000.
>=20
> Signed-off-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
> ---
> Changes:
> - allow internal CS only hardware v2
> - retain seting of master->num_chipselect to 4 on hardware v2 if
>   cs-gpios property is missing
> ---
>  drivers/spi/spi-atmel.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 08cbb3e43c76..d4a806e24060 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -312,7 +312,6 @@ struct atmel_spi {
> =20
>  	bool			use_dma;
>  	bool			use_pdc;
> -	bool			use_cs_gpios;
>  	/* dmaengine data */
>  	struct atmel_spi_dma	dma;
> =20
> @@ -323,6 +322,7 @@ struct atmel_spi {
>  struct atmel_spi_device {
>  	unsigned int		npcs_pin;
>  	u32			csr;
> +	bool			use_cs_gpio;
>  };
> =20
>  #define BUFFER_SIZE		PAGE_SIZE
> @@ -387,7 +387,7 @@ static void cs_activate(struct atmel_spi *as, str=
uct spi_device *spi)
>  		}
> =20
>  		mr =3D spi_readl(as, MR);
> -		if (as->use_cs_gpios)
> +		if (asd->use_cs_gpio)
>  			gpio_set_value(asd->npcs_pin, active);
>  	} else {
>  		u32 cpol =3D (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
> @@ -404,7 +404,7 @@ static void cs_activate(struct atmel_spi *as, str=
uct spi_device *spi)
> =20
>  		mr =3D spi_readl(as, MR);
>  		mr =3D SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
> -		if (as->use_cs_gpios && spi->chip_select !=3D 0)
> +		if (asd->use_cs_gpio && spi->chip_select !=3D 0)
>  			gpio_set_value(asd->npcs_pin, active);
>  		spi_writel(as, MR, mr);
>  	}
> @@ -433,7 +433,7 @@ static void cs_deactivate(struct atmel_spi *as, s=
truct spi_device *spi)
>  			asd->npcs_pin, active ? " (low)" : "",
>  			mr);
> =20
> -	if (!as->use_cs_gpios)
> +	if (!asd->use_cs_gpio)
>  		spi_writel(as, CR, SPI_BIT(LASTXFER));
>  	else if (atmel_spi_is_v2(as) || spi->chip_select !=3D 0)
>  		gpio_set_value(asd->npcs_pin, !active);
> @@ -1539,6 +1539,7 @@ static int atmel_spi_setup(struct spi_device *s=
pi)
>  	unsigned int		bits =3D spi->bits_per_word;
>  	unsigned int		npcs_pin;
>  	int			ret;
> +	bool			use_cs_gpio;
> =20
>  	as =3D spi_master_get_devdata(spi->master);
> =20
> @@ -1565,8 +1566,6 @@ static int atmel_spi_setup(struct spi_device *s=
pi)
>  		csr |=3D SPI_BIT(CPOL);
>  	if (!(spi->mode & SPI_CPHA))
>  		csr |=3D SPI_BIT(NCPHA);
> -	if (!as->use_cs_gpios)
> -		csr |=3D SPI_BIT(CSAAT);
> =20
>  	/* DLYBS is mostly irrelevant since we manage chipselect using GPIO=
s.
>  	 *
> @@ -1577,13 +1576,22 @@ static int atmel_spi_setup(struct spi_device =
*spi)
>  	csr |=3D SPI_BF(DLYBS, 0);
>  	csr |=3D SPI_BF(DLYBCT, 0);
> =20
> -	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
>  	npcs_pin =3D (unsigned long)spi->controller_data;
> =20
> -	if (!as->use_cs_gpios)
> -		npcs_pin =3D spi->chip_select;
> -	else if (gpio_is_valid(spi->cs_gpio))
> +	if (gpio_is_valid(spi->cs_gpio)) {
> +		/* GPIO from DT */
>  		npcs_pin =3D spi->cs_gpio;
> +		use_cs_gpio =3D true;
> +	} else if (npcs_pin && gpio_is_valid(npcs_pin)) {
> +		/* GPIO from platform data */
> +		use_cs_gpio =3D true;
> +	} else if (atmel_spi_is_v2(as)) {
> +		/* internal chip-select */
> +		npcs_pin =3D spi->chip_select;
> +		use_cs_gpio =3D false;
> +	} else {
> +		return -EINVAL;
> +	}
> =20
>  	asd =3D spi->controller_state;
>  	if (!asd) {
> @@ -1591,7 +1599,7 @@ static int atmel_spi_setup(struct spi_device *s=
pi)
>  		if (!asd)
>  			return -ENOMEM;
> =20
> -		if (as->use_cs_gpios) {
> +		if (use_cs_gpio) {
>  			ret =3D gpio_request(npcs_pin, dev_name(&spi->dev));
>  			if (ret) {
>  				kfree(asd);
> @@ -1603,6 +1611,7 @@ static int atmel_spi_setup(struct spi_device *s=
pi)
>  		}
> =20
>  		asd->npcs_pin =3D npcs_pin;
> +		asd->use_cs_gpio =3D use_cs_gpio;
>  		spi->controller_state =3D asd;
>  	} else {
>  		atmel_spi_lock(as);
> @@ -1612,6 +1621,8 @@ static int atmel_spi_setup(struct spi_device *s=
pi)
>  		atmel_spi_unlock(as);
>  	}
> =20
> +	if (!asd->use_cs_gpio)
> +		csr |=3D SPI_BIT(CSAAT);
>  	asd->csr =3D csr;
> =20
>  	dev_dbg(&spi->dev,
> @@ -1807,12 +1818,9 @@ static int atmel_spi_probe(struct platform_dev=
ice *pdev)
> =20
>  	atmel_get_caps(as);
> =20
> -	as->use_cs_gpios =3D true;
>  	if (atmel_spi_is_v2(as) &&
> -	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
> -		as->use_cs_gpios =3D false;
> +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL))
>  		master->num_chipselect =3D 4;
> -	}
> =20
>  	as->use_dma =3D false;
>  	as->use_pdc =3D false;
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
