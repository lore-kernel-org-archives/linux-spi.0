From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/2] eeprom: at25: SPI transfer improvements
Date: Wed, 23 Jan 2019 19:10:56 +0100
Message-ID: <CAMuHMdUWqcB7cTOenASWt6HXZhGsr9cH9B55Sh-+rmWmAkm4Fg@mail.gmail.com>
References: <20190118140525.29189-1-geert+renesas@glider.be> <20190118230740.44239fcf@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Nguyen An Hoan <na-hoan@jinso.co.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Boris Brezillon <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118230740.44239fcf@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

On Fri, Jan 18, 2019 at 11:07 PM Boris Brezillon <bbrezillon@kernel.org> wrote:
> On Fri, 18 Jan 2019 15:05:23 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > This patch series contains two improvements for the AT25 SPI EEPROM
> > driver, related to SPI transfers.
> >
> > Changes compared to v1:
> >   - Merge "off" and "offset" into a single variable instead of just
> >     killing the cast, as suggested by Arnd,
> >   - Add Acked-by,
> >   - Dropped "[PATCH 3/3] eeprom: at25: Split writes in two SPI transfers
> >     to optimize DMA", as this is better implemented in the SPI
> >     controller driver (cfr. e.g. "[v2 PATCH 2/2] spi: sh-msiof: Use DMA
> >     if possible",
> >     https://lore.kernel.org/linux-renesas-soc/1547803771-9564-2-git-send-email-na-hoan@jinso.co.jp/)
> >
> > Tested on a Renesas Ebisu development board with R-Car E3 using MSIOF
> > and a 25LC040 EEPROM.
>
> Did you consider converting this driver to spimem? Looks like the
> protocol used to communicate with the memory resembles the one used on
> SPI NANDs/NORs and fits pretty well in the spi_mem_op representation.

No, I hadn't considered doing that ;-)

> By doing this conversion you'd allow people to connect an AT25 EEPROM
> to an advanced SPI controller that does not support regular SPI
> transfers and you wouldn't have to forge SPI messages manually.
>
> Here is a patch (only compile tested) doing that. The diffstat is not in
> favor of this conversion, but I find the resulting code cleaner and more
> future proof.

Thanks, will give it a try, eventually...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
