From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/2] spi: sh-msiof: Add DT support to DMA setup
Date: Fri, 20 Jun 2014 15:18:31 +0200
Message-ID: <CAMuHMdV97sXuS6JyPTwgv7i73F4fupQkamAyuQfG78SrihoiKQ@mail.gmail.com>
References: <1403259638-13774-1-git-send-email-geert+renesas@glider.be>
	<1403259638-13774-2-git-send-email-geert+renesas@glider.be>
	<20140620125259.GL30188@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Mark Brown <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140620125259.GL30188@leverpostej>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, Jun 20, 2014 at 2:52 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jun 20, 2014 at 11:20:37AM +0100, Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> The format of the DMA specifiers depends on the DT bindings for SHDMA,
>> which are still under development.
>>
>>  Documentation/devicetree/bindings/spi/sh-msiof.txt | 17 +++++++++++++--
>>  drivers/spi/spi-sh-msiof.c                         | 25 ++++++++++++++++------
>>  2 files changed, 33 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
>> index f24baf3b6cc1..fc56e312c0bc 100644
>> --- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
>> +++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
>> @@ -7,7 +7,13 @@ Required properties:
>>                        Examples with soctypes are:
>>                        "renesas,msiof-r8a7790" (R-Car H2)
>>                        "renesas,msiof-r8a7791" (R-Car M2)
>> -- reg                  : Offset and length of the register set for the device
>> +- reg                  : A list of offsets and lengths of the register sets for
>> +                      the device.
>> +                      If only one register set is present, it is to be used
>> +                      by both the CPU and the DMA engine.
>> +                      If two register sets are present, the first is to be
>> +                      used by the CPU, and the second is to be used by the
>> +                      DMA engine.
>
> I'm missing something here. I'm we're providing the DMA engines through
> DMA specifiers below, then why do we need the DMA engine address here?
> Surely they're separate device nodes?

It's not the DMA engine address, but the second bank of MSIOF addresses.

The MSIOF has two (identical) sets of register banks: the first one is to
be accessed by the CPU, the second one (actually only the Transmit FIFO
and Receive FIFO Data Registers) is to be accessed by the DMA engine.

> The code update doesn't seem to do anything with the additional reg
> entry.

Indeed, as the second bank of registers is already used by spi-sh-msiof.c
for the non-DT DMA case. Register banks are resources, so they're
already present in non-DT platform devices.

Thanks for your questions!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
