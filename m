From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: fsl-espi, m25p80 and max_transfer_size / max_message_size
Date: Fri, 23 Dec 2016 16:09:22 +0100
Message-ID: <fd8b7a96-7922-7f9f-6d90-660b4cb02fce@atmel.com>
References: <17913d2dea0200f818af5f42a0b2ed42@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mtd-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
        Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <17913d2dea0200f818af5f42a0b2ed42-QKn5cuLxLXY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi all,

Le 14/11/2016 à 15:22, Michael Walle a écrit :
> Hi,
> 
> since commit 02a595d5d6e4 (spi: fsl-espi: eliminate spi nor flash read
> loop) the fsl-espi is (partly?) broken. Reading 64k from the flash results
> in the following error:
>   fsl_espi ffe110000.spi: message too long, size is 65540 bytes
>   spi_master spi32766: failed to transfer one message from queue
> 
> We are using the m25p80 driver which checks the max_transfer_size. The
> fsl-espi driver sets the max_message_size to 64k. As far as I understand
> it, a message can contain multiple transfers. The m25p80 uses two transfers
> (one 4 byte and one with max_transfer_size, that is 64k) and thus the
> message has a total length of 65540 bytes which is too long for the driver.
> 
> I didn't find where the max_message_size is checked and I also don't know
> which part is resposible to handle the correct sizes. The m25p80 driver?
> Should it use spi_max_message_size() instead of spi_max_transfer_size() ?
> 
> For example:
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -172,7 +172,7 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t
> from, size_t len,
> 
>         t[1].rx_buf = buf;
>         t[1].rx_nbits = m25p80_rx_nbits(nor);
> -       t[1].len = min(len, spi_max_transfer_size(spi) - t[0].len);
> +       t[1].len = min(len, spi_max_message_size(spi) - t[0].len);
>         spi_message_add_tail(&t[1], &m);
> 

extracted from include/linux/spi/spi:h:

static inline size_t
spi_max_transfer_size(struct spi_device *spi)
{
	struct spi_master *master = spi->master;
	size_t tr_max = SIZE_MAX;
	size_t msg_max = spi_max_message_size(spi);

	if (master->max_transfer_size)
		tr_max = master->max_transfer_size(spi);

	/* transfer size limit must not be greater than messsage size limit */
	return min(tr_max, msg_max);
}

So replacing spi_max_transfer_size(spi) by spi_max_transfer_size(spi) is
not a good idea: the max transfer size is always lower than or equal to the
max message size.

However taking the min between:
1/ len
2/ spi_max_transfer_size(spi)
3/ spi_max_message_size(spi) - t[0].len /* the remaining msg size */

makes sense. Hence https://www.spinics.net/lists/linux-spi/msg08844.html
seems to be the right solution.

Best regards,

Cyrille


>         ret = spi_sync(spi, &m);
> 
> -michael
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
