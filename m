From: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [RESEND v6  09/13] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Date: Tue, 10 Mar 2020 08:59:03 +0000
Message-ID: <VE1PR04MB6638029458AFDE3005C6E4A489FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-10-git-send-email-yibin.gong@nxp.com>
 <20200310081925.GT3335@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
        "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>,
        "l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "martin.fuzzey-X8SyT9posyX3d/wEbhiU/g@public.gmane.org" <martin.fuzzey-X8SyT9posyX3d/wEbhiU/g@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XcXa4x6EXUF0@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200310081925.GT3335-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2020/03/10 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:=20
> On Tue, Mar 10, 2020 at 07:31:58PM +0800, Robin Gong wrote:
> > ECSPI issue fixed from i.mx6ul at hardware level, no need
> > ERR009165 anymore on those chips such as i.mx8mq. Add i.mx6sx from
> > where i.mx6ul source.
> >
> > Signed-off-by: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
> > Acked-by: Vinod Koul <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/dma/imx-sdma.c | 51
> > +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > 56288d8..5ae7237 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -419,6 +419,13 @@ struct sdma_driver_data {
> >  	int num_events;
> >  	struct sdma_script_start_addrs	*script_addrs;
> >  	bool check_ratio;
> > +	/*
> > +	 * ecspi ERR009165 fixed should be done in sdma script
> > +	 * and it has been fixed in soc from i.mx6ul.
> > +	 * please get more information from the below link:
> > +	 *
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.n=
x
> p.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01%7Cyi
> bin.gong%40nxp.com%7C91d42046e6894501d48508d7c4cbcae2%7C686ea1d3
> bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637194251876090170&amp;sdata=3D
> T6LA4xz9CUFlNpnyjHSThEQb8i1rhbY9e1nUyxIGD5Q%3D&amp;reserved=3D0
> > +	 */
> > +	bool ecspi_fixed;
> >  };
> >
> >  struct sdma_engine {
> > @@ -539,6 +546,31 @@ static struct sdma_driver_data sdma_imx6q =3D {
> >  	.script_addrs =3D &sdma_script_imx6q,
> >  };
> >
> > +static struct sdma_script_start_addrs sdma_script_imx6sx =3D {
> > +	.ap_2_ap_addr =3D 642,
> > +	.uart_2_mcu_addr =3D 817,
> > +	.mcu_2_app_addr =3D 747,
> > +	.uartsh_2_mcu_addr =3D 1032,
> > +	.mcu_2_shp_addr =3D 960,
> > +	.app_2_mcu_addr =3D 683,
> > +	.shp_2_mcu_addr =3D 891,
> > +	.spdif_2_mcu_addr =3D 1100,
> > +	.mcu_2_spdif_addr =3D 1134,
> > +};
> > +
> > +static struct sdma_driver_data sdma_imx6sx =3D {
> > +	.chnenbl0 =3D SDMA_CHNENBL0_IMX35,
> > +	.num_events =3D 48,
> > +	.script_addrs =3D &sdma_script_imx6sx, };
> > +
> > +static struct sdma_driver_data sdma_imx6ul =3D {
> > +	.chnenbl0 =3D SDMA_CHNENBL0_IMX35,
> > +	.num_events =3D 48,
> > +	.script_addrs =3D &sdma_script_imx6sx,
> > +	.ecspi_fixed =3D true,
> > +};
> > +
> >  static struct sdma_script_start_addrs sdma_script_imx7d =3D {
> >  	.ap_2_ap_addr =3D 644,
> >  	.uart_2_mcu_addr =3D 819,
> > @@ -584,9 +616,15 @@ static const struct platform_device_id
> sdma_devtypes[] =3D {
> >  		.name =3D "imx6q-sdma",
> >  		.driver_data =3D (unsigned long)&sdma_imx6q,
> >  	}, {
> > +		.name =3D "imx6sx-sdma",
> > +		.driver_data =3D (unsigned long)&sdma_imx6sx,
> > +	}, {
>=20
> Now the i.MX6sx uses a new sdma_script_start_addrs entry which is the sam=
e
> as the i.MX6q one we used before with one exception: it lacks the
> per_2_per_addr =3D 6331 entry. This is only used for IMX_DMATYPE_ASRC and
Totally same script for i.mx6 chips whatever i.MX6sx, i.MX6q or i.MX6ul.=20
> IMX_DMATYPE_ASRC_SP, both are entirely unused in the mainline kernel. So
> why must the i.MX6sx changed here and what has this to do with ECSPI?
i.MX6ul is based on i.MX6sx, so adding i.MX6sx could keep good shape on our=
 i.MX family evolution.
>=20
> Sascha
>=20
> >  		.name =3D "imx7d-sdma",
> >  		.driver_data =3D (unsigned long)&sdma_imx7d,
> >  	}, {
> > +		.name =3D "imx6ul-sdma",
> > +		.driver_data =3D (unsigned long)&sdma_imx6ul,
> > +	}, {
> >  		.name =3D "imx8mq-sdma",
> >  		.driver_data =3D (unsigned long)&sdma_imx8mq,
> >  	}, {
> > @@ -602,7 +640,9 @@ static const struct of_device_id sdma_dt_ids[] =3D =
{
> >  	{ .compatible =3D "fsl,imx35-sdma", .data =3D &sdma_imx35, },
> >  	{ .compatible =3D "fsl,imx31-sdma", .data =3D &sdma_imx31, },
> >  	{ .compatible =3D "fsl,imx25-sdma", .data =3D &sdma_imx25, },
> > +	{ .compatible =3D "fsl,imx6sx-sdma", .data =3D &sdma_imx6sx, },
> >  	{ .compatible =3D "fsl,imx7d-sdma", .data =3D &sdma_imx7d, },
> > +	{ .compatible =3D "fsl,imx6ul-sdma", .data =3D &sdma_imx6ul, },
> >  	{ .compatible =3D "fsl,imx8mq-sdma", .data =3D &sdma_imx8mq, },
> >  	{ /* sentinel */ }
> >  };
> > @@ -1169,8 +1209,17 @@ static int sdma_config_channel(struct dma_chan
> *chan)
> >  			if (sdmac->peripheral_type =3D=3D IMX_DMATYPE_ASRC_SP ||
> >  			    sdmac->peripheral_type =3D=3D IMX_DMATYPE_ASRC)
> >  				sdma_set_watermarklevel_for_p2p(sdmac);
> > -		} else
> > +		} else {
> > +			/*
> > +			 * ERR009165 fixed from i.mx6ul, no errata need,
> > +			 * set bit31 to let sdma script skip the errata.
> > +			 */
> > +			if (sdmac->peripheral_type =3D=3D IMX_DMATYPE_CSPI &&
> > +			    sdmac->direction =3D=3D DMA_MEM_TO_DEV &&
> > +			    sdmac->sdma->drvdata->ecspi_fixed)
> > +				__set_bit(31, &sdmac->watermark_level);
> >  			__set_bit(sdmac->event_id0, sdmac->event_mask);
> > +		}
> >
> >  		/* Address */
> >  		sdmac->shp_addr =3D sdmac->per_address;
> > --
> > 2.7.4
> >
> >
>=20
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C91d4204
> 6e6894501d48508d7c4cbcae2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C1%7C637194251876090170&amp;sdata=3Dd0X1DBm%2Fc0lwcHVUtTW0ITw
> o5qW3SKtVd5Va0EVVw3E%3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
