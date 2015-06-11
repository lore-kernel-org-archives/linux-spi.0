From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/3] spi: atmel: update DT bindings documentation
Date: Thu, 11 Jun 2015 18:37:51 +0200
Message-ID: <5579B95F.9060307@atmel.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com> <ce7c16faafaa24f5bb711115c0eea1f8992d08c3.1433850255.git.cyrille.pitchen@atmel.com> <20150609172531.GM14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150609172531.GM14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 09/06/2015 19:25, Mark Brown a =E9crit :
> On Tue, Jun 09, 2015 at 01:53:53PM +0200, Cyrille Pitchen wrote:
>> - add new property "atmel,fifo-size"
>=20
> Why is this a property and not something we know from the IP version?
>
Hi Mark,
=20
Please be aware that the VERSION register can not be used to guess the
size of FIFOs. Indeed, for a given hardware version, the SPI controller
can be integrated on Atmel SoCs with different FIFO sizes. Also the
"atmel,fifo-size" property is optional as older SPI controllers don't
embed FIFO at all.

Besides, the FIFO size can not be read or guessed from other registers:
When designing the FIFO feature, no dedicated registers were added to
store this size. Unused spaces in the I/O register range are limited an=
d
better reserved for future usages. Instead, the FIFO size of each
peripheral is documented in the programmer datasheet.

=46inally, on a given SoC, there can be several instances of the SPI
controller with different FIFO sizes. This explain why we'd rather use =
a
dedicated DT property than use the "compatible" property.

I hope these pieces of information will help to clarify this point.
Of course, we are open to other suggestions.

Best Regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
