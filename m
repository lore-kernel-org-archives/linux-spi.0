From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Fwd: [alsa-devel] [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Thu, 25 Jun 2015 16:56:12 +0100
Message-ID: <20150625155612.GS14071@sirena.org.uk>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com>
 <20150625073618.GH827@lahna.fi.intel.com>
 <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com>
 <20150625145853.GP14071@sirena.org.uk>
 <20150625154407.GE6321@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HN2e3bLtdKc9n6ym"
Cc: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150625154407.GE6321-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HN2e3bLtdKc9n6ym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2015 at 04:44:07PM +0100, Charles Keepax wrote:
> On Thu, Jun 25, 2015 at 03:58:53PM +0100, Mark Brown wrote:
> > On Thu, Jun 25, 2015 at 02:18:23PM +0200, Christian Hartmann wrote:

> > >                 Name (_HID, "WM510205")  // _HID: Hardware ID
> > >                 Name (_CID, "WM510205")  // _CID: Compatible ID
> > >                 Name (_DDN, "Wolfson Microelectronics Audio WM5102")

> > Separately to the chip select discussion one thing to highlight here is
> > that for some reason the BIOS is listing the device as "WM510205" rather
> > than "WM5102" - do those extra numbers mean anything and does this mean
> > that WM50120[1-4] and possibly higher numbers are also valid?

> From my brief discussions with the Windows guys here on this
> basically those last two digits are being used to inform the
> Windows driver of use-case setup. So here it will set things up
> for whatever the Window's driver considers to be setup "5".

Yay for scalability and abstraction.

> I think from the Linux side we can safely ignore those last two
> digits. I expect that all systems of the same make and model
> would report the same last two digits but that it might change
> between models if the Windows driver is expected to something
> differently for that model.

Well, we might want to consider using this to set our platform data
instead of the machine ID if people have just been copying a smallish
set of reference designs, it might might make for a slightly smaller set
of ID tables than the machine ID based stuff does.

Due to the way ACPI ID matching works we'll also need to add every
suffix individually to the table, we're looking for complete matches not
substring matches here.

--HN2e3bLtdKc9n6ym
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVjCSbAAoJECTWi3JdVIfQAAUH/0hguN0p3H9JjXame0HEtiAr
ElyzrcxNcRmryYhIwAXM9LpQYoULa+v/t49ApxQxNuI2R/vv22NcLuTfVCyBiJj0
ChJSGRqo4OYK3fx74rv/DT5j9Xg/2Bwpl6cG9lWFo9597IXb+g++q0A3pjJMay30
zO1Y26p6Qyr1BeCGnWIkSUUlWNmE7GC/MYknPuSjacx8VY4ZTlY/yzHM9lfxPa/I
QJYSCAQJO4UzBYtUN3VvfnEt6/8cl6WSbzRTU5bMsgHiik4L4wQWflFe9g1JcQWm
u4FTok9Q+IvvNJM9coyScqpnnaa7FbstqEPX24gTYy5OMBhky4IQO6YfhFUry1I=
=1MMd
-----END PGP SIGNATURE-----

--HN2e3bLtdKc9n6ym--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
