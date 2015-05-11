From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: Add addr_width field to struct spi_message
Date: Mon, 11 May 2015 09:43:21 +0200
Message-ID: <CAMuHMdUakeDgLZ4hXe0DBu97Xx4eiC9K_Qfc-imkDBrDBXNs6A@mail.gmail.com>
References: <1431269253-22890-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431269253-22890-1-git-send-email-B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, May 10, 2015 at 4:47 PM, Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>
> Make SPI controller can get address width of the SPI device.

What does "address wdith" mean? From your other patches, I infer it's either
24 or 32 bit addressing as used by nor-jedec ("m25p80").
Why does the generic spi_message needs to have nor-jedec-specific fields?

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
