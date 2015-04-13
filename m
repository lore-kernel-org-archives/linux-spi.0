From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Mon, 13 Apr 2015 15:45:21 -0500
Message-ID: <20150413204521.GA2873@deathray>
References: <1428528961-7838-1-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428528961-7838-1-git-send-email-mwelling-EkmVulN54Sk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I noticed a response to my message on the mailing lists that did not appear in
my mailbox. Not sure where it went.

Sorry about the over 80 characters in the commit log.

As for the question about the uninitialized GPIOs, it is taken care in the 
core SPI driver.

The cs_gpio struct member is initialized to -ENOENT in spi_alloc_device:
http://lxr.free-electrons.com/source/drivers/spi/spi.c#L353

If there are GPIOs specified in the devicetree the value is updated:
http://lxr.free-electrons.com/source/drivers/spi/spi.c#L440

On Wed, Apr 08, 2015 at 04:36:01PM -0500, Michael Welling wrote:
> This patch allows for GPIOs specified in the devicetree to be used as SPI chipselects
> on TI OMAP2 SoCs.
> 
> Tested on the AM3354.
> 
> Signed-off-by: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
> ---
>  drivers/spi/spi-omap2-mcspi.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 4df8942..464dec9 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -35,6 +35,7 @@
>  #include <linux/gcd.h>
>  
>  #include <linux/spi/spi.h>
> +#include <linux/gpio.h>
>  
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  
> @@ -246,6 +247,9 @@ static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
>  {
>  	u32 l;
>  
> +	if (gpio_is_valid(spi->cs_gpio))
> +		gpio_set_value(spi->cs_gpio, (cs_active) ? 0 : 1);
> +

This may need to be changed to reflect the value of the spi->mode SPI_CS_HIGH
bit. It seems that I assumed that the chipselects are active low above.

>  	l = mcspi_cached_chconf0(spi);
>  	if (cs_active)
>  		l |= OMAP2_MCSPI_CHCONF_FORCE;
> @@ -1015,6 +1019,12 @@ static int omap2_mcspi_setup(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (gpio_is_valid(spi->cs_gpio)) {
> +		if (gpio_request(spi->cs_gpio, dev_name(&spi->dev)) == 0)
> +			gpio_direction_output(spi->cs_gpio,
> +					!(spi->mode & SPI_CS_HIGH));
> +	}
> +
>  	ret = omap2_mcspi_setup_transfer(spi, NULL);
>  	pm_runtime_mark_last_busy(mcspi->dev);
>  	pm_runtime_put_autosuspend(mcspi->dev);
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
