From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH v2 3/5] spi: dw: add support for gpio controlled chip
 select
Date: Tue, 28 Jan 2014 14:35:06 +0200
Message-ID: <20140128123506.GY5596@tarshish>
References: <cover.1390723880.git.baruch@tkos.co.il>
 <b9ce1224f836ec84d5c75636b6838039a7664c89.1390723880.git.baruch@tkos.co.il>
 <20140127185754.GK11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140127185754.GK11841-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Mon, Jan 27, 2014 at 06:57:54PM +0000, Mark Brown wrote:
> > +	if (gpio_is_valid(spi->cs_gpio)) {
> > +		ret = devm_gpio_request(&spi->dev, spi->cs_gpio,
> > +				dev_name(&spi->dev));
> > +		if (ret)
> > +			return ret;
> > +		ret = gpio_direction_output(spi->cs_gpio,
> > +				!(spi->mode & SPI_CS_HIGH));
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> Should be devm_gpio_request_one().  This won't work with probe deferral,
> it's outside the probe() function so nothing will retry.

So how about doing devm_gpio_request_one() in probe() right after 
devm_spi_register_master()? This should be compatible with deferral, and yet 
avoid open coding the "cs-gpios" property parsing as the pl022 driver does.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
