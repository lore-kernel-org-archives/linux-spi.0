From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a =?iso-8859-1?Q?GPIO_CS?=
Date: Tue, 30 Jan 2018 09:03:10 +0100
Message-ID: <368d1a46-8fc8-466d-b292-8ab8eaf11f4b@cesnet.cz>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <1517274816.25398.136.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1517274816.25398.136.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On =C3=BAter=C3=BD 30. ledna 2018 2:13:37 CET, Trent Piepho wrote:
> Another way to fix it, besides default to 0 or to select an unused
> chipselect, is to use the cs number of the slave modulus the number of
> native chip selects.  They are or were some other drivers that do this.
> The idea is that CS numbers don't need to be sequential and there isn't
> much of a cost of an unused chip select (one word in device tree
> property).

Hi Trent, are you talking about an integer modulo here? I don't think that=20=

modulo is a correct approach. If my HW has two CS and I use the following=20
DT:

=09cs-gpios =3D <0>, <&gpio0 1>, <&gpio0 2>, <0>;

...then the logical CS2 (at gpio0 pin 2) conflicts with the native CS0.

Also, the spi-orion driver currently hard-codes that each and every model=20
is supposed to have exactly eight HW CS pins. That's not true for my SoC=20
(Marvell Armada 388, the Solidrun Clearfog Base board); the 88F6828 CPU=20
only has four SPI CS signals.

What my patch does is simply picking the *first* unused CS and going with=20
that one because that looks like the easiest and also safest option.

Cheers,
Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
