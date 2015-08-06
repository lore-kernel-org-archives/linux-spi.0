From: leilk liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 1/3] dt-binding: spi: Mediatek: Document devicetree
 bindings for spi bus
Date: Thu, 6 Aug 2015 09:45:40 +0800
Message-ID: <1438825540.2163.5.camel@mhfsdcap03>
References: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
	 <1438167874-1305-2-git-send-email-leilk.liu@mediatek.com>
	 <20150804174226.GE20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150804174226.GE20873-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2015-08-04 at 18:42 +0100, Mark Brown wrote:
> On Wed, Jul 29, 2015 at 07:04:32PM +0800, Leilk Liu wrote:
> > Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> Please use subject lines reflecting the style for the subsystem so
> people can spot if patches are relevant to them.
> 

OK, I will change the title to "spi: Mediatek: Document devicetree
bindings for spi bus".

> > +- clocks: phandles to input clocks.
> > +
> > +- clock-names: tuple listing input clock names.
> > +	Required elements: "main"
> 
> ...and there are no optional values?
> 

clock tree provides some source clocks, CLK_PERI_SPI0 is the default
one. I will support optional values on the next version.

> > +- pad-select: should specify spi pad used, only required for MT8173.
> > +        This value should be 0~3.
> 
> What do the values 0-3 mean?  I guess it's the value for some register
> or other part of the device, the binding should say so people can go and
> check the datasheet, schematic or whatever to figure out what to set.
> 
> This property should be optional, not required

OK, I will explain what the values 0-3 mean.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
