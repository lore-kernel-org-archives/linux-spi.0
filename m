From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
Date: Wed, 10 Jun 2015 16:06:09 +0800
Message-ID: <1433923569.22080.1.camel@mtksdaap41>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
	 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
	 <20150508175306.GG2761@sirena.org.uk> <1431434356.2128.9.camel@mhfsdcap03>
	 <20150512160540.GB3066@sirena.org.uk> <1431675522.2128.13.camel@mhfsdcap03>
	 <20150515092543.GY2761@sirena.org.uk>
	 <1433758546.19786.16.camel@mtksdaap41>
	 <20150608175927.GO14071@sirena.org.uk>
	 <1433844321.16178.6.camel@mtksdaap41>
	 <20150609103951.GA14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Leilk Liu =?UTF-8?Q?=28=E5=88=98=E7=A3=8A=29?=
	<Leilk.Liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"Kumar Gala" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>,
	HongZhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Sascha Hauer <kernel@pengutroni
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150609103951.GA14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Tue, 2015-06-09 at 11:39 +0100, Mark Brown wrote:
> On Tue, Jun 09, 2015 at 06:05:21PM +0800, Eddie Huang wrote:
> 
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -539,8 +539,8 @@ static int __spi_map_msg(struct spi_master *master,
> > struct spi_message *msg)
> >         if (!master->can_dma)
> >                 return 0;
> 
> > -       tx_dev = master->dma_tx->device->dev;
> > -       rx_dev = master->dma_rx->device->dev;
> > +       tx_dev = master->dma_tx ? master->dma_tx->device->dev :
> > master->dev;
> > +       rx_dev = master->dma_rx ? master->dma_rx->device->dev : master-
> 
> > Is this what you want ? Actually, I don't like first one at all.
> 
> Not quite what I'd been thinking of - we can't just pick the device in
> the core safely, the device might be a MFD or have some other
> restriction that needs us to use a separate struct device.  However most
> of those cases are likely to point towards implementing a dmaengine
> device so probably the above will work for most cases and is fine.  Can
> you send a proper patch please?

Sure, we will send this with new MTK SPI driver, such that can verify
it.

> 
> Please don't use the ternery operator, though.
OK, will fix it

Eddie
Thanks


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
