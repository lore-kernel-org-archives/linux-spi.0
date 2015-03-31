From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 4/6] spi: bcm2835: warn about native-chip-selects being
 used
Date: Mon, 30 Mar 2015 21:23:01 -0600
Message-ID: <551A1315.8010600@wwwdotorg.org>
References: <0330B85B-A297-482B-80A9-E01F236D33D2@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0330B85B-A297-482B-80A9-E01F236D33D2-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/29/2015 08:03 AM, Martin Sperl wrote:
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> Tested-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

It would be useful to have a commit description saying why such a
warning was useful.

> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c

> @@ -82,6 +82,7 @@ struct bcm2835_spi {
>  	u8 *rx_buf;
>  	int tx_len;
>  	int rx_len;
> +	bool native_cs_use_warning_done;
>  };
...
> @@ -294,6 +298,14 @@ static int bcm2835_spi_setup(struct spi_device *spi)
...
> +	/* we are in the native chipselect case now,
> +	 * so warn about the fact that some things may not work as well

What things and why? (I'm asking mainly because that should be in the
commit description and perhaps this comment).

> +	 */
> +	if (!bs->native_cs_use_warning_done) {
> +		dev_warn(&spi->dev,
> +			 "setup: native chipselect is used - some driver functions/optimizations are not applied\n");
> +		bs->native_cs_use_warning_done = 1;
> +	}

Isn't there a warn_once() that would remove the need to check/set
native_cs_use_warning_done?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
