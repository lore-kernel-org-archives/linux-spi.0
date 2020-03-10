From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RESEND v6  06/13] spi: imx: fix ERR009165
Date: Tue, 10 Mar 2020 09:37:25 +0100
Message-ID: <20200310083725.sb6cufp5wznvxcji@pengutronix.de>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-7-git-send-email-yibin.gong@nxp.com>
 <20200310073920.GR3335@pengutronix.de>
 <VE1PR04MB66384DA6732A840FE1D80C1989FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
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
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-kernel@vg
To: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB66384DA6732A840FE1D80C1989FF0-FtZFDU4e6kFwQYrqkif2Oc9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

On Tue, Mar 10, 2020 at 08:27:41AM +0000, Robin Gong wrote:
> On 2020/03/10 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > On Tue, Mar 10, 2020 at 07:31:55PM +0800, Robin Gong wrote:
> > >  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> > >
> > > @@ -612,12 +613,14 @@ static int mx51_ecspi_prepare_transfer(struct
> > > spi_imx_data *spi_imx,
> > >
> > >  static void mx51_setup_wml(struct spi_imx_data *spi_imx)  {
> > > +	u32 tx_wml = 0;
> > > +
> > >  	/*
> > >  	 * Configure the DMA register: setup the watermark
> > >  	 * and enable DMA request.
> > >  	 */
> > >  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> > > -		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
> > > +		MX51_ECSPI_DMA_TX_WML(tx_wml) |
> > 
> > tx_wml is never assigned any other value than 0. Drop the variable.
> That's prepared for 07/13 patch which may assign spi_imx->wml to tx_wml.

Then this belongs into patch 7, right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
