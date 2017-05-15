From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: SPI_TI_QSPI should depend on HAS_DMA
Date: Mon, 15 May 2017 10:46:15 +0200
Message-ID: <CAMuHMdUOMk9zpaVS9gj=jC5Cy2WFpj50+ut5TG=T69mYjMZ7hQ@mail.gmail.com>
References: <1493883438-19462-1-git-send-email-geert@linux-m68k.org> <20170514095020.roqoeohylvrgoad7@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170514095020.roqoeohylvrgoad7-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Sun, May 14, 2017 at 11:50 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, May 04, 2017 at 09:37:18AM +0200, Geert Uytterhoeven wrote:
>> If NO_DMA=y:
>>
>>     ERROR: "bad_dma_ops" [drivers/spi/spi-ti-qspi.ko] undefined!
>>
>> Add a dependency on HAS_DMA to fix this.
>
> There's no progress on fixing the architectures that don't do DMA to
> stub it out?  :(

Then it has to become "depends on HAS_DMA || COMPILE_TEST"?

Even more typing work for me ;-)

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
