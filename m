From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v3 3/8] spi: core: add spi_split_transfers_maxsize
Date: Tue, 16 Feb 2016 09:52:07 +0100
Message-ID: <CAMuHMdVX6BUJZHA0xUYVe50bZMP4eKdFb4=TSfQMvA=5GDVv5A@mail.gmail.com>
References: <1450106426-2277-1-git-send-email-kernel@martin.sperl.org>
	<1450106426-2277-4-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450106426-2277-4-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Dec 14, 2015 at 4:20 PM,  <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
> +int __spi_split_transfer_maxsize(struct spi_master *master,
> +                                struct spi_message *msg,
> +                                struct spi_transfer **xferp,
> +                                size_t maxsize,
> +                                gfp_t gfp)
> +{
> +       struct spi_transfer *xfer = *xferp, *xfers;
> +       struct spi_replaced_transfers *srt;
> +       size_t offset;
> +       size_t count, i;
> +
> +       /* warn once about this fact that we are splitting a transfer */
> +       dev_warn_once(&msg->spi->dev,
> +                     "spi_transfer of length %i exceed max length of %i - needed to split transfers\n",

On arm64:

drivers/spi/spi.c:2278:2: warning: format '%i' expects argument of
type 'int', but argument 4 has type 'size_t' [-Wformat=]
  dev_warn_once(&msg->spi->dev,

%u ... %zu


> +                     xfer->len, maxsize);
> +
> +       /* calculate how many we have to replace */
> +       count = DIV_ROUND_UP(xfer->len, maxsize);
> +
> +       /* create replacement */
> +       srt = spi_replace_transfers(msg, xfer, 1, count, NULL, 0, gfp);
> +       if (!srt)
> +               return -ENOMEM;
> +       xfers = srt->inserted_transfers;
> +
> +       /* now handle each of those newly inserted spi_transfers
> +        * note that the replacements spi_transfers all are preset
> +        * to the same values as *xferp, so tx_buf, rx_buf and len
> +        * are all identical (as well as most others)
> +        * so we just have to fix up len and the pointers.
> +        *
> +        * this also includes support for the depreciated
> +        * spi_message.is_dma_mapped interface
> +        */
> +
> +       /* the first transfer just needs the length modified, so we
> +        * run it outside the loop
> +        */
> +       xfers[0].len = min(maxsize, xfer[0].len);
> +
> +       /* all the others need rx_buf/tx_buf also set */
> +       for (i = 1, offset = maxsize; i < count; offset += maxsize, i++) {
> +               /* update rx_buf, tx_buf and dma */
> +               if (xfers[i].rx_buf)
> +                       xfers[i].rx_buf += offset;
> +               if (xfers[i].rx_dma)
> +                       xfers[i].rx_dma += offset;
> +               if (xfers[i].tx_buf)
> +                       xfers[i].tx_buf += offset;
> +               if (xfers[i].tx_dma)
> +                       xfers[i].tx_dma += offset;
> +
> +               /* update length */
> +               xfers[i].len = min(maxsize, xfers[i].len - offset);

On arm64:

drivers/spi/spi.c:2304:113: warning: comparison of distinct pointer
types lacks a cast

> +       }

Does it make sense that maxsize is size_t (32 or 64 bit), while
spi_transfer.len is
unsigned int (always 32 bit)?

I see this is coming from spi_master.max_dma_len, which is also size_t.

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
