From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 09/18] spi: rspi: SPI DMA core needs both RX and TX DMA to function
Date: Mon, 2 Jun 2014 16:55:14 +0200
Message-ID: <CAMuHMdXra=NjAy6WuQBf1Rm3iHv8J2qYubTpq3scxGq8+wK_tg@mail.gmail.com>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
	<1401716301-29612-10-git-send-email-geert+renesas@glider.be>
	<20140602144221.GI31751@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140602144221.GI31751@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Mon, Jun 2, 2014 at 4:42 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 02, 2014 at 03:38:11PM +0200, Geert Uytterhoeven wrote:
>> The SPI DMA core framework needs both RX and TX DMA to function.  As a
>> preparation for converting the driver to use this framework, fall back to
>> PIO if no DMA channel or only one DMA channel is available.
>
>> This affects only RSPI, which could do DMA transfers for TX-only before.

Perhaps my wording was not so clear: "could do DMA transfers for TX-only"
does not mean "could only do DMA transfers for TX (and not RX)".

>> RSPI-RZ and QSPI (at least for Single SPI Transfers) will need both RX and
>> TX DMA anyway.
>
> Hrm, was this error handling or is it a hardware limitation that it can
> only do DMA in one direction?  Perhaps the core ought to be changed to
> support that if it's a hardware limit, I honestly hadn't considered that
> possibility when I wrote the code.

So it's not a hardware limitation, but a software optimization ;-)
If there's no data to receive, RSPI on SH can do transmit only.
If there's data to receive, it must do both transmit and receive.

Later RSPI variants cannot do TX-only, they always do both transmit and
receive (except for Dual/Quad, which are unidirectional by design).

Hence if only one DMA channel is available, RSPI on SH could still do DMA TX
before. I don't know whether anyone ever used this, as there were no in-tree
users of RSPI DMA.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
