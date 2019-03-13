From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: fix SPI_BPW_RANGE_MASK() regression
Date: Wed, 13 Mar 2019 22:59:33 +0100
Message-ID: <CAMuHMdUBZRxE-E8T03C85B5-UeM+ofLSbZhyRKWHrcmQksQvag@mail.gmail.com>
References: <20190313210118.3507256-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313210118.3507256-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 13, 2019 at 10:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Geert points out that I confused the min/max arguments that are
> reversed between SPI_BPW_RANGE_MASK() and GENMASK(). This time
> I have verified the result of the macro after fixing the arguments.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: eefffb42f665 ("spi: work around clang bug in SPI_BPW_RANGE_MASK()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
