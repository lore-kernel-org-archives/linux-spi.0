From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/5] spi: Check that Quad/Dual is half duplex
Date: Tue, 21 Jan 2014 21:06:57 +0100
Message-ID: <CAMuHMdWW1EsHe0u0o8XZuG4AzPKRqKL7ET5Ac2NkbeLRfW_foQ@mail.gmail.com>
References: <1390317009-8292-1-git-send-email-geert@linux-m68k.org>
	<1390317009-8292-4-git-send-email-geert@linux-m68k.org>
	<20140121182130.GM17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140121182130.GM17314@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 21, 2014 at 7:21 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jan 21, 2014 at 04:10:08PM +0100, Geert Uytterhoeven wrote:
>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>> Quad and Dual SPI Transfers use all available data lines (incl. MOSI/MISO),
>> hence they must be half duplex. Add a check that verify that.
>
> This is surprising to me - I had expected that there would be extra
> signals that would be used for these modes, not that the opposite
> direction data line would be one of the ones being reused.  On the other
> hand if this is what all the flash chips do then it would seem
> reasonable that controllers do the same.  Can you clarify please?

Dual SPI works by aggregating the MOSI and MISO lines for 2-bit
unidirectional transfers.
Quad SPI aggregates MOSI, MISO, and 2 additional lines for 4-bit
unidirectional transfers.

Hence Dual SPI uses the traditional 4-wire wiring, while Quad SPI uses
6-wire.

SPI FLASH chips handle it this way, and the Renesas QSPI controller
in the r8a7790/7791 SoCs, too.

Typically the first transfer in a message is a Single Transfer (e.g. read data
command), while subsequent transfers can be Dual or Quad Transfers (e.g.
the actual data read from the FLASH).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
