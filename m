From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: propper support of 5 wire SPI (SPI_READY signal)
Date: Mon, 22 Feb 2016 10:21:32 +0100
Message-ID: <CAMuHMdW0P-uNBA94jvvVQqXH2c4DY45U4GnYufkPDQAqZm7u9g@mail.gmail.com>
References: <56C6DB9E.5080905@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56C6DB9E.5080905-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Oleksij,

On Fri, Feb 19, 2016 at 10:08 AM, Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org> wrote:
> i'm working on a project which depends on 5 Wire SPI communication. It
> is probably identical to spi-davinci.c with SPI_READY signal. Only
> difference is that SPI_READY is not supported by hardware, in this case
> GPIO input is used.

Sounds interesting!

> Currently this project implements SPI_READY and CS on top of spidev
> driver. What makes it really ugly, slow and complicated.

Can you please point me to some SPI slave hardware that supports this?

Thanks a lot!

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
