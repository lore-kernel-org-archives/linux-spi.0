From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/spidev: Convert to use unified device property API
Date: Tue, 30 Dec 2014 11:23:25 +0000
Message-ID: <20141230112325.GH11764@sirena.org.uk>
References: <1419846074-240217-1-git-send-email-mika.westerberg@linux.intel.com>
 <20141229160316.GO17800@sirena.org.uk>
 <20141230073714.GD1386@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1PQyblS8X/PkxCw+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141230073714.GD1386-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1PQyblS8X/PkxCw+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 30, 2014 at 09:37:14AM +0200, Mika Westerberg wrote:
> On Mon, Dec 29, 2014 at 04:03:16PM +0000, Mark Brown wrote:

> > Which nobody should be doing since it's already totally broken for
> > something to be using this on the DT side except in the one case of the
> > Rohm device which is listed there.  I don't want to merge anything which
> > allows the breakage we're seeing with people putting spidev in their DTs
> > to be propagated into ACPI, at most we should have something that
> > specifically identifies individual devices only.

> It is pretty convenient for testing SPI bus and that's why I thought
> it would be good to have possibility to enumerate this in similar way
> than DT does but I understand your point.

My intention is to break this for DT, at least make it scream loud
warnings when it's used if not actually fail.

--1PQyblS8X/PkxCw+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoossAAoJECTWi3JdVIfQmcMH/3aXNTw3Dn5Uzl+BQQDa5+UU
+LEp3o9PI5iGbH3LLfBTAqdT+kC7TF7kG8la93W3s1fhDODsPXgeu7+UdbzVihng
3SpHg3TQSdClOg7+liGRV1hLAdTG6BjrqgsBg/sfuwKdb5wsRXTbw4ufzejAsUW0
ED6yZM6jFmuIxXWxVcHKJ4Uyi3DAP4Mn+dyzKhBMYsH3S2zPHc0tvD5wbpPMJ6ds
xC1JKjig32jLo0WytV97ko/KwM3IkiaCZlWm9AXqwpxRN6PLwtEmAAL85mhTtb4a
N2QgTGLmOrtuTnVvba1ZeRUPCw1XsioQLr6IUKksAwcOAKpdp/8Inv4wjT81c2A=
=sYNf
-----END PGP SIGNATURE-----

--1PQyblS8X/PkxCw+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
