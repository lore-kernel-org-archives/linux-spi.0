From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] SPI: control CS via standard GPIO operations instead
 of SPI-HW
Date: Fri, 06 Mar 2015 22:38:00 -0700
Message-ID: <54FA8EB8.9090102@wwwdotorg.org>
References: <1425487205-5477-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425487205-5477-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/04/2015 09:40 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> 
> Allow the cs-gpios property in DT to be used instead of the
> fixed two chip-selects provided by the SPI-HW itself
> 
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> 
> ---
> 
> There is the question if we still need to support the chip_selects
> provided by the hardware (plus the buggy CSPOL_HIGH support for those cases)
> or if we could just make the cs-gpios a required setting for this driver.
> Going with the GPIO only solution would clean up the code a bit.

Yes, I believe so. Any existing DT file needs to continue working with a
new kernel; DT is an ABI.

BTW, you forgot to Cc the SPI maintainer, so he probably won't see your
patch and apply it.

I assume that the SPI core parses the cs-gpios property from DT, hence
why this patch doesn't add any DT parsing, and doesn't modify any DT
bindings?

> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c

> @@ -205,12 +219,24 @@ static int bcm2835_spi_start_transfer(struct spi_device *spi,
>  		cs |= BCM2835_SPI_CS_CPHA;
>  
>  	if (!(spi->mode & SPI_NO_CS)) {
> -		if (spi->mode & SPI_CS_HIGH) {
> -			cs |= BCM2835_SPI_CS_CSPOL;
> -			cs |= BCM2835_SPI_CS_CSPOL0 << spi->chip_select;
> -		}
> +		if (spi->cs_gpio >= 0)
> +			bcm2835_set_cs(spi, 1);
> +		else {
> +			/* do we need to support this ?

As mentioned above, yes I believe so. You'd need to amend this comment
to remove the question, I suspect.

This patch looks OK with that change made.

> +			 * note that there is a bug in this when there are
> +			 * multiple devices on the bus with at least one
> +			 * having SPI_CS_HIGH set (the other CS_CSPOLX get
> +			 * reset to 0 when any other device
> +			 * starts a transfer
> +			 */
> +			if (spi->mode & SPI_CS_HIGH) {
> +				cs |= BCM2835_SPI_CS_CSPOL;
> +				cs |= BCM2835_SPI_CS_CSPOL0
> +					<< spi->chip_select;
> +			}
>  
> -		cs |= spi->chip_select;
> +			cs |= spi->chip_select;
> +		}
>  	}

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
