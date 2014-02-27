From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: coldfire-qspi: Fix bits per word setting when t->bits_per_word
 is not set
Date: Thu, 27 Feb 2014 10:09:59 -0700
Message-ID: <530F7167.7000307@wwwdotorg.org>
References: <1393463102.12945.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393463102.12945.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/26/2014 06:05 PM, Axel Lin wrote:
> This ensures to use spi_device's bits_per_word setting when t->bits_per_word is
> not set. This looks like a bug introduced by commit 24778be20f8
> "spi: convert drivers to use bits_per_word_mask".

I thought the SPI core already contained this kind of logic, so that
drivers could rely on t->bits_per_word always being set up? Yes, this:

> static int __spi_validate(struct spi_device *spi, struct spi_message *message)
...
>         /**
>          * Set transfer bits_per_word and max speed as spi device default if
>          * it is not set for this transfer.
>          * Set transfer tx_nbits and rx_nbits as single transfer default
>          * (SPI_NBITS_SINGLE) if it is not set for this transfer.
>          */
>         list_for_each_entry(xfer, &message->transfers, transfer_list) {
>                 message->frame_length += xfer->len;
>                 if (!xfer->bits_per_word)
>                         xfer->bits_per_word = spi->bits_per_word;

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
