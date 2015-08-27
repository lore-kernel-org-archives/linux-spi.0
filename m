From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Thu, 27 Aug 2015 15:56:14 +0100
Message-ID: <20150827145614.GC5313@sirena.org.uk>
References: <20150821074310.GM30005@lahna.fi.intel.com>
 <CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
 <20150824085140.GA5647@ck-lbox>
 <CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
 <20150825062157.GB27431@sirena.org.uk>
 <CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
 <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
 <20150826100155.GA1513@lahna.fi.intel.com>
 <CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
 <20150827115914.GF28428@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
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
In-Reply-To: <20150827115914.GF28428-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2015 at 02:59:14PM +0300, Mika Westerberg wrote:
> On Thu, Aug 27, 2015 at 01:44:45PM +0200, Christian Hartmann wrote:

> > drivers/gpio/gpio-arizona.c
> > and drivers/extcon/extcon-arizona.c

> > I have already CONFIG_GPIO_ARIZONA=y, but it does not be used at all.
> > Is it save to ignore ?? Or should I use them as well ??

> If the SPI device interrupt is connected to arizona GPIO pin, then you
> probably need that.

I can't see how that would work, the interrupt output isn't a GPIO.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3yUOAAoJECTWi3JdVIfQcOYH/0Dh0WJT54ydA4NrA4ibU1Y9
IDY7RM1WeGqadcF+dwwF+JYsDsH9XbAwc74RuOf5stnJCC6okY7gHgvjoMTkcksa
7zGsZ3e1qEs27BQ3/aQPqon/iR13MNPGTsuQsk4c9UhNfouKe4CwE0LzUi45l1qH
J9TykBySd9xXK2nz+ODdGo44swzGPErhvUO8niPjyWvRz/JjAsvC8BPTjX/qgdfI
witQmJ/TRgeKn1yDSKWHn+aiTW6T1bb/PVn4D2Ea+wy/SLzd2DNXUzFsGSxC9If9
D9MgZt+3rszsDH6SasBZSBVjKwo/vS97w7v1LUdPKJwEyIe05/xLhrdVnP4/sGo=
=9gnX
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
