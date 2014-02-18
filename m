From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spi: Provide core support for full duplex devices
Date: Tue, 18 Feb 2014 10:59:09 +0100
Message-ID: <CAMuHMdWkPxp2U=Xz=wWu70RPxj+4GGCyifdPv=xL=47cz_upBw@mail.gmail.com>
References: <CAMuHMdUY+XEqKYh7mMOYUV18PpR+7SFw+BEUFh-9yL=H6reQkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUY+XEqKYh7mMOYUV18PpR+7SFw+BEUFh-9yL=H6reQkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Thu, Feb 6, 2014 at 1:56 PM, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> I found this in your for-next branch:
>
> commit 3a2eba9bd0a6447dfbc01635e4cd0689f5f2bdad
> Author: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Date:   Tue Jan 28 20:17:03 2014 +0000
>
>     spi: Provide core support for full duplex devices
>
> If I'm not mistaken, you forgot to email this out to linux-spi?
>
> I'll see whether I can make use of this in the RSPI driver.

I gave it a quick try, with RSPI single transfers.

For Dual/Quad transfers, which are half-duplex, the buffer pointer for the
unused direction must be NULL, so the driver knows in which direction to
transfer. Hence SPI_MASTER_MUST_TX cannot be set for Dual/Quad
capable SPI master.

I'm also worried about the buffer allocation. With m25p80 and mtchar, the
transfer buffer can be quite large (up to 4 MiB in my case), and this can be
triggered from userspace.

While mtdchar uses mtd_kmalloc_up_to(), and reduces the temporary
buffer size under memory pressure, the SPI core must always allocate a
buffer of the matching size. This may fail.

It's also a little bit slower (O(20 ms) for 1 MiB read), due to the overhead of
calling krealloc(), and zeroing the dummy buffer.

Alternatively, to avoid the memory allocation, you could zero rx_buf,
and use rx_buf for both tx and rx? That may break some DMA setups,
though.

Concluding, for PIO mode, I'm still in favor of using

    data = tx_buf ? *tx_buf++ : DUMMY_DATA;

in the SPI master driver itself.

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
