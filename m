From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RESEND v6  09/13] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Date: Tue, 10 Mar 2020 10:28:03 +0100
Message-ID: <20200310092803.GW3335@pengutronix.de>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-10-git-send-email-yibin.gong@nxp.com>
 <20200310081925.GT3335@pengutronix.de>
 <VE1PR04MB6638029458AFDE3005C6E4A489FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638029458AFDE3005C6E4A489FF0-FtZFDU4e6kFwQYrqkif2Oc9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Mar 10, 2020 at 08:59:03AM +0000, Robin Gong wrote:
> On 2020/03/10 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote: 
> > On Tue, Mar 10, 2020 at 07:31:58PM +0800, Robin Gong wrote:
> > > ECSPI issue fixed from i.mx6ul at hardware level, no need
> > > ERR009165 anymore on those chips such as i.mx8mq. Add i.mx6sx from
> > > where i.mx6ul source.
> > >
> > > Signed-off-by: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
> > > Acked-by: Vinod Koul <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > ---
> > >  drivers/dma/imx-sdma.c | 51
> > > +++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 50 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > > 56288d8..5ae7237 100644
> > > --- a/drivers/dma/imx-sdma.c
> > > +++ b/drivers/dma/imx-sdma.c
> > > @@ -419,6 +419,13 @@ struct sdma_driver_data {
> > >  	int num_events;
> > >  	struct sdma_script_start_addrs	*script_addrs;
> > >  	bool check_ratio;
> > > +	/*
> > > +	 * ecspi ERR009165 fixed should be done in sdma script
> > > +	 * and it has been fixed in soc from i.mx6ul.
> > > +	 * please get more information from the below link:
> > > +	 *
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nx
> > p.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=02%7C01%7Cyi
> > bin.gong%40nxp.com%7C91d42046e6894501d48508d7c4cbcae2%7C686ea1d3
> > bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637194251876090170&amp;sdata=
> > T6LA4xz9CUFlNpnyjHSThEQb8i1rhbY9e1nUyxIGD5Q%3D&amp;reserved=0
> > > +	 */
> > > +	bool ecspi_fixed;
> > >  };
> > >
> > >  struct sdma_engine {
> > > @@ -539,6 +546,31 @@ static struct sdma_driver_data sdma_imx6q = {
> > >  	.script_addrs = &sdma_script_imx6q,
> > >  };
> > >
> > > +static struct sdma_script_start_addrs sdma_script_imx6sx = {
> > > +	.ap_2_ap_addr = 642,
> > > +	.uart_2_mcu_addr = 817,
> > > +	.mcu_2_app_addr = 747,
> > > +	.uartsh_2_mcu_addr = 1032,
> > > +	.mcu_2_shp_addr = 960,
> > > +	.app_2_mcu_addr = 683,
> > > +	.shp_2_mcu_addr = 891,
> > > +	.spdif_2_mcu_addr = 1100,
> > > +	.mcu_2_spdif_addr = 1134,
> > > +};
> > > +
> > > +static struct sdma_driver_data sdma_imx6sx = {
> > > +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> > > +	.num_events = 48,
> > > +	.script_addrs = &sdma_script_imx6sx, };
> > > +
> > > +static struct sdma_driver_data sdma_imx6ul = {
> > > +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> > > +	.num_events = 48,
> > > +	.script_addrs = &sdma_script_imx6sx,
> > > +	.ecspi_fixed = true,
> > > +};
> > > +
> > >  static struct sdma_script_start_addrs sdma_script_imx7d = {
> > >  	.ap_2_ap_addr = 644,
> > >  	.uart_2_mcu_addr = 819,
> > > @@ -584,9 +616,15 @@ static const struct platform_device_id
> > sdma_devtypes[] = {
> > >  		.name = "imx6q-sdma",
> > >  		.driver_data = (unsigned long)&sdma_imx6q,
> > >  	}, {
> > > +		.name = "imx6sx-sdma",
> > > +		.driver_data = (unsigned long)&sdma_imx6sx,
> > > +	}, {
> > 
> > Now the i.MX6sx uses a new sdma_script_start_addrs entry which is the same
> > as the i.MX6q one we used before with one exception: it lacks the
> > per_2_per_addr = 6331 entry. This is only used for IMX_DMATYPE_ASRC and
> Totally same script for i.mx6 chips whatever i.MX6sx, i.MX6q or i.MX6ul. 

When it's the same then use it.

> > IMX_DMATYPE_ASRC_SP, both are entirely unused in the mainline kernel. So
> > why must the i.MX6sx changed here and what has this to do with ECSPI?
> i.MX6ul is based on i.MX6sx, so adding i.MX6sx could keep good shape on our i.MX family evolution.

My point is that there is no difference between i.MX6q and i.MX6sx here,
so do not artificially introduce i.MX6sx support when all you do is
copying the i.MX6q support.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
