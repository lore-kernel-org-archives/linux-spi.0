From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Thu, 25 Jan 2018 09:51:06 +0100
Message-ID: <CAMuHMdUOFJS=s-8Dv-BBLayXxKqZ0kPAUednA-3NL0+AZYuq-w@mail.gmail.com>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
 <60b34619-5034-4e71-b0b2-75a62de0cf2c@cesnet.cz> <96ca6f6776cf4146bcfb56a884236165@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <96ca6f6776cf4146bcfb56a884236165-5g7mGxlPNYb6GjIOKuZY+ItlCAj8ZROq@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Chris,

On Wed, Jan 24, 2018 at 10:29 PM, Chris Packham
<Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
> On 25/01/18 04:03, Jan Kundr=C3=A1t wrote:
>> On st=C5=99eda 24. ledna 2018 14:41:27 CET, Geert Uytterhoeven wrote:
>>> Can't you just deduce an unused HW CS from the cs-gpios property?
>>
>> Thanks for a review. Yes, I probably can. I just noticed that my local u=
se
>> of spi-orion's "direct mode" is probably the root cause of some weirdnes=
s
>> that I'm seeing (such as the CS GPIO pin going up in the middle of a
>> two-byte transaction, and other nasty issues that just go away once one
>> adds a dev_info call...).
>>
>>> Renesas MSIOF also requires driving a native chip select, cfr. commit
>>> b8761434bdec32fa ("spi: sh-msiof: Implement cs-gpios configuration").
>>
>> I'll take a look. It could be a candidate for some shared code, I suppos=
e.
>
> How would this work? If I understand the sh-msiof driver it picks an
> unused native CS.

Correct. The hardware always has to drive one of the 3 available native chi=
p
selects.

> In the case of b28b9149b37f the gpios supplement the
> native CS they do not replace it (the hardware I was using has a GPIO
> which controls a gate attached to CS0).

However, Jan wrote:
> semi-public datahseet, it seems that the SPI hardware really insists on
> driving *some* HW CS signal whenever a SPI transaction is in progress.

If that is correct, it behaves like MSIOF, so you must leave one native chi=
p
select unused. If all native chip selects are in use, one of them must be
replaced by a GPIO chip select (which could be the same physical pin,
depending on pinmux capabilities).

> My specific board isn't upstream but here's the snippet from its dts
>
> &spi0 {
>          status =3D "okay";
>          cs-gpios =3D <0
>                      &gpio0 17 GPIO_ACTIVE_LOW>;
>
>          spi-flash@0 {
>                 /* This is on CS0 when GPIO 17 is high */
>          };
>
>          spi-sram@1 {
>                  /* This is on CS0 when GPIO 17 is low */
>         };
> };
>
> I'm not sure what else I could do. I can't claim the GPIO twice. If I
> could I could probably use spi-cs-high to handle the high/low toggle.

So this uses GPIO17 to drive a mux to connect CS0 to either the first or
second device?

But you describe this as @0 being driven by CS0, and @1 by GPIO17, and you
rely on CS0 still being driven when @1 is selected, right?
That indeed won't work when an unused native chip select is driven when
using cs-gpio.

IMHO, this needs the mux to be described properly in DT.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
