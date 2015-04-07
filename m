From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: transform native-cs to gpio-cs on first
 spi_setup
Date: Mon, 06 Apr 2015 21:01:15 -0600
Message-ID: <5523487B.70501@wwwdotorg.org>
References: <1428340592-3196-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428340592-3196-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04/06/2015 11:16 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> 
> Transforms the bcm-2835 native SPI-chip select to their gpio-cs equivalent.
> 
> This allows for some support of some optimizations that are not
> possible due to HW-gliches on the CS line - especially filling
> the FIFO before enabling SPI interrupts (by writing to CS register)
> while the transfer is already in progress (See commit: e3a2be3030e2)
> 
> This patch also works arround some issues in bcm2835-pinctrl which does not
> set the value when setting the GPIO as output - it just sets up output and
> (typically) leaves the GPIO as low.  When a fix for this is merged then this
> gpio_set_value can get removed from bcm2835_spi_setup.

> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c

> @@ -360,13 +367,45 @@ static int bcm2835_spi_setup(struct spi_device *spi)
>  		return 0;
>  	if (gpio_is_valid(spi->cs_gpio))
>  		return 0;
> -	if (spi->chip_select < 3)
> +	if (spi->chip_select > 1) {
> +		/* error in the case of native CS requested with CS > 1
> +		 * officially there is a CS2, but it is not documented
> +		 * which GPIO is connected with that...
> +		 */
> +		dev_err(&spi->dev,
> +			"setup: only two native chip-selects are supported\n");

I believe the bcm283x have 2 types of SPI controller. There is 1
instance of the HW that this driver controls (SPI0), and that has CS0,
CS1. There are two instances of a different SPI HW block (SPI1, SPI2),
and those each have CS0, CS1, CS2. At least, that's my interpretation of
the table that shows the pinctrl module's per-pin alternate function values.

> +		return -EINVAL;
> +	}
> +	/* now translate native cs to GPIO */
> +
> +	/* get the gpio chip for the base */
> +	chip = gpiochip_find("pinctrl-bcm2835", chip_match_name);
> +	if (!chip)
>  		return 0;

Should that be an error? Not being able to find the gpiochip implies the
code can't manipulate the CS lines at all, I think?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
