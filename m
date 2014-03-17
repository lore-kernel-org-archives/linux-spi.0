From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH RFC] spi: core: Use master->max_speed_hz as transfer speed
 when xfer->speed_hz > master->max_speed_hz
Date: Sun, 16 Mar 2014 20:54:19 -0700
Message-ID: <532671EB.3010502@roeck-us.net>
References: <1395022092.30299.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395022092.30299.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/16/2014 07:08 PM, Axel Lin wrote:
> When xfer->speed_hz is greater than master->max_speed_hz, it's generally safe
> to use master->max_speed_hz as transfer speed.
> Thus use master->max_speed_hz as transfer speed rather than return error when
> xfer->speed_hz > master->max_speed_hz.
>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Tested-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Reviewed-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Guenter

> ---
> Hi Guenter,
> Does this patch fix the issue you encounter?
> Regards,
> Axel
>   drivers/spi/spi.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 454a523..26b331d 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1844,12 +1844,13 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
>   		message->frame_length += xfer->len;
>   		if (!xfer->bits_per_word)
>   			xfer->bits_per_word = spi->bits_per_word;
> -		if (!xfer->speed_hz) {
> +
> +		if (!xfer->speed_hz)
>   			xfer->speed_hz = spi->max_speed_hz;
> -			if (master->max_speed_hz &&
> -			    xfer->speed_hz > master->max_speed_hz)
> -				xfer->speed_hz = master->max_speed_hz;
> -		}
> +
> +		if (master->max_speed_hz &&
> +		    xfer->speed_hz > master->max_speed_hz)
> +			xfer->speed_hz = master->max_speed_hz;
>
>   		if (master->bits_per_word_mask) {
>   			/* Only 32 bits fit in the mask */
> @@ -1878,9 +1879,6 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
>   		if (xfer->speed_hz && master->min_speed_hz &&
>   		    xfer->speed_hz < master->min_speed_hz)
>   			return -EINVAL;
> -		if (xfer->speed_hz && master->max_speed_hz &&
> -		    xfer->speed_hz > master->max_speed_hz)
> -			return -EINVAL;
>
>   		if (xfer->tx_buf && !xfer->tx_nbits)
>   			xfer->tx_nbits = SPI_NBITS_SINGLE;
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
