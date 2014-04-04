From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] devicetree: Add devicetree bindings documentation
 for Cadence SPI
Date: Fri, 4 Apr 2014 10:09:47 +0200
Message-ID: <CAMuHMdWvFT1kLpcYGSuNFs6qVTbn4S-9-rFV8jkJMAaS8xCDnQ@mail.gmail.com>
References: <1396523431-14519-1-git-send-email-harinik@xilinx.com>
	<1396523431-14519-2-git-send-email-harinik@xilinx.com>
	<20140403213446.GB14763@sirena.org.uk>
	<CAFcVEC+mpHh_d2j6_sdhWS3d2KyXrDYUq6L6jO2Q=SS68Hda2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
To: Harini Katakam <harinikatakamlinux@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFcVEC+mpHh_d2j6_sdhWS3d2KyXrDYUq6L6jO2Q=SS68Hda2g@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Harini,

On Fri, Apr 4, 2014 at 5:00 AM, Harini Katakam
<harinikatakamlinux@gmail.com> wrote:
>>> +             num-cs = /bits/ 16 <4>;
>>
>> What's going on with the /bits/ - is this something that's required for
>> the property?
>
> The master->num-chipselect property is 16 bit but writing <4> here directly
> leads to 0 being read in of_property_read (because it's big endian).
> Instead using of property read u32 and then copying, we decided to do this.
> This was discussed on v2 between Michal and Rob:
>>>>> +               num-chip-select = /bits/ 16 <4>;
>>>
>>> I was expecting you will comment this a little bit. :-)
>>> Because all just reading this num-cs as 32bit and then
>>> assigning this value to master->num_chipselect which is 16bit.
>>
>> Well, everyone else has that problem then. Obviously it takes a bit
>> more care than just reading into a u32, but that is a kernel problem
>> and not a problem of the binding.
> They are not reading it directly with read_u32 but they are using
> intermediate u32 value which is assigned to u16 which is fine.
> This pattern is in most drivers(maybe all).
> The point is if binding should or can't simplify driver code.
> And from your reaction above I expect that it is up to driver
> owner and binding doc how you want to do it.

IMHO this "/bits/ 16" doesn't simplify the binding.

As "num-cs" is a generic spi subsystem binding, it should not be
restricted to 16 bits for the sake of a driver. As your hardware can drive 4
chip selects, you could represent it in 3 bits (don't!).

Simple integers are 32 bit in DT, so use a temporary.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
