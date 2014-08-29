From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2] spi/drivers: Restrict COMPILE_TEST by HAS_DMA where needed
Date: Fri, 29 Aug 2014 21:13:24 +0200
Message-ID: <CAMuHMdW3RBxXNrfK=2d_uHCesE+NaLFheGgdBEP7JuPcd8Xd1Q@mail.gmail.com>
References: <1409328631-1420-1-git-send-email-geert@linux-m68k.org>
	<20140829173752.GX29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140829173752.GX29327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Fri, Aug 29, 2014 at 7:37 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Aug 29, 2014 at 06:10:31PM +0200, Geert Uytterhoeven wrote:
>> commit dd1053a93fdc11d4 ("spi/drivers: Enable build of drivers with
>> COMPILE_TEST") allows compile-testing drivers on platforms they're not
>> meant for.
>
>> However, adding "|| COMPILE_TEST" bypasses all other implicit dependencies
>> assumed by the platform dependencies before, like HAS_DMA.
>
> I'm wondering if it isn't better to have the non-DMA platforms define
> stub (always error) DMA functions instead - it's less error prone and
> with SPI there's a bunch of drivers which can run perfectly usefully
> without DMA while optionally supporting DMA.

The SPI problem will sort itself out once all SPI master drivers have been
converted to use the SPI DMA core ;-)

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
