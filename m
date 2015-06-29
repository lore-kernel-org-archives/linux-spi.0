From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Fwd: [alsa-devel] [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Mon, 29 Jun 2015 10:44:32 +0100
Message-ID: <20150629094432.GA11162@sirena.org.uk>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com>
 <20150625073618.GH827@lahna.fi.intel.com>
 <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com>
 <20150625145853.GP14071@sirena.org.uk>
 <20150625154407.GE6321@opensource.wolfsonmicro.com>
 <20150625155612.GS14071@sirena.org.uk>
 <20150625161108.GF6321@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
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
In-Reply-To: <20150625161108.GF6321-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2015 at 05:11:08PM +0100, Charles Keepax wrote:
> On Thu, Jun 25, 2015 at 04:56:12PM +0100, Mark Brown wrote:

> > > > Separately to the chip select discussion one thing to highlight here is
> > > > that for some reason the BIOS is listing the device as "WM510205" rather
> > > > than "WM5102" - do those extra numbers mean anything and does this mean
> > > > that WM50120[1-4] and possibly higher numbers are also valid?

> > > From my brief discussions with the Windows guys here on this
> > > basically those last two digits are being used to inform the
> > > Windows driver of use-case setup. So here it will set things up
> > > for whatever the Window's driver considers to be setup "5".

> > Yay for scalability and abstraction.

> Well it certainly is abstract.

Just not the same abstraction the rest of the world is using there :(

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkRN/AAoJECTWi3JdVIfQzGMH/RgOxowrWDwz9nMc9KlG7dty
JJY5dLAITj/zUFy6BrzcsMOERT5pLePAq18oB3NtsrAr5VguLsfOhrmX1yX1fX1D
e1Mr3mz+qa2KwaY6YOg2GI346RwoU0SdOnMR2J/ulScUosWu0Mgw6+1TZal+Oo4P
2GZXf+n2igKzDOXBawIVGmj40fVFcOeMdb/DO76CfVxtTQABMW4FDzDO/Ei6Oab3
bvpNp9r/U1rEWCxZs7Ts4devagH290K6nQDtHb+ItbkX48EcmlLO0ty6ZdxSreXc
v4aUhOlkzcybcVyWTQXpf1DsAkoo8fvfnUNYuX8G9jBoBiRayK5GeG+EodppGX8=
=5r2V
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
