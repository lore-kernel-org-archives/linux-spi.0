From: "Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] spi/atmel: add support for runtime PM
Date: Thu, 16 Oct 2014 08:09:49 +0000
Message-ID: <B256D81BAE5131468A838E5D7A243641BF589DDC@penmbx02.corp.atmel.com>
References: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
 <20141016073004.GL27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ferre, Nicolas" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141016073004.GL27755-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Thursday, October 16, 2014 3:30 PM
> To: Yang, Wenyou
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Ferre, Nicolas; linux-
> arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH] spi/atmel: add support for runtime PM
> 
> On Thu, Oct 16, 2014 at 09:49:20AM +0800, Wenyou Yang wrote:
> 
> > +static int atmel_spi_runtime_resume(struct device *dev) {
> > +	struct spi_master *master = dev_get_drvdata(dev);
> > +	struct atmel_spi *as = spi_master_get_devdata(master);
> > +
> > +	pinctrl_pm_select_default_state(dev);
> > +	clk_prepare_enable(as->clk);
> > +
> 
> This looks mostly good but you should check the return value of
> clk_prepare_enable() - it can fail.
Thanks a lot, I will add it.

Best Regards,
Wenyou Yang
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
