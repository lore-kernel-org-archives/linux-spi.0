From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: atmel: add support for the internal chip-select
 of the spi controller
Date: Tue, 9 Jun 2015 10:07:00 +0200
Message-ID: <55769EA4.7060602@atmel.com>
References: <cover.1433779081.git.cyrille.pitchen@atmel.com> <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433779081.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433779081.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 08/06/2015 18:07, Cyrille Pitchen a =E9crit :
> This patch relies on the CSAAT (Chip Select Active After Transfer) fe=
ature
> introduced by the version 2 of the spi controller. This new mode allo=
ws to
> use properly the internal chip-select output pin of the spi controlle=
r
> instead of using external gpios. Consequently, the "cs-gpios" device-=
tree
> property becomes optional.
>=20
> When the new CSAAT bit is set into the Chip Select Register, the inte=
rnal
> chip-select output pin remains asserted till both the following condi=
tions
> become true:
> - the LASTXFER bit is set into the Control Register (or the Transmit =
Data
>   Register)
> - the Transmit Data Register and its shift register are empty.
>=20
> WARNING: if the LASTXFER bit is set into the Control Register then ne=
w
> data are written into the Transmit Data Register fast enough to keep =
its
> shifter not empty, the chip-select output pin remains asserted. Only =
when
> the shifter becomes empty, the chip-select output pin is unasserted.
>=20
> When the CSAAT bit is clear in the Chip Select Register, the LASTXFER=
 bit
> is ignored in both the Control Register and the Transmit Data Registe=
r.
> The internal chip-select output pin remains active as long as the Tra=
nsmit
> Data Register or its shift register are not empty.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

It seems okay:
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Thanks.

Some additional changes might be needed: see below...


> ---
>  drivers/spi/spi-atmel.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index a2f40b1..aa7d202 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -246,6 +246,7 @@ struct atmel_spi {
> =20
>  	bool			use_dma;
>  	bool			use_pdc;
> +	bool			use_cs_gpios;
>  	/* dmaengine data */
>  	struct atmel_spi_dma	dma;
> =20
> @@ -321,7 +322,8 @@ static void cs_activate(struct atmel_spi *as, str=
uct spi_device *spi)
>  		}
> =20
>  		mr =3D spi_readl(as, MR);
> -		gpio_set_value(asd->npcs_pin, active);
> +		if (as->use_cs_gpios)
> +			gpio_set_value(asd->npcs_pin, active);
>  	} else {
>  		u32 cpol =3D (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
>  		int i;
> @@ -337,7 +339,7 @@ static void cs_activate(struct atmel_spi *as, str=
uct spi_device *spi)
> =20
>  		mr =3D spi_readl(as, MR);
>  		mr =3D SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
> -		if (spi->chip_select !=3D 0)
> +		if (as->use_cs_gpios && spi->chip_select !=3D 0)
>  			gpio_set_value(asd->npcs_pin, active);
>  		spi_writel(as, MR, mr);
>  	}

Maybe in a debug function in cs_activate()...

> @@ -366,7 +368,9 @@ static void cs_deactivate(struct atmel_spi *as, s=
truct spi_device *spi)
>  			asd->npcs_pin, active ? " (low)" : "",
>  			mr);
> =20
> -	if (atmel_spi_is_v2(as) || spi->chip_select !=3D 0)
> +	if (!as->use_cs_gpios)
> +		spi_writel(as, CR, SPI_BIT(LASTXFER));
> +	else if (atmel_spi_is_v2(as) || spi->chip_select !=3D 0)
>  		gpio_set_value(asd->npcs_pin, !active);
>  }
> =20

=2E.. as well as in cs_deactivate(), you need to change the use of
asd->npcs_pin:

        dev_dbg(&spi->dev, "activate %u%s, mr %08x\n",
                        asd->npcs_pin, active ? " (high)" : "",
                        mr);

so that it is still relevant in the !as->use_cs_gpios case...

Bye,

> @@ -996,6 +1000,8 @@ static int atmel_spi_setup(struct spi_device *sp=
i)
>  		csr |=3D SPI_BIT(CPOL);
>  	if (!(spi->mode & SPI_CPHA))
>  		csr |=3D SPI_BIT(NCPHA);
> +	if (!as->use_cs_gpios)
> +		csr |=3D SPI_BIT(CSAAT);
> =20
>  	/* DLYBS is mostly irrelevant since we manage chipselect using GPIO=
s.
>  	 *
> @@ -1009,7 +1015,9 @@ static int atmel_spi_setup(struct spi_device *s=
pi)
>  	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
>  	npcs_pin =3D (unsigned long)spi->controller_data;
> =20
> -	if (gpio_is_valid(spi->cs_gpio))
> +	if (!as->use_cs_gpios)
> +		npcs_pin =3D spi->chip_select;
> +	else if (gpio_is_valid(spi->cs_gpio))
>  		npcs_pin =3D spi->cs_gpio;
> =20
>  	asd =3D spi->controller_state;
> @@ -1018,15 +1026,19 @@ static int atmel_spi_setup(struct spi_device =
*spi)
>  		if (!asd)
>  			return -ENOMEM;
> =20
> -		ret =3D gpio_request(npcs_pin, dev_name(&spi->dev));
> -		if (ret) {
> -			kfree(asd);
> -			return ret;
> +		if (as->use_cs_gpios) {
> +			ret =3D gpio_request(npcs_pin, dev_name(&spi->dev));
> +			if (ret) {
> +				kfree(asd);
> +				return ret;
> +			}
> +
> +			gpio_direction_output(npcs_pin,
> +					      !(spi->mode & SPI_CS_HIGH));
>  		}
> =20
>  		asd->npcs_pin =3D npcs_pin;
>  		spi->controller_state =3D asd;
> -		gpio_direction_output(npcs_pin, !(spi->mode & SPI_CS_HIGH));
>  	}
> =20
>  	asd->csr =3D csr;
> @@ -1338,6 +1350,13 @@ static int atmel_spi_probe(struct platform_dev=
ice *pdev)
> =20
>  	atmel_get_caps(as);
> =20
> +	as->use_cs_gpios =3D true;
> +	if (atmel_spi_is_v2(as) &&
> +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
> +		as->use_cs_gpios =3D false;
> +		master->num_chipselect =3D 4;
> +	}
> +
>  	as->use_dma =3D false;
>  	as->use_pdc =3D false;
>  	if (as->caps.has_dma_support) {
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
