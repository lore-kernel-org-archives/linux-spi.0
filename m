From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion: support armada extended baud rates
Date: Fri, 05 Sep 2014 23:11:38 +1000
Message-ID: <5409B68A.7010604@uclinux.org>
References: <1409835268-29555-1-git-send-email-gerg@uclinux.org>	<CAMuHMdWDOaPnmCzThqCo2848eDj6jmi-eaXM1YAXQLi41da34A@mail.gmail.com>	<5409057A.6090900@uclinux.org> <CAMuHMdWf6_yBhpNgK=wJcQqzLNJvTnC95SrqrcZyRH+jGL93vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWf6_yBhpNgK=wJcQqzLNJvTnC95SrqrcZyRH+jGL93vA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On 05/09/14 17:36, Geert Uytterhoeven wrote:
> Hi Greg,
>
> On Fri, Sep 5, 2014 at 2:36 AM, Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org> wrote:
>>> Are the Orion rates and register bits a subset of the Armada ones?
>>> I.e. does the Armada work with the Orion setup?
>> The bits used by the orion are a subset (bits 0-4 of the SPI
>> configuration register) of those used by the armada (bits 0-4 and
>> 6-7).
>>
>> In practice the defined prescalar values for the orion do give
>> the same divisor for the same bits set on armada. The extra bits
>> on the armada let you get to lower SPI baudrates (which is more of
>> a problem on the armada with its higher core clocks).
> OK, so the answer is yes.
>
>>>> This change introduces a new device tree compatible device name
>>>> "armada-spi". This is used in place of "orion-spi" on the Armada SoC
>>>> parts.
>>>> -                               compatible = "marvell,orion-spi";
>>>> +                               compatible = "marvell,armada-spi";
>>> If the answer to my above question is yes, you want to keep
>>> "marvell,orion-spi" as a fallback.
>> Do you mean like this?
>>
>>    compatible = "marvell,orion-spi", "marvell,armada-spi";
> No, the other way around (from most-specific to least-specific):
>
>      compatible = "marvell,armada-spi", "marvell,orion-spi"
>
> So the Armada version is used if available, and the Orion version
> is used as a fallback.

Ok, got it. Thanks.

Regards
Greg


> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
