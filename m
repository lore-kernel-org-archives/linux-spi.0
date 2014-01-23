From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH RFC 3/4] spi: dw: add support for gpio controlled chip
 select
Date: Thu, 23 Jan 2014 16:05:46 +0200
Message-ID: <20140123140546.GG12751@tarshish>
References: <cover.1390481412.git.baruch@tkos.co.il>
 <cc63df805aa126eede50aa11b3fb3c5bdef67f65.1390481413.git.baruch@tkos.co.il>
 <20140123132623.GN17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140123132623.GN17314-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Thu, Jan 23, 2014 at 01:26:23PM +0000, Mark Brown wrote:
> On Thu, Jan 23, 2014 at 03:05:58PM +0200, Baruch Siach wrote:
> > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> 
> If you convert to the generic queue then there's generic support for
> managing a GPIO based /CS if you set cs_gpio in the spi_device.  We
> should extend that for GPIO descriptors too.

Thank. This further simplifies things. AFAICS the generic gpio chip select 
code does not request the GPIO. Is there a reason for that?

> > +	if (gpio_is_valid(spi->cs_gpio)) {
> > +		ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
> > +		if (ret)
> > +			return ret;
> > +		ret = gpio_direction_output(spi->cs_gpio,
> > +				!(spi->mode & SPI_CS_HIGH));
> 
> devm_gpio_request_one().

Right.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
