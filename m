From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/4] mtd: m25p80: Set rx_nbits for Quad SPI transfers
Date: Tue, 21 Jan 2014 16:18:44 +0100
Message-ID: <201401211618.44103.marex@denx.de>
References: <1390309159-19643-1-git-send-email-geert@linux-m68k.org> <1390309159-19643-3-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390309159-19643-3-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, January 21, 2014 at 01:59:17 PM, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> 
> When using the Quad Read opcode, SPI masters still use Single SPI
> transfers, as spi_transfer.rx_nbits defaults to SPI_NBITS_SINGLE.
> Use SPI_NBITS_QUAD to fix this.
> 
> While an earlier version of commit 3487a63955c34ea508bcf4ca5131ddd953876e2d
> ("drivers: mtd: m25p80: add quad read support") did this correctly, it was
> forgotten in the version that got merged.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> ---
>  drivers/mtd/devices/m25p80.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 320c6a308630..ad1913909702 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -489,6 +489,16 @@ static inline int m25p80_dummy_cycles_read(struct m25p
> *flash) }
>  }
> 
> +static inline unsigned int m25p80_rx_nbits(const struct m25p *flash)
> +{
> +	switch (flash->flash_read) {
> +	case M25P80_QUAD:
> +		return 4;
> +	default:
> +		return 0;
> +	}
> +}
> +
>  /*
>   * Read an address range from the flash chip.  The address range
>   * may be any size provided it is within the physical boundaries.
> @@ -519,6 +529,7 @@ static int m25p80_read(struct mtd_info *mtd, loff_t
> from, size_t len, spi_message_add_tail(&t[0], &m);
> 
>  	t[1].rx_buf = buf;
> +	t[1].rx_nbits = m25p80_rx_nbits(flash);
>  	t[1].len = len;
>  	spi_message_add_tail(&t[1], &m);

Indeed.

Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
