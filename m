From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: improve internal vs gpio chip-select choice
Date: Wed, 13 Jan 2016 02:07:37 +0000
Message-ID: <yw1x37u2ut92.fsf@unicorn.mansr.com>
References: <1452211907-16074-1-git-send-email-mans@mansr.com>
	<5693C9A3.9040403@atmel.com> <yw1xh9ikw29c.fsf@unicorn.mansr.com>
	<5694BE36.7060702@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"Yang\, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5694BE36.7060702-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> (Nicolas Ferre's message of "Tue, 12
	Jan 2016 09:49:58 +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:

> Le 11/01/2016 16:43, M=E5ns Rullg=E5rd a =E9crit :
>> Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:
>>=20
>>> Le 08/01/2016 01:11, Mans Rullgard a =E9crit :
>>>> The driver currently chooses between internal chip-select or gpio
>>>> based on the existence of the cs-gpios DT property which fails on
>>>> non-DT systems and also enforces the same choice for all devices.
>>>
>>> Well, I fear that such a per-device choice may impact further the d=
river
>>> than just moving a field from one structure to another...
>>=20
>> Could you please elaborate?
>
> Well, the first thing that comes to my mind is that the DT property m=
ay
> need to be  to the SPI device node and not the controller anymore, fo=
r a
> need of coherency.
> That would imply modifying the binding and I don't want that for such=
 an
> useless "improvement".
>
>>> Moreover, I have the feeling that it was not the objective of this
>>> patch.
>>=20
>> Your feeling is mistaken.  If it's somehow impossible to mix CS type=
s,
>> please explain why.
>
> Please only fix the avr32 issue with CS gpio selection that I admit w=
e
> have. I don't need nor want to mix CS types: it just doesn't make sen=
se
> to allow it.

There's also this comment in spi.h regarding struct spi_master:

 * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
 *	number. Any individual value may be -ENOENT for CS lines that
 *	are not GPIOs (driven by the SPI controller itself).


--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
