From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] [v3] spi: work around clang bug in SPI_BPW_RANGE_MASK()
Date: Mon, 11 Mar 2019 10:11:19 +0100
Message-ID: <CAMuHMdWv3On3w9hqJUZ7oKNHxphhNZNN8JhN4oUgfyvu7C9XRg@mail.gmail.com>
References: <20190307155506.2993868-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307155506.2993868-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Arnd,

On Thu, Mar 7, 2019 at 4:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Clang-8 evaluates both sides of a ?: expression to check for
> valid arithmetic even in the side that is never taken. This
> results in a build warning:
>
> drivers/spi/spi-sh-msiof.c:1052:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>         .bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32),
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Change the implementation to use the GENMASK() macro that does
> what we want here but does not have a problem with the shift
> count overflow.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -444,8 +444,7 @@ struct spi_controller {
>         /* bitmask of supported bits_per_word for transfers */
>         u32                     bits_per_word_mask;
>  #define SPI_BPW_MASK(bits) BIT((bits) - 1)
> -#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
> -#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
> +#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)

Shouldn't that be GENMASK((max) - 1, (min) - 1)?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
