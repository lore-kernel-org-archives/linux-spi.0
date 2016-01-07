From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] spi: atmel: add support for the internal chip-select of the spi controller
Date: Thu, 07 Jan 2016 16:14:12 +0000
Message-ID: <yw1xvb75z7sb.fsf@unicorn.mansr.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
	<c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
	<yw1xvb771yrl.fsf@unicorn.mansr.com>
	<20160107154024.GF6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160107154024.GF6588-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> (Mark Brown's message of
	"Thu, 7 Jan 2016 15:40:24 +0000")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> On Tue, Jan 05, 2016 at 09:50:54PM +0000, M=E5ns Rullg=E5rd wrote:
>> Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:
>
>> > +	as->use_cs_gpios =3D true;
>> > +	if (atmel_spi_is_v2(as) &&
>> > +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
>> > +		as->use_cs_gpios =3D false;
>> > +		master->num_chipselect =3D 4;
>> > +	}
>
>> This part breaks the AVR32 boards and probably anything else that
>> doesn't use devicetree but does use GPIOs for chip select.
>
> Shouldn't this just be setting defaults for the case where nothing is
> provided?

Traditionally the platform data included a GPIO number to use and that
was that.  At some point DT support was added wherein the platform data
is overridden by cs_gpio from struct spi_device if this is valid (it is
set to a negative value by default).  Thus far all was well.  Then came
this patch.  It assumes that everybody uses DT and treats a missing
cs-gpios property as indication that the controller's own pins should b=
e
used.  It also assumes that if any device uses GPIO for CS all of them
do, even though the SPI core driver might provide a partial list
(probably since many boards don't use all the available chip selects,
but it doesn't prevent someone abusing this).

To work correctly in call cases, this driver should use, for each
peripheral, the following priority:

- spi->cs_gpio (filled from DT or -ENOENT)
- GPIO from platform data
- controller chip select pin

The trouble is that there is no way to reliably tell a valid GPIO numbe=
r
of zero in the platform data from an unset value.  In practice, I
believe existing old boards using this driver all use a non-zero GPIO
(the AVR32 platform code requires this), so checking for a non-zero
number is probably sufficient.  I'll cook up a patch for this unless
someone objects.

--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
