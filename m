From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: add driver for J-Core SPI controller
Date: Thu, 28 Jul 2016 20:51:25 +0100
Message-ID: <20160728195125.GN11806@sirena.org.uk>
References: <cover.1469686300.git.dalias@libc.org>
 <2a46090a5a7c177b7eca83f68406650844423e7f.1469686300.git.dalias@libc.org>
 <20160728191153.GL11806@sirena.org.uk>
 <20160728194045.GK15995@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KsSkVHHhotaZRe1D"
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160728194045.GK15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--KsSkVHHhotaZRe1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2016 at 03:40:45PM -0400, Rich Felker wrote:
> On Thu, Jul 28, 2016 at 08:11:53PM +0100, Mark Brown wrote:

> > An architecture or SoC dependency with || COMPILE_TEST would be useful
> > for avoiding cluttering Kconfig for other users.  Though as this is in a
> > FPGA it's perhaps likely people will pick this up for other FPGAs so
> > perhaps a comment to that effect if it seems likely.

> Unlike some of the other SoC hardware (interrupt controller) that's
> more closely tied to the SH cpu trap behavior, the SPI master seems
> like something that would be nice and easy to reuse elsewhere. I don't
> feel strongly about it either way though; I can add the arch dep if
> you want.

I guess it depends if anyone is actually doing that or not, if nobody is
the dependency would be better.

> > Why are you not using the clock API for this?  Just require a clock and
> > use clk_get_rate() to find out what rate it is.

> I thought about that but I'm not familiar with it. I can try to figure
> it out quickly and test that approach; don't see any reason it
> shouldn't work. Would you insist on having full support for
> enabling/disabling the clk when it's in use, or would you be happy
> with treating it as a fixed clock that's always-on for now and
> possibly extending it with more functionality later if there's ever
> hardware where that's relevant/helpful?

It's fine to just enable it at startup and leave it on, though the
runtime PM ops are trivial and you can set auto_runtime_pm to have the
core do the gets and puts.

--KsSkVHHhotaZRe1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmmI8AAoJECTWi3JdVIfQcUsH/24azC7orxSkRAiAbOE2fiDY
s9reR3nHmds+Lv+jCtXgAf23W3KXVivaBAd8tNz5jXQyMDBeoqA1pgp5iDyL+/7C
WICMdYwkuZ3dWzsuPZB85Yu/1SN+pia9NkJDS4+m4ODJA/nmIA0/5G1ZR6dj5Hxr
L1uWF2pH2685PskB+AhGAqNn3SIJqeOSjy2O178uMKvY99s2Bp2sVFTUW4fk3K/c
T961zPilop0+csiYDyYD9OzGKN9RUlwSb1Me1dIDbJk7Cj49SMR6ZMqcWL8bkHbA
8rzsFQ0sbSc0GALjQKtK0VPHcPHLEgMRwnuUfTAdOjr6//3AlcHZiUeA1nxZkOo=
=6WQn
-----END PGP SIGNATURE-----

--KsSkVHHhotaZRe1D--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
