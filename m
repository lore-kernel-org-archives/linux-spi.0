From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 28 Aug 2015 10:16:09 +0100
Message-ID: <20150828091609.GR5313@sirena.org.uk>
References: <20150824085140.GA5647@ck-lbox>
 <CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
 <20150825062157.GB27431@sirena.org.uk>
 <CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
 <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
 <20150826100155.GA1513@lahna.fi.intel.com>
 <CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
 <20150827115914.GF28428@lahna.fi.intel.com>
 <20150827145614.GC5313@sirena.org.uk>
 <20150828090042.GI28428@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="213E7WwkW+nU62+Y"
Cc: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150828090042.GI28428-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--213E7WwkW+nU62+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 28, 2015 at 12:00:42PM +0300, Mika Westerberg wrote:
> On Thu, Aug 27, 2015 at 03:56:14PM +0100, Mark Brown wrote:
> > On Thu, Aug 27, 2015 at 02:59:14PM +0300, Mika Westerberg wrote:

> > > > I have already CONFIG_GPIO_ARIZONA=y, but it does not be used at all.
> > > > Is it save to ignore ?? Or should I use them as well ??

> > > If the SPI device interrupt is connected to arizona GPIO pin, then you
> > > probably need that.

> > I can't see how that would work, the interrupt output isn't a GPIO.

> I mean that if the SPI device (codec) interrupt pin is connected to a GPIO
> pin of arizona instead of GPIO pin of the SoC itself.

I understand what you mean, I'm just saying that the GPIO driver for the
chip seems unlikely to be useful.

--213E7WwkW+nU62+Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV4CbZAAoJECTWi3JdVIfQU8UH/ie/jH3XLWt5qlqXwfGa/65Y
eTvdULrinzN/2jlOrHaxL7fjc+XdtcZDtoAxkEOv8DFtPGg/R7pPzCwHsa3E1UkG
6nagkMrRyryUILpHw/3ZA6CpPqiGoUmpU/qcB0Jqze4EQfY31NQg2SNmRHxTbXf3
saeRV1GjynO3alILk34aIJ/XF5DG17F7xlqueh53UKPDhKj3TbXlkinw8vFsjoXh
9D/7cLuQsWdFz6m/oYKFWy+8HxnLmeTsFe0cX0OWYzlwUawVZ6+bI0/gKsPXu5fr
xizn5M0n0F0SD493+AXPJGIH7/VIdlHNCWn9qvl0WnYWEXwsqD4JywLPOBihqdE=
=jZma
-----END PGP SIGNATURE-----

--213E7WwkW+nU62+Y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
