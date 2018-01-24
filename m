From: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Wed, 24 Jan 2018 21:29:13 +0000
Message-ID: <96ca6f6776cf4146bcfb56a884236165@svr-chch-ex1.atlnz.lc>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
 <60b34619-5034-4e71-b0b2-75a62de0cf2c@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: =?iso-8859-2?Q?Jan_Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jan, Geert,=0A=
=0A=
On 25/01/18 04:03, Jan Kundr=E1t wrote:=0A=
> On st=F8eda 24. ledna 2018 14:41:27 CET, Geert Uytterhoeven wrote:=0A=
>> Can't you just deduce an unused HW CS from the cs-gpios property?=0A=
> =0A=
> Thanks for a review. Yes, I probably can. I just noticed that my local us=
e=0A=
> of spi-orion's "direct mode" is probably the root cause of some weirdness=
=0A=
> that I'm seeing (such as the CS GPIO pin going up in the middle of a=0A=
> two-byte transaction, and other nasty issues that just go away once one=
=0A=
> adds a dev_info call...).=0A=
> =0A=
>> Renesas MSIOF also requires driving a native chip select, cfr. commit=0A=
>> b8761434bdec32fa ("spi: sh-msiof: Implement cs-gpios configuration").=0A=
> =0A=
> I'll take a look. It could be a candidate for some shared code, I suppose=
.=0A=
=0A=
How would this work? If I understand the sh-msiof driver it picks an =0A=
unused native CS. In the case of b28b9149b37f the gpios supplement the =0A=
native CS they do not replace it (the hardware I was using has a GPIO =0A=
which controls a gate attached to CS0).=0A=
=0A=
My specific board isn't upstream but here's the snippet from its dts=0A=
=0A=
&spi0 {=0A=
         status =3D "okay";=0A=
         cs-gpios =3D <0=0A=
                     &gpio0 17 GPIO_ACTIVE_LOW>;=0A=
=0A=
         spi-flash@0 {=0A=
		/* This is on CS0 when GPIO 17 is high */=0A=
         };=0A=
=0A=
         spi-sram@1 {=0A=
                 /* This is on CS0 when GPIO 17 is low */=0A=
	};=0A=
};=0A=
=0A=
I'm not sure what else I could do. I can't claim the GPIO twice. If I =0A=
could I could probably use spi-cs-high to handle the high/low toggle.=0A=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
