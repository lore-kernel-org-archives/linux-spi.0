From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi: work around clang bug in SPI_BPW_RANGE_MASK()
Date: Thu, 7 Mar 2019 14:22:59 +0100
Message-ID: <CAK8P3a1B7PakyYxT88v5Du+5CQZNCiA5xJ_Q4DtSSsGaM7FCnA@mail.gmail.com>
References: <20190307105619.2780591-1-arnd@arndb.de> <bc0e18db-9606-6f11-facf-2ca593118ef1@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bc0e18db-9606-6f11-facf-2ca593118ef1@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 7, 2019 at 2:09 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 07/03/2019 11.56, Arnd Bergmann wrote:
> > Clang-8 evaluates both sides of a ?: expression to check for
> > valid arithmetic even in the side that is never taken. This
> > results in a build warning:
> >
> > drivers/spi/spi-sh-msiof.c:1052:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> >         .bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32),
> >                               ^~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Change it to shift one less than we want, and then shift one
> > more bit afterwards. This should give the correct result for
> > all valid input, since it has to be in the range 1..32 anyway.
>
> Why not use GENMASK which is provided by the same header that #defines BIT?

It might be an options, but

- I had not thought of it
- It looks like it would have the same problem with shifting right by
32 bits (?)
- it seems to have slightly different semantics from SPI_BPW_RANGE_MASK(),
  counting the bits from 0 instead of 1.

I tried this version now, which doesn't produce any warnings as far as I can
tell, but I'm not convinced that it's actually correct. Can you have a look?

#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)

       Arnd
