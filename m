From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RESEND v6  07/13] spi: imx: remove ERR009165 workaround on
 i.mx6ul
Date: Tue, 10 Mar 2020 10:25:33 +0100
Message-ID: <20200310092533.GV3335@pengutronix.de>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-8-git-send-email-yibin.gong@nxp.com>
 <20200310080240.GS3335@pengutronix.de>
 <VE1PR04MB66384342F94C7B789C980F7A89FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
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
In-Reply-To: <VE1PR04MB66384342F94C7B789C980F7A89FF0-FtZFDU4e6kFwQYrqkif2Oc9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Mar 10, 2020 at 08:43:10AM +0000, Robin Gong wrote:
> On 2020/03/10 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > On Tue, Mar 10, 2020 at 07:31:56PM +0800, Robin Gong wrote:
> > > ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and i.mx8m/8mm
> > > still need this errata. Please refer to nxp official errata document
> > > from
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nx
> > p.com%2F&amp;data=02%7C01%7Cyibin.gong%40nxp.com%7Cf73bfc11a68c4
> > 2f5f6d308d7c4c96efa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C
> > 637194241755109112&amp;sdata=xzIUP8qZkrlDXX0yjTcUNZB6zDrevTdHFg1o4
> > PZZd8E%3D&amp;reserved=0 .
> > >
> > > For removing workaround on those chips. Add new i.mx6ul type.
> > >
> > > Signed-off-by: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
> > > Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > ---
> > >  drivers/spi/spi-imx.c | 50
> > > +++++++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 45 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > > 842a86e..f7ee2ec 100644
> > > --- a/drivers/spi/spi-imx.c
> > > +++ b/drivers/spi/spi-imx.c
> > > @@ -57,6 +57,7 @@ enum spi_imx_devtype {
> > >  	IMX35_CSPI,	/* CSPI on all i.mx except above */
> > >  	IMX51_ECSPI,	/* ECSPI on i.mx51 */
> > >  	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
> > > +	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
> > >  };
> > >
> > >  struct spi_imx_data;
> > > @@ -75,6 +76,11 @@ struct spi_imx_devtype_data {
> > >  	bool has_slavemode;
> > >  	unsigned int fifo_size;
> > >  	bool dynamic_burst;
> > > +	/*
> > > +	 * ERR009165 fixed or not:
> > > +	 *
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nx
> > p.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=02%7C01%7Cyi
> > bin.gong%40nxp.com%7Cf73bfc11a68c42f5f6d308d7c4c96efa%7C686ea1d3bc
> > 2b4c6fa92cd99c5c301635%7C0%7C1%7C637194241755109112&amp;sdata=m
> > uw4HL5nMDjREJwVd885Wrxka0moMaaZ%2BhJgsAgY3eo%3D&amp;reserved=
> > 0
> > > +	 */
> > > +	bool tx_glitch_fixed;
> > >  	enum spi_imx_devtype devtype;
> > >  };
> > >
> > > @@ -128,7 +134,8 @@ static inline int is_imx35_cspi(struct
> > > spi_imx_data *d)
> > >
> > >  static inline int is_imx51_ecspi(struct spi_imx_data *d)  {
> > > -	return d->devtype_data->devtype == IMX51_ECSPI;
> > > +	return d->devtype_data->devtype == IMX51_ECSPI ||
> > > +	       d->devtype_data->devtype == IMX6UL_ECSPI;
> > >  }
> > 
> > Erm, no. A i.MX51 ECSPI is a i.MX51 ECSPI and not a i.MX6UL ECSPI. If you want
> > to handle them equally somewhere then explicitly test for i.MX6ul *and*
> > i.MX51 there.
> But all i.mx6 chips including i.MX53 ECSPI are almost same as i.MX51 ECSPI, and ERR00915 is fixed from i.mx6ul....

You introduce .devtype = IMX6UL_ECSPI in this series, so apparently it
is *not* the same as IMX51_ECSPI, then please also don't introduce a
function which claims they are the same.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
