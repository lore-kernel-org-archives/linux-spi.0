From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Wed, 24 Jan 2018 19:17:35 +0100
Message-ID: <CAMuHMdUaLV522qihJibmTO1NR6NK0DNjMT8soGvLsi=ffGg71A@mail.gmail.com>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
 <60b34619-5034-4e71-b0b2-75a62de0cf2c@cesnet.cz> <52b64615-7c67-47ee-8f00-059decfc2c93@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52b64615-7c67-47ee-8f00-059decfc2c93-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jan,

On Wed, Jan 24, 2018 at 6:56 PM, Jan Kundr=C3=A1t <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org> w=
rote:
> On st=C5=99eda 24. ledna 2018 16:03:15 CET, Jan Kundr=C3=A1t wrote:
>>> Renesas MSIOF also requires driving a native chip select, cfr. commit
>>> b8761434bdec32fa ("spi: sh-msiof: Implement cs-gpios configuration").
>>
>> I'll take a look. It could be a candidate for some shared code, I suppos=
e.
>
> Hi Gert, if I take your code from that commit almost as-is, probing of my
> SPI controller fails with errno -16 (that's EBUSY, right?). The GPIO pin
> that I want to use is defined as a gpio-hog in the DT.
>
> Is my DT correct? Should I define the GPIO pin as an output hog? IS your
> code supposed to deal with this?

Using a hog indeed marks it busy, as the hog is a user.

Why do you use a hog in the first place? Shouldn't the SPI driver configure
the GPIO, according to cs-gpios?

Before the advent of DT, the platform code was supposed to take care of tha=
t,
so this may be a too-literal conversion from platform code to DT.

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
