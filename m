From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] eeprom: at25: Split writes in two SPI transfers to
 optimize DMA
Date: Thu, 11 Oct 2018 08:59:13 +0200
Message-ID: <CAMuHMdVUGW06O9ugzJQh4h5v=Gmf_7byvKPutB=YdQWyWcgN_w@mail.gmail.com>
References: <20181010134036.8296-1-geert+renesas@glider.be>
 <20181010134036.8296-4-geert+renesas@glider.be> <1539208063.1944.12.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd@vger.kernel.org
To: Trent Piepho <tpiepho@impinj.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539208063.1944.12.camel@impinj.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Trent,

On Wed, Oct 10, 2018 at 11:47 PM Trent Piepho <tpiepho@impinj.com> wrote:
> On Wed, 2018-10-10 at 15:40 +0200, Geert Uytterhoeven wrote:
> > Currently EEPROM writes are implemented using a single SPI transfer,
> > which contains all of command, address, and payload data bytes.
> > As some SPI controllers impose limitations on transfers with respect to
> > the use of DMA, they may have to fall back to PIO. E.g. DMA may require
> > the transfer length to be a multiple of 4 bytes.
> >
> > Optimize writes for DMA by splitting writes in two SPI transfers:
> >   - The first transfer contains command and address bytes,
> >   - The second transfer contains the actual payload data, now stored at
> >     the start of the (kmalloc() aligned) buffer, to improve payload
> >     alignment.
>
> Does this always optimize?  A master capable of an of aligned 18 byte
> DMA xfer would now have a 2 byte xfer that would probably be PIO
> followed by a 16 byte DMA.
>
> Or writing 14 bytes to the EEPROM has changed from an aligned 16 byte
> write to a 2 byte and a 14 byte, which is now worse for the 4 byte
> multiple requirement master which can use any DMA anymore.

That's correct. I did consider this case.
However, with the small page sizes used (16, 64, or 256 bytes), I'd expect
EEPROM users to consider them for their data formats, and thus it IMHO
makes sense to optimize for the optimal case, which is currently not the
case.

Note there may be 1, 2, or 3 address bytes, so it can be a total of 2 + len
or 3 + len bytes, too.

> It seems like an enhancement to the DMA code to look more like a
> efficient memcpy() that aligns the address, then xfers efficient
> blocks, then finishes the sub-block tail would be more generally
> applicable.
>
> Or more simply, given an aligned 18 byte xfer, the driver should do an
> aligned 16 byte DMA and then two more bytes.

That's another option, but that probably needs changes in several drivers,
and/or the SPI core (if we want to handle it there).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
