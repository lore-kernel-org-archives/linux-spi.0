From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 2/2] spi/s3c64xx: Implement runtime PM support
Date: Tue, 13 Dec 2011 16:02:41 +0100
Message-ID: <201112131602.43395.heiko@sntech.de>
References: <1323103813-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1323103813-5325-2-git-send-email-broonie@opensource.wolfsonmicro.com> <201112131549.45384.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201112131549.45384.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am Dienstag, 13. Dezember 2011, 15:49:44 schrieb Heiko St=FCbner:
> Am Montag, 5. Dezember 2011, 17:50:13 schrieb Mark Brown:
> > Enable and disable the clocks to the SPI controller using runtime P=
M.
> > This serves the dual purpose of reducing power consumption a little=
 and
> > letting the core know when the device is idle.
> >=20
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>=20
> Acked-by: Heiko Stuebner <heiko@sntech.de
>=20
> Kgene and/or Grant: could we move this forward, as I would like to pr=
ofit
> from this change later on too :-)

it seems I got the wrong patch and the one from 2011-12-05 21:01 +0000
	[PATCH 3/3] spi/s3c64xx: Implement runtime PM support
which seems to have the same content would have been the correct one to=
 ack=20
and ping.


Sorry for the confusion
Heiko

> Thanks
> Heiko
>=20
> > ---
> >=20
> >  drivers/spi/spi-s3c64xx.c |   39 +++++++++++++++++++++++++++++++++=
++++++
> >  1 files changed, 39 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> > index fef1c90..9031783 100644
> > --- a/drivers/spi/spi-s3c64xx.c
> > +++ b/drivers/spi/spi-s3c64xx.c
> > @@ -25,6 +25,7 @@
> >=20
> >  #include <linux/clk.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/platform_device.h>
> >=20
> > +#include <linux/pm_runtime.h>
> >=20
> >  #include <linux/spi/spi.h>
> > =20
> >  #include <mach/dma.h>
> >=20
> > @@ -782,6 +783,8 @@ static void s3c64xx_spi_work(struct work_struct
> > *work)
> >=20
> >  	while (!acquire_dma(sdd))
> >  =09
> >  		msleep(10);
> >=20
> > +	pm_runtime_get_sync(&sdd->pdev->dev);
> > +
> >=20
> >  	spin_lock_irqsave(&sdd->lock, flags);
> >  =09
> >  	while (!list_empty(&sdd->queue)
> >=20
> > @@ -810,6 +813,8 @@ static void s3c64xx_spi_work(struct work_struct
> > *work)
> >=20
> >  	/* Free DMA channels */
> >  	sdd->ops->release(sdd->rx_dma.ch, &s3c64xx_spi_dma_client);
> >  	sdd->ops->release(sdd->tx_dma.ch, &s3c64xx_spi_dma_client);
> >=20
> > +
> > +	pm_runtime_put(&sdd->pdev->dev);
> >=20
> >  }
> > =20
> >  static int s3c64xx_spi_transfer(struct spi_device *spi,
> >=20
> > @@ -892,6 +897,8 @@ static int s3c64xx_spi_setup(struct spi_device =
*spi)
> >=20
> >  		goto setup_exit;
> >  =09
> >  	}
> >=20
> > +	pm_runtime_get_sync(&sdd->pdev->dev);
> > +
> >=20
> >  	/* Check if we can provide the requested rate */
> >  	if (!sci->clk_from_cmu) {
> >  =09
> >  		u32 psr, speed;
> >=20
> > @@ -924,6 +931,8 @@ static int s3c64xx_spi_setup(struct spi_device =
*spi)
> >=20
> >  			err =3D -EINVAL;
> >  =09
> >  	}
> >=20
> > +	pm_runtime_put(&sdd->pdev->dev);
> > +
> >=20
> >  setup_exit:
> >  	/* setup() returns with device de-selected */
> >=20
> > @@ -1159,6 +1168,8 @@ static int __init s3c64xx_spi_probe(struct
> > platform_device *pdev) mem_res->end, mem_res->start,
> >=20
> >  					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
> >=20
> > +	pm_runtime_enable(&pdev->dev);
> > +
> >=20
> >  	return 0;
> > =20
> >  err9:
> > @@ -1192,6 +1203,8 @@ static int s3c64xx_spi_remove(struct
> > platform_device *pdev) struct resource	*mem_res;
> >=20
> >  	unsigned long flags;
> >=20
> > +	pm_runtime_disable(&pdev->dev);
> > +
> >=20
> >  	spin_lock_irqsave(&sdd->lock, flags);
> >  	sdd->state |=3D SUSPND;
> >  	spin_unlock_irqrestore(&sdd->lock, flags);
> >=20
> > @@ -1272,8 +1285,34 @@ static int s3c64xx_spi_resume(struct device =
*dev)
> >=20
> >  }
> >  #endif /* CONFIG_PM */
> >=20
> > +#ifdef CONFIG_PM_RUNTIME
> > +static int s3c64xx_spi_runtime_suspend(struct device *dev)
> > +{
> > +	struct spi_master *master =3D spi_master_get(dev_get_drvdata(dev)=
);
> > +	struct s3c64xx_spi_driver_data *sdd =3D spi_master_get_devdata(ma=
ster);
> > +
> > +	clk_disable(sdd->clk);
> > +	clk_disable(sdd->src_clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int s3c64xx_spi_runtime_resume(struct device *dev)
> > +{
> > +	struct spi_master *master =3D spi_master_get(dev_get_drvdata(dev)=
);
> > +	struct s3c64xx_spi_driver_data *sdd =3D spi_master_get_devdata(ma=
ster);
> > +
> > +	clk_enable(sdd->src_clk);
> > +	clk_enable(sdd->clk);
> > +
> > +	return 0;
> > +}
> > +#endif /* CONFIG_PM_RUNTIME */
> > +
> >=20
> >  static struct dev_pm_ops s3c64xx_spi_pm =3D {
> > =20
> >  	SET_SYSTEM_SLEEP_PM_OPS(s3c64xx_spi_suspend, s3c64xx_spi_resume)
> >=20
> > +	SET_RUNTIME_PM_OPS(s3c64xx_spi_runtime_suspend,
> > +			   s3c64xx_spi_runtime_resume, NULL)
> >=20
> >  };
> > =20
> >  static struct platform_driver s3c64xx_spi_driver =3D {
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in the body of a message to majordomo@vger.kernel.=
org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
