From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: omap2: use SUPERH, not SH
Date: Sat, 8 Feb 2014 22:19:21 +0100
Message-ID: <CAMuHMdXV3N5ReDDkp2PEfF0sOFJxQw0pECBGgWmrg9Ex6YE-LQ@mail.gmail.com>
References: <1391893281.19595.3.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391893281.19595.3.camel@x220>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Feb 8, 2014 at 10:01 PM, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org> wrote:
> Commit 0079aae0f1e6 ("spi: omap2: Add build dependencies for
> writel_relaxed()") added an optional Kconfig dependency on SH. That
> Kconfig symbol doesn't exist. Apparently SUPERH was intended. Use that.
>
> Signed-off-by: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>

Nice catch!

Acked-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

BTW, MICROBLAZE can be added as well. It got writel_relaxed() in
v3.14-rc1.

> ---
> Basically untested.
>
>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ba9310b..205dbfe 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -307,7 +307,7 @@ config SPI_OMAP_UWIRE
>
>  config SPI_OMAP24XX
>         tristate "McSPI driver for OMAP"
> -       depends on ARM || ARM64 || AVR32 || HEXAGON || MIPS || SH
> +       depends on ARM || ARM64 || AVR32 || HEXAGON || MIPS || SUPERH
>         depends on ARCH_OMAP2PLUS || COMPILE_TEST
>         help
>           SPI master controller for OMAP24XX and later Multichannel SPI

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
