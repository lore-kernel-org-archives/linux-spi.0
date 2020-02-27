From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR capability
Date: Thu, 27 Feb 2020 18:03:00 +0100
Message-ID: <CAMuHMdV_1RfGFgDjJYzAnGd_x57zSwjZd8si=UTPp8ksgdwYGA@mail.gmail.com>
References: <20200226093703.19765-1-p.yadav@ti.com> <20200226093703.19765-2-p.yadav@ti.com>
 <20200227171147.32cc6fcf@collabora.com> <20200227162842.GE4062@sirena.org.uk>
 <CAMuHMdWMCDzQm0tjpybJZyHy4imbC9NqRXP5d4C0xgxQx-Pf8g@mail.gmail.com> <20200227164425.GF4062@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200227164425.GF4062-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Thu, Feb 27, 2020 at 5:44 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Feb 27, 2020 at 05:40:31PM +0100, Geert Uytterhoeven wrote:
> > On Thu, Feb 27, 2020 at 5:28 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > > It's what we do for other properties, and if this is anything like the
> > > other things adding extra wiring you can't assume that the ability to
> > > use the feature for TX implies RX.
>
> > Double Transfer Rate uses the same wire.
>
> But is it still on either the TX or RX signals?

E.g. good old Spansion S25FL512S supports single/dual/quad DDR, but
apparently only for read, not write.
Other FLASHes may support both directions. I guess.

> > But as you sample at both the rising and the falling edges of the clock, this
> > makes the cpha setting meaningless for such transfers, I think ;-)
>
> Might affect what the first bit is possibly?

Quoting the manual for the above part:

4.1.2
Double Data Rate (DDR)
Mode 0 and Mode 3 are also supported for DDR commands. In DDR
commands, the instruction bits are
always latched on the rising edge of clock, the same as in SDR
commands. However, the address and input
data that follow the instruction are latched on both the rising and
falling edges of SCK. The first address bit is
latched on the first rising edge of SCK following the falling edge at
the end of the last instruction bit. The first
bit of output data is driven on the falling edge at the end of the
last access latency (dummy) cycle.
SCK cycles are measured (counted) in the same way as in SDR commands,
from one falling edge of SCK to
the next falling edge of SCK. In mode 0 the beginning of the first SCK
cycle in a command is measured from
the falling edge of CS# to the first falling edge of SCK because SCK
is already low at the beginning of a
command.

> > However, as the future may bring us QDR, perhaps this should not be a
> > boolean flag, but an integer value?
> > Cfr. spi-tx-bus-width vs. the original spi-tx-dual/spi-tx-quad proposal.
>
> > What would be a good name (as we only need one)? spi-data-phases?
>
> Sounds reasonable, apart from the increasingly vague connection with
> something that's recognizably SPI :P

Yeah, especially Octal and Hyper modes are far from serial ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
