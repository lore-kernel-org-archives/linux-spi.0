From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1] spi: pxa2xx: set clock divider according to rate
Date: Wed, 24 Jan 2018 14:18:40 +0200
Message-ID: <ec4ebd15-e33e-978a-3234-dcc31621bb5c@linux.intel.com>
References: <20180124115952.51765-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180124115952.51765-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 01/24/2018 01:59 PM, Andy Shevchenko wrote:
> On Skylake and recent Intel SoCs we have a fractional divider installed on the
> reference clock for SPI host controller. It allows to much more precisely set
> clock rate on the interface. Use it to get better rate approximation especially
> on lowest speed.
> 
> This has been tested on updated version of clk-fractional-divider.c that uses
> rational best approximation algorithm [1].
> 
> [1] http://www.spinics.net/lists/linux-clk/msg03135.html
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   drivers/spi/spi-pxa2xx.c | 30 +++++++++++++++++++++++-------
>   drivers/spi/spi-pxa2xx.h |  1 +
>   2 files changed, 24 insertions(+), 7 deletions(-)
...
> +static unsigned int spt_get_clk_div(struct driver_data *drv_data, int rate)
> +{
> +	const struct ssp_device *ssp = drv_data->ssp;
> +	struct chip_data *chip = drv_data->cur_chip;
> +	long round;
> +
> +	round = clk_round_rate(ssp->clk, rate);
> +	clk_set_rate(ssp->clk, round);
> +

Are you sure about this? If I remember correctly clk_set_rate() may 
sleep and here call chain originates from tasklet pump_transfers() -> 
pxa2xx_ssp_get_clk_div() -> spt_get_clk_div().

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
