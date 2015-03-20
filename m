From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] SPI: BCM2835: enable support of 3-wire mode
Date: Thu, 19 Mar 2015 23:12:41 -0600
Message-ID: <550BAC49.3000105@wwwdotorg.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-4-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426755714-28130-4-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/19/2015 03:01 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c

> @@ -201,6 +202,9 @@ static int bcm2835_spi_start_transfer(
>  		cdiv = 0; /* 0 is the slowest we can go */
>  	}
>  
> +	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf))
> +		cs |= BCM2835_SPI_CS_REN;
> +

I can see how that tells the HW which direction to transfer data in
3WIRE mode, but how does the HW know whether it's in 3WIRE mode or has
separate RX/TX lines?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
