From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: core: Protect DMA code by #ifdef CONFIG_HAS_DMA
Date: Fri, 2 May 2014 23:09:18 +0200
Message-ID: <CAMuHMdW6kGfVq8y_HV7Aupa7jB9+qdtM4PYGGG54=aCi1AvRYg@mail.gmail.com>
References: <1399004974-19566-1-git-send-email-geert@linux-m68k.org>
	<20140502171411.GS3245@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140502171411.GS3245-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Fri, May 2, 2014 at 7:14 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, May 02, 2014 at 06:29:34AM +0200, Geert Uytterhoeven wrote:
>> If NO_DMA=y:
>>
>> drivers/built-in.o: In function `spi_map_buf':
>> spi.c:(.text+0x21bc60): undefined reference to `dma_map_sg'
>> drivers/built-in.o: In function `spi_unmap_buf.isra.33':
>> spi.c:(.text+0x21c32e): undefined reference to `dma_unmap_sg'
>> make[3]: *** [vmlinux] Error 1
>
> Ugh.  It would seem better to have these functions stubbed out.  But

As long as we have include/asm-generic/dma-mapping-broken.h,
it'll be like this...

> applied anyway.

Thanks!

BTW, I have a few more "depends on HAS_DMA" patches lying around for
drivers...

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
