From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Applied "spi: work around clang bug in SPI_BPW_RANGE_MASK()" to
 the spi tree
Date: Wed, 13 Mar 2019 20:15:18 +0100
Message-ID: <CAMuHMdXeuHwF2y1S=bpvQ_qXn+DYacUSS-uP2Zj9yKiHzghhqQ@mail.gmail.com>
References: <20190307155506.2993868-1-arnd@arndb.de> <20190311172421.275811128896@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311172421.275811128896@debutante.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Mon, Mar 11, 2019 at 6:26 PM Mark Brown <broonie@kernel.org> wrote:
> The patch
>
>    spi: work around clang bug in SPI_BPW_RANGE_MASK()
>
> has been applied to the spi tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> From eefffb42f6659c9510105f3e4ebf2a8499d56936 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 7 Mar 2019 16:54:21 +0100
> Subject: [PATCH] spi: work around clang bug in SPI_BPW_RANGE_MASK()
>
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
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/spi/spi.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 662b336aa2e4..b27386450089 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -444,8 +444,7 @@ struct spi_controller {
>         /* bitmask of supported bits_per_word for transfers */
>         u32                     bits_per_word_mask;
>  #define SPI_BPW_MASK(bits) BIT((bits) - 1)
> -#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
> -#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
> +#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)

This is not correct: GENMASK() order is from msb to lsb.
So it should it:

+#define SPI_BPW_RANGE_MASK(min, max) GENMASK((max) - 1, (min) - 1)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
