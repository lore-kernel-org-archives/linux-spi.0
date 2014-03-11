From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] spi: efm32: Clean up non-DT paths
Date: Tue, 11 Mar 2014 19:26:57 +0100
Message-ID: <20140311182657.GB17973@pengutronix.de>
References: <1394409705.12514.2.camel@phoenix>
 <20140311090918.GA17973@pengutronix.de>
 <CAFRkauCkkGb6AXcwaE1ZBWp=nmtwBwJFXHTUGpLaLA=KNCy1Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFRkauCkkGb6AXcwaE1ZBWp=nmtwBwJFXHTUGpLaLA=KNCy1Cg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Axel,

On Tue, Mar 11, 2014 at 06:33:03PM +0800, Axel Lin wrote:
> 2014-03-11 17:09 GMT+08:00 Uwe Kleine-K=F6nig <u.kleine-koenig@pengut=
ronix.de>:
> > On Mon, Mar 10, 2014 at 08:01:45AM +0800, Axel Lin wrote:
> >> diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
> >> index f53bbea..26e0362 100644
> >> --- a/drivers/spi/spi-efm32.c
> >> +++ b/drivers/spi/spi-efm32.c
> >> @@ -318,9 +315,14 @@ static int efm32_spi_probe(struct platform_de=
vice *pdev)
> >>       int ret;
> >>       struct spi_master *master;
> >>       struct device_node *np =3D pdev->dev.of_node;
> >> -     unsigned int num_cs, i;
> >> +     int num_cs, i;
> >> +
> >> +     if (!np)
> >> +             return -EINVAL;
> >>
> >>       num_cs =3D of_gpio_named_count(np, "cs-gpios");
> >> +     if (num_cs < 0)
> >> +             return num_cs;
> > This wasn't checked before and doesn't fit into the "cleanup non-DT
> > paths"-category. Maybe note that in the commit log?
> Ok, will update commit log in v2.
>=20
> > Also did you change the type of i on purpose?
> It's a "doesn't matter" case to me.
> If you really like to keep i as unsigned int, I can leave it as
> unsigned int in v2.
I'd always use an unsigned type for it, but I don't care much.
=20
> >>       master =3D spi_alloc_master(&pdev->dev,
> >>                       sizeof(*ddata) + num_cs * sizeof(unsigned));
> >> @@ -412,23 +414,7 @@ static int efm32_spi_probe(struct platform_de=
vice *pdev)
> >>               goto err;
> >>       }
> >>
> >> -     ret =3D efm32_spi_probe_dt(pdev, master, ddata);
> >> -     if (ret > 0) {
> >> -             /* not created by device tree */
> >> -             const struct efm32_spi_pdata *pdata =3D
> >> -                     dev_get_platdata(&pdev->dev);
> >> -
> >> -             if (pdata)
> >> -                     ddata->pdata =3D *pdata;
> >> -             else
> >> -                     ddata->pdata.location =3D
> >> -                             efm32_spi_get_configured_location(dd=
ata);
> >> -
> >> -             master->bus_num =3D pdev->id;
> >> -
> >> -     } else if (ret < 0) {
> >> -             goto err_disable_clk;
> >> -     }
> >> +     efm32_spi_probe_dt(pdev, master, ddata);
> > This must still be:
> efm32_spi_probe_dt() always return 0, why *must* check the return val=
ue here?
Then also change efm32_spi_probe_dt to return void, or now that platfor=
m
device support is gone, inline it into efm32_spi_probe.

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
