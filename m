From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a =?iso-8859-1?Q?GPIO_CS?=
Date: Wed, 24 Jan 2018 16:03:15 +0100
Message-ID: <60b34619-5034-4e71-b0b2-75a62de0cf2c@cesnet.cz>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On st=C5=99eda 24. ledna 2018 14:41:27 CET, Geert Uytterhoeven wrote:
> Can't you just deduce an unused HW CS from the cs-gpios property?

Thanks for a review. Yes, I probably can. I just noticed that my local use=20=

of spi-orion's "direct mode" is probably the root cause of some weirdness=20
that I'm seeing (such as the CS GPIO pin going up in the middle of a=20
two-byte transaction, and other nasty issues that just go away once one=20
adds a dev_info call...).

> Renesas MSIOF also requires driving a native chip select, cfr. commit
> b8761434bdec32fa ("spi: sh-msiof: Implement cs-gpios configuration").

I'll take a look. It could be a candidate for some shared code, I suppose.

Cheers,
Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
