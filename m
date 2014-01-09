From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: m25p80 quad support questions
Date: Thu, 9 Jan 2014 15:44:51 +0100
Message-ID: <CAMuHMdU7Mj4uqZkYYRsLXqZP0w6cv+y1L4XZJ9j5c8722H6JnQ@mail.gmail.com>
References: <CAMuHMdXWZU=i9hY_p-oAVHhBskgcbZazLKi8QMLQ+p+t9opyMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXWZU=i9hY_p-oAVHhBskgcbZazLKi8QMLQ+p+t9opyMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

CC linux-spi, and more information below.

On Thu, Jan 9, 2014 at 10:12 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Hi Sourav, Brian,
>
> I'm working on adding QSPI support to a SPI master driver, so I'm very
> interested in your work to add quad read support to m25p80.
> Thanks for that!
>
> However, I have a few questions/comments:
>
> 1. Up to version 2 of "drivers: mtd: m25p80: Add quad read support",
> the driver set rx_nbits to indicate it wants to use Quad SPI transfers:
>
> + t[1].rx_nbits = flash->quad_read ? SPI_NBITS_QUAD : 1;
>
> (http://patchwork.ozlabs.org/patch/286109/).
>
> However, this is not present in later versions, nor in the current version
> in -next.
>
> It's my understanding the default (single transfer mode) will be used if
> rx_nbits is zero, cfr. drivers/spi/spi.c:__spi_async():
>
>                 if (xfer->tx_buf && !xfer->tx_nbits)
>                         xfer->tx_nbits = SPI_NBITS_SINGLE;
>                 if (xfer->rx_buf && !xfer->rx_nbits)
>                         xfer->rx_nbits = SPI_NBITS_SINGLE;
>
> Does it really use quad transfers without setting rx_nbits to SPI_NBITS_QUAD?

I can confirm that the SPI master driver is called with rx_nbits == 1, while
using the 0x6b QOR command.

> 2. IMHO checking for Quad support in the SPI master (master->mode_bits)
> and in the SPI FLASH chip is not sufficient. A quad-capable SPI FLASH
> may be wired to a quad-capable SPI master using 4-wire mode, either
> physically or through pin control.
> So I think we need a m25p,quad-read property in DT.

Sorry, this issue is moot. I missed that spi_device.mode (as set from DT
spi-rx-bus-width and spi-tx-bus-width) is also taken into account.

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
