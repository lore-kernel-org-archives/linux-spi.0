From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/2] eeprom: at25: SPI transfer improvements
Date: Tue, 29 Jan 2019 20:02:37 +0100
Message-ID: <CAMuHMdVfVHUQnjwvFikqQJ8HBD+0A7DSCTcdDN4e7V4c=4Usug@mail.gmail.com>
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
> Did you consider converting this driver to spimem? Looks like the
> protocol used to communicate with the memory resembles the one used on
> SPI NANDs/NORs and fits pretty well in the spi_mem_op representation.
>
> By doing this conversion you'd allow people to connect an AT25 EEPROM
> to an advanced SPI controller that does not support regular SPI
> transfers and you wouldn't have to forge SPI messages manually.
>
> Here is a patch (only compile tested) doing that. The diffstat is not in
> favor of this conversion, but I find the resulting code cleaner and more
> future proof.

Thanks, seems to work fine, with the 512-byte 25LC040 I have!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

I did notice that the first two-byte transfer (command+offset) of each
message is now split in two one-byte transfers, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
