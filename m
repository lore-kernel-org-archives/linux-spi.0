From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Thu, 25 Jan 2018 22:27:24 +0100
Message-ID: <CAMuHMdVESS=_JhsO2pziFshWF+d=g78H8XSny34HTJn=1Lei7g@mail.gmail.com>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
 <60b34619-5034-4e71-b0b2-75a62de0cf2c@cesnet.cz> <96ca6f6776cf4146bcfb56a884236165@svr-chch-ex1.atlnz.lc>
 <CAMuHMdUOFJS=s-8Dv-BBLayXxKqZ0kPAUednA-3NL0+AZYuq-w@mail.gmail.com>
 <20180125115741.GA21900@sirena.org.uk> <5dec18c8e18845d39999ca60547fefff@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5dec18c8e18845d39999ca60547fefff-5g7mGxlPNYb6GjIOKuZY+ItlCAj8ZROq@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Chris,

On Thu, Jan 25, 2018 at 10:18 PM, Chris Packham
<Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
> On 26/01/18 00:57, Mark Brown wrote:
>> ")
>> Fcc: +sent-mail
>>
>> On Thu, Jan 25, 2018 at 09:51:06AM +0100, Geert Uytterhoeven wrote:
>>> On Wed, Jan 24, 2018 at 10:29 PM, Chris Packham
>>
>>> However, Jan wrote:
>>>> semi-public datahseet, it seems that the SPI hardware really insists on
>>>> driving *some* HW CS signal whenever a SPI transaction is in progress.
>>
>>> If that is correct, it behaves like MSIOF, so you must leave one native chip
>>> select unused. If all native chip selects are in use, one of them must be
>>> replaced by a GPIO chip select (which could be the same physical pin,
>>> depending on pinmux capabilities).
>>
>> Using the same pin is the ideal thing obviously, or if not then
>> something that we know isn't routed out of the SoC (which may or may not
>> be possible with a given chip design).
>>
>>>>           spi-flash@0 {
>>>>                  /* This is on CS0 when GPIO 17 is high */
>>>>           };
>>>>
>>>>           spi-sram@1 {
>>>>                   /* This is on CS0 when GPIO 17 is low */
>>>>          };
>>>> };
>>
>>>> I'm not sure what else I could do. I can't claim the GPIO twice. If I
>>>> could I could probably use spi-cs-high to handle the high/low toggle.
>>
>>> So this uses GPIO17 to drive a mux to connect CS0 to either the first or
>>> second device?
>
> Correct. GPIO17 directs CS0 with the addition of a logic gate.
>
>> Interesting, coincidentally there was someone else sending a patch for
>> muxing the other day which looked like having some support for chip
>> select muxing would be the most sensible implementation.  I've copied in
>> Ben who had initially approached this with a mux for the full bus which
>> I'm not so convincd about.
>>
>>> But you describe this as @0 being driven by CS0, and @1 by GPIO17, and you
>>> rely on CS0 still being driven when @1 is selected, right?
>>> That indeed won't work when an unused native chip select is driven when
>>> using cs-gpio.
>
> Yes that's my problem.
>
>>
>>> IMHO, this needs the mux to be described properly in DT.
>>
>> Yes.
>
> I'm more than happy to update the DT on this product. But I've no idea
> what that update would look like.

(Un)fortunately a mux driver is WIP, as Mark mentioned above.
See https://lkml.org/lkml/2018/1/22/859

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
