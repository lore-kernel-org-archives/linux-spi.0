From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a =?iso-8859-1?Q?GPIO_CS?=
Date: Wed, 24 Jan 2018 18:56:23 +0100
Message-ID: <52b64615-7c67-47ee-8f00-059decfc2c93@cesnet.cz>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
 <60b34619-5034-4e71-b0b2-75a62de0cf2c@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <60b34619-5034-4e71-b0b2-75a62de0cf2c-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On st=C5=99eda 24. ledna 2018 16:03:15 CET, Jan Kundr=C3=A1t wrote:
>> Renesas MSIOF also requires driving a native chip select, cfr. commit
>> b8761434bdec32fa ("spi: sh-msiof: Implement cs-gpios configuration").
>
> I'll take a look. It could be a candidate for some shared code, I suppose.

Hi Gert, if I take your code from that commit almost as-is, probing of my=20
SPI controller fails with errno -16 (that's EBUSY, right?). The GPIO pin=20
that I want to use is defined as a gpio-hog in the DT.

Is my DT correct? Should I define the GPIO pin as an output hog? IS your=20
code supposed to deal with this?

With kind regards,
Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
