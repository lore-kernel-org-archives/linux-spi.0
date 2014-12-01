From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH][RFC] spi: sh-msiof: Configure MSIOF sync signal timing in
 device tree
Date: Mon, 1 Dec 2014 09:26:49 +0100
Message-ID: <CAMuHMdVHJqzMhY28Cb65tzB0E2X8YW_moeJkWGaWYaUQUBhU7w@mail.gmail.com>
References: <5477EFD7.50307@renesas.com>
	<3485316.4muPRcz2if@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3485316.4muPRcz2if@avalon>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Shimoda-san, Laurent,

On Sun, Nov 30, 2014 at 9:23 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> On Friday 28 November 2014 12:45:27 Yoshihiro Shimoda wrote:
>> The MSIOF controller has DTDL and SYNCDL in SITMDR1 and SIRMDR1
>> registers. So, this patch adds new properties like the following
>> commit:
>>   d0fb47a5237d8b9576113568bacfd27892308b62
>>   (spi: fsl-espi: Configure FSL eSPI CSBEF and CSAFT)
>>
>> The DTDL is the chip select (SYNC) setup time.
>>  b'000: No bit delay
>>  b'001: 1-clock-cycle delay
>>  b'010: 2-clock-cycle delay
>>  b'101: 0.5-clock-cycle delay
>>  b'110: 1.5-clock-cycle delay
>>
>> The SYNCDL is the chip select (SYNC) hold time.
>>  b'000: No bit delay
>>  b'001: 1-clock-cycle delay
>>  b'010: 2-clock-cycle delay
>>  b'011: 3-clock-cycle delay
>>  b'101: 0.5-clock-cycle delay
>>  b'110: 1.5-clock-cycle delay

You forgot to quote the last line from the DTDL and SYNCDL paragraphs:

| In case of SPI mode, only 000 is allowed to set to this field.

And the spi-sh-msiof driver is using the MSIOF in SPI mode???

>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>> ---
>>
>>  I would like to add new properties for sh-msiof driver to adjust
>> the SYNC siginal timing using DTDL and SYNCDL. In the current driver,
>> these parameters are hardcoded to 0. And then, I checked other spi
>> drivers, and I found the following commit:
>>   d0fb47a5237d8b9576113568bacfd27892308b62
>>   (spi: fsl-espi: Configure FSL eSPI CSBEF and CSAFT)
>>
>> If this patch is reasonable, I will modify the sh-msiof driver.
>> Or, should we add a new function for this timing adjusting in the
>> spi framework?
>>
>>  Documentation/devicetree/bindings/spi/sh-msiof.txt |    8 ++++++++
>>  drivers/spi/spi-sh-msiof.c                         |    2 ++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt
>> b/Documentation/devicetree/bindings/spi/sh-msiof.txt index d11c372..5fe8ffd
>> 100644
>> --- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
>> +++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
>> @@ -30,6 +30,14 @@ Optional properties:
>>                        specifiers, one for transmission, and one for
>>                        reception.
>>  - dma-names            : Must contain a list of two DMA names, "tx" and
>> "rx".
>> +- renesas,tdmr-dtdl    : delay sync signal (setup) in transmit mode
>> +                      (default is 0, we can set it to 0, 1, 2, 5, or 6)
>> +- renesas,tdmr-syncdl  : delay sync signal (hold) in transmit mode
>> +                      (default is 0, we can set it to 0, 1, 2, 3, 5, or 6)
>> +- renesas,rdmr-dtdl    : delay sync signal (setup) in receive mode
>> +                      (default is 0, we can set it to 0, 1, 2, 5, or 6)
>> +- renesas,rdmr-syncdl  : delay sync signal (hold) in receive mode
>> +                      (default is 0, we can set it to 0, 1, 2, 3, 5, or 6)

In general, it's frowned upon the specify actual register values in DT.
So I think it's better to specify the delay values instead of the
bitfield values,
and drop the "tdmr" and "rdmr" from the names.
As DT supports integers only, that should become a fixed point value.
E.g. delay in deci-clocks (0, 5, 10, 15, 20)?
Or as a percentage of the clock cycle (0, 50, 100, 150, 200)?

Do you really need two sets of values, for both transmit and receive?
I.e. do you need different values for transmit and receive for your use case?
SPI does both transmit and receive using the same clock and chip select.
I know some MSIOF implementations can handle both indepedently.

And to answer your last question: if several drivers need this, it makes sense
to make this general, and add support in the SPI core. Mark?

> Was it really the intent of this patch to add DT properties without providing
> an implementation in the sh-msiof driver ?

Given the sentence "If this patch is reasonable, I will modify the sh-msiof
driver." in the introduction, I think so.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
