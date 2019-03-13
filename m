From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Applied "spi: work around clang bug in SPI_BPW_RANGE_MASK()" to
 the spi tree
Date: Wed, 13 Mar 2019 22:01:46 +0100
Message-ID: <CAK8P3a3UDhJLh9o1A-EEouP58L9H_uZO=e8L0JZsmGToQH0dAQ@mail.gmail.com>
References: <20190307155506.2993868-1-arnd@arndb.de> <20190311172421.275811128896@debutante.sirena.org.uk>
 <CAMuHMdXeuHwF2y1S=bpvQ_qXn+DYacUSS-uP2Zj9yKiHzghhqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXeuHwF2y1S=bpvQ_qXn+DYacUSS-uP2Zj9yKiHzghhqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 13, 2019 at 8:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > -#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
> > -#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
> > +#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)
>
> This is not correct: GENMASK() order is from msb to lsb.
> So it should it:
>
> +#define SPI_BPW_RANGE_MASK(min, max) GENMASK((max) - 1, (min) - 1)

Sorry about the mess, I've sent a fixup now.

       Arnd
