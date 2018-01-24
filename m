From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1] spi: pxa2xx: set clock divider according to rate
Date: Wed, 24 Jan 2018 15:05:42 +0200
Message-ID: <1516799142.7000.1216.camel@linux.intel.com>
References: <20180124115952.51765-1-andriy.shevchenko@linux.intel.com>
         <ec4ebd15-e33e-978a-3234-dcc31621bb5c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ec4ebd15-e33e-978a-3234-dcc31621bb5c-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2018-01-24 at 14:18 +0200, Jarkko Nikula wrote:
> On 01/24/2018 01:59 PM, Andy Shevchenko wrote:

> > +static unsigned int spt_get_clk_div(struct driver_data *drv_data,
> > int rate)
> > +{
> > +	const struct ssp_device *ssp = drv_data->ssp;
> > +	struct chip_data *chip = drv_data->cur_chip;
> > +	long round;
> > +
> > +	round = clk_round_rate(ssp->clk, rate);
> > +	clk_set_rate(ssp->clk, round);
> > +
> 
> Are you sure about this? If I remember correctly clk_set_rate() may 
> sleep and here call chain originates from tasklet pump_transfers() -> 
> pxa2xx_ssp_get_clk_div() -> spt_get_clk_div().

Indeed. Apparently needs more test with additional debugging options
enabled.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
