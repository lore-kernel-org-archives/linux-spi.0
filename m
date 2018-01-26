From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a =?iso-8859-1?Q?GPIO_CS?=
Date: Fri, 26 Jan 2018 20:56:13 +0100
Message-ID: <8547e5d0-01ae-48ad-9d7c-75539cc40fad@cesnet.cz>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
 <60b34619-5034-4e71-b0b2-75a62de0cf2c@cesnet.cz>
 <52b64615-7c67-47ee-8f00-059decfc2c93@cesnet.cz>
 <CAMuHMdUaLV522qihJibmTO1NR6NK0DNjMT8soGvLsi=ffGg71A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUaLV522qihJibmTO1NR6NK0DNjMT8soGvLsi=ffGg71A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On st=C5=99eda 24. ledna 2018 19:17:35 CET, Geert Uytterhoeven wrote:
> Using a hog indeed marks it busy, as the hog is a user.
>
> Why do you use a hog in the first place? Shouldn't the SPI driver configure=

> the GPIO, according to cs-gpios?

That doesn't happen with spi-orion.c. If I remove my gpio-hog for the CS=20
GPIO pin from the DT, then my device doesn't appear to be selected. Also, I=20=

can run gpio-hammer targetting my CS pin just fine -- and that seems=20
dangerous.

I don't see any "claim" of a GPIO neither in spi.c nor spi-orion.c. I did=20
some very hacky grepping [1], and it seems that other drivers probably=20
handle this on their own. The only other match is spi-lantiq-ssc.c which=20
doesn't however touch the CS GPIO.

Shouldn't this be really handled by the SPI core? (I don't think I'm=20
volunteering with patches as I couldn't really test these.)

Should I submit a patch which adapts spi-orion.c to essentially follow how=20=

e.g spi-imx.c allocates a GPIO pin for CS?

Cheers,
Jan

[1] `git grep --files-with-match cs_gpio drivers/spi/*.c | xargs -n1 git=20
grep -E --files-without-match 'gpio_direction_output|gpio_request' | cat`
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
