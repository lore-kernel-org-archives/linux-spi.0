From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts
 to
Date: Mon, 30 Mar 2015 21:16:21 -0600
Message-ID: <551A1185.6060502@wwwdotorg.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/29/2015 08:03 AM, Martin Sperl wrote:
>  reduce interrupts/message
> 
> To reduce the number of interrupts/message we fill the FIFO before
> enabling interrupts - for short messages this reduces the interrupt count
> from 2 to 1 interrupt.
> 
> There have been rare cases where short (<200ns) chip-select switches with
> native CS have been observed during such operation, this is why this
> optimization is only enabled for GPIO-CS.

> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c

> +	/* fill in fifo if we have gpio-cs
> +	 * note that there have been rare events where the native-CS
> +	 * flapped for <1us which may change the behaviour
> +	 * with gpio-cs this does not happen, so it is implemented
> +	 * only for this case
> +	 */
> +	if (gpio_is_valid(spi->cs_gpio)) {
> +		/* enable HW block, but without interrupts enabled
> +		 * this would triggern an immediate interrupt
> +		 */
> +		bcm2835_wr(bs, BCM2835_SPI_CS,
> +			   cs | BCM2835_SPI_CS_TA);
> +		/* fill in tx fifo as much as possible */
> +		bcm2835_wr_fifo(bs);
> +	}

I can understand perfectly why the code fills the FIFO before enabling
interrupts; it avoids having to immediately service an interrupt simply
to fill the FIFO.

However, I'm not sure why this is in any way related to whether the
chip-select GPIO is valid. Surely we always want to do this? How does
the mechanism used to control chip selects influence whether we want to
pre-fill the FIFO?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
