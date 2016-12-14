From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: SPI_FSL_DSPI should depend on HAS_DMA
Date: Wed, 14 Dec 2016 15:40:43 +0100
Message-ID: <CAMuHMdU6PGUrmMOKFH9AFwK7j-eyThVaofS0jKN=HiL0WupJEA@mail.gmail.com>
References: <1481718485-6966-1-git-send-email-geert@linux-m68k.org> <20161214143713.3kl34okpr5vnuyc6@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161214143713.3kl34okpr5vnuyc6-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Wed, Dec 14, 2016 at 3:37 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Dec 14, 2016 at 01:28:05PM +0100, Geert Uytterhoeven wrote:
>> If NO_DMA=y:
>
>>     ERROR: "bad_dma_ops" [drivers/spi/spi-fsl-dspi.ko] undefined!
>
>> Add a dependency on HAS_DMA to fix this.
>
> Honestly I think we should just fix the architectures that don't support
> DMA to provide compile out stubs for DMA, it seems like these
> dependencies are more trouble than they're worth.

Will that really help?

Then people will start adding "depends on HAS_DMA || COMPILE_TEST"
instead...

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
