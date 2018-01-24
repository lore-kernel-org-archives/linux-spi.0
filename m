From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Wed, 24 Jan 2018 14:41:27 +0100
Message-ID: <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jan,

On Tue, Jan 23, 2018 at 8:56 PM, Jan Kundr=C3=A1t <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org> w=
rote:
> Commit b28b9149b37f added support for using an additional GPIO pin for
> Chip Select. According to that commit and to my understanding of a
> semi-public datahseet, it seems that the SPI hardware really insists on
> driving *some* HW CS signal whenever a SPI transaction is in progress.
>
> The old code effectively forced the HW CS pin to be CS0. That means that
> there could not be anything connected to the real CS0 signal when one
> uses a GPIO CS. That assumption does not hold on e.g. Solidrun Clearfog
> where some SOM models have a built-in SPI flash on SPI1, CS0.
>
> Signed-off-by: Jan Kundr=C3=A1t <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/spi-orion.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
> @@ -28,6 +28,11 @@ Optional properties:
>  - clock-names : names of used clocks, mandatory if the second clock is
>                 used, the name must be "core", and "axi" (the latter
>                 is only for Armada 7K/8K).
> +- orion-spi,cs-gpio-hw-cs : Because the SoC always wants to drive some H=
W Chip
> +                           Select pin, it is necessary to specify which =
one
> +                           should be used when Linux drives an additiona=
l
> +                           GPIO as a software-controlled CS. Defaults to=
 HW
> +                           CS 0.

Can't you just deduce an unused HW CS from the cs-gpios property?

Renesas MSIOF also requires driving a native chip select, cfr. commit
b8761434bdec32fa ("spi: sh-msiof: Implement cs-gpios configuration").

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
