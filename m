From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH v2 3/5] spi: dw: add support for gpio controlled chip
 select
Date: Tue, 28 Jan 2014 20:11:16 +0200
Message-ID: <20140128181116.GB5596@tarshish>
References: <cover.1390723880.git.baruch@tkos.co.il>
 <b9ce1224f836ec84d5c75636b6838039a7664c89.1390723880.git.baruch@tkos.co.il>
 <20140127185754.GK11841@sirena.org.uk>
 <20140128123506.GY5596@tarshish>
 <20140128154212.GN11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140128154212.GN11841-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Tue, Jan 28, 2014 at 03:42:12PM +0000, Mark Brown wrote:
> On Tue, Jan 28, 2014 at 02:35:06PM +0200, Baruch Siach wrote:
> > So how about doing devm_gpio_request_one() in probe() right after 
> > devm_spi_register_master()? This should be compatible with deferral, and 
> > yet avoid open coding the "cs-gpios" property parsing as the pl022 driver 
> > does.
> 
> It needs to before otherwise we'll try to instantiate the slaves without
> their chip select which isn't going to be a great idea.  The ideal thing
> would be for this to be handled in the core rather than in the
> individual drivers, the property is standard.

So until the core code gains this ability to request gpios what is the best 
option? Do as pl022 is doing? Leave it at .setup? Something else?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
