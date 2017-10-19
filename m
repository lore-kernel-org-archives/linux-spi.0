From: Oleksij Rempel <ore-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: imx: GPIO based chip selects should not be
 required
Date: Thu, 19 Oct 2017 12:17:16 +0200
Message-ID: <20171019101715.wmm6avnoyb5r3bsv@pengutronix.de>
References: <1507918921.24265.8.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "fabio.estevam-3arQi8VN3Tc@public.gmane.org" <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1507918921.24265.8.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Oct 13, 2017 at 06:22:01PM +0000, Trent Piepho wrote:
> The driver will fail to load if no gpio chip selects are specified,
> this patch changes this so that it no longer fails.
> 
> It's possible to use all native chip selects, in which case there is
> no reason to have a gpio chip select array.  This is what happens if
> the *optional* device tree property "cs-gpios" is omitted.
> 
> The spi core already checks for the absence of gpio chip selects in
> the master and assigns any slaves the gpio_cs value of -ENOENT.
> 
> Signed-off-by: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-imx.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index babb15f07995..07e6250f2dad 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1457,22 +1457,19 @@ static int spi_imx_probe(struct platform_device *pdev)
>  		goto out_clk_put;
>  	}
>  
> -	if (!master->cs_gpios) {
> -		dev_err(&pdev->dev, "No CS GPIOs available\n");
> -		ret = -EINVAL;
> -		goto out_clk_put;
> -	}
> -
> -	for (i = 0; i < master->num_chipselect; i++) {
> -		if (!gpio_is_valid(master->cs_gpios[i]))
> -			continue;
> -
> -		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
> -					DRIVER_NAME);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
> -				master->cs_gpios[i]);
> -			goto out_clk_put;
> +	/* Request GPIO CS lines, if any */
> +	if (master->cs_gpios) {
> +		for (i = 0; i < master->num_chipselect; i++) {
> +			if (!gpio_is_valid(master->cs_gpios[i]))
> +				continue;
> +
> +			ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
> +						DRIVER_NAME);
> +			if (ret) {
> +				dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
> +					master->cs_gpios[i]);
> +				goto out_clk_put;
> +			}
>  		}
>  	}
>  
> -- 
> 2.13.6

Reviewed-by: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
