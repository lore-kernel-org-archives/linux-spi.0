From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] spi: work around clang bug in SPI_BPW_RANGE_MASK()
Date: Thu, 7 Mar 2019 14:09:25 +0100
Message-ID: <bc0e18db-9606-6f11-facf-2ca593118ef1@rasmusvillemoes.dk>
References: <20190307105619.2780591-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307105619.2780591-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/03/2019 11.56, Arnd Bergmann wrote:
> Clang-8 evaluates both sides of a ?: expression to check for
> valid arithmetic even in the side that is never taken. This
> results in a build warning:
> 
> drivers/spi/spi-sh-msiof.c:1052:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>         .bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32),
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change it to shift one less than we want, and then shift one
> more bit afterwards. This should give the correct result for
> all valid input, since it has to be in the range 1..32 anyway.

Why not use GENMASK which is provided by the same header that #defines BIT?

Rasmus
