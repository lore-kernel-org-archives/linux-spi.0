From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] spi: efm32: Clean up non-DT paths
Date: Tue, 11 Mar 2014 10:09:18 +0100
Message-ID: <20140311090918.GA17973@pengutronix.de>
References: <1394409705.12514.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394409705.12514.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Axel,

On Mon, Mar 10, 2014 at 08:01:45AM +0800, Axel Lin wrote:
> This is a DT-only driver, so remove all non-DT paths.
ok in general, but I have a few comments, see below.

> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-efm32.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
> index f53bbea..26e0362 100644
> --- a/drivers/spi/spi-efm32.c
> +++ b/drivers/spi/spi-efm32.c
> @@ -294,9 +294,6 @@ static int efm32_spi_probe_dt(struct platform_dev=
ice *pdev,
>  	u32 location;
>  	int ret;
> =20
> -	if (!np)
> -		return 1;
> -
>  	ret =3D of_property_read_u32(np, "location", &location);
>  	if (!ret) {
>  		dev_dbg(&pdev->dev, "using location %u\n", location);
> @@ -318,9 +315,14 @@ static int efm32_spi_probe(struct platform_devic=
e *pdev)
>  	int ret;
>  	struct spi_master *master;
>  	struct device_node *np =3D pdev->dev.of_node;
> -	unsigned int num_cs, i;
> +	int num_cs, i;
> +
> +	if (!np)
> +		return -EINVAL;
> =20
>  	num_cs =3D of_gpio_named_count(np, "cs-gpios");
> +	if (num_cs < 0)
> +		return num_cs;
This wasn't checked before and doesn't fit into the "cleanup non-DT
paths"-category. Maybe note that in the commit log?
Also did you change the type of i on purpose?

>  	master =3D spi_alloc_master(&pdev->dev,
>  			sizeof(*ddata) + num_cs * sizeof(unsigned));
> @@ -412,23 +414,7 @@ static int efm32_spi_probe(struct platform_devic=
e *pdev)
>  		goto err;
>  	}
> =20
> -	ret =3D efm32_spi_probe_dt(pdev, master, ddata);
> -	if (ret > 0) {
> -		/* not created by device tree */
> -		const struct efm32_spi_pdata *pdata =3D
> -			dev_get_platdata(&pdev->dev);
> -
> -		if (pdata)
> -			ddata->pdata =3D *pdata;
> -		else
> -			ddata->pdata.location =3D
> -				efm32_spi_get_configured_location(ddata);
> -
> -		master->bus_num =3D pdev->id;
> -
> -	} else if (ret < 0) {
> -		goto err_disable_clk;
> -	}
> +	efm32_spi_probe_dt(pdev, master, ddata);
This must still be:

	ret =3D efm32_spi_probe_dt(pdev, master, ddata);
	if (ret < 0)
		goto err_disable_clk;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
