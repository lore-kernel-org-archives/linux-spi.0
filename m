From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 18:39:22 +0100
Message-ID: <20150513173922.GF2761@sirena.org.uk>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513171300.GD2761@sirena.org.uk>
 <20150513172028.GA18303@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DOr+hlVy7JMLa9bO"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513172028.GA18303-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DOr+hlVy7JMLa9bO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 10:20:28AM -0700, Greg Kroah-Hartman wrote:
> On Wed, May 13, 2015 at 06:13:00PM +0100, Mark Brown wrote:

> > So, that was my original suggestion too but people were complaining that
> > this wasn't a generally supported feature and requires specific support
> > of some kind in the bus (which nobody posted a patch for).

> I don't understand the complaint, it's a very "generally supported
> feature" and has been there for a very long time for any bus that wants
> to use it.

So it's not something that just works for all buses and someone would
need to write a patch (hint, hint - that's one of the big blockers
here)?  It is a bit surprising to me that this would be something that
the buses would need to cope with individually since for most things the
matching mechanics are taken care of in the driver core and we're
explicitly overriding them here.

--DOr+hlVy7JMLa9bO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU4xJAAoJECTWi3JdVIfQfgIH/2U9reWKR+eGRWDNpwm1Slvc
u9ACTKWf0z8m+8tXctrX+pxbjE22CzaoYCWvkoFjp8WKcbEJf7tHmE/YpspWaYXL
mFQzyo27DZ4IieHIbzeVUyh5Q18kL6GxBjImfCoZLq0z7Yi3rcS2IL1xK4n9v2LD
Wl7/Ttyi93HGjPgQ9oUDe+soSl0aa5O0dMo9t75P4dEgoBekS/0L4WT/XGOZv+46
/XhAGtfOQMg4HVvYTUpdCv/66mWiC32NoRq16kLqb1Vi0sd13Zlm2JXL2HDh1Cn7
0lE9/d8kcz/WnDadA4IG4P7Lzi/LzB4IU015DVmiAkiM3OfnalfBmxYoLA1mFNE=
=6uiH
-----END PGP SIGNATURE-----

--DOr+hlVy7JMLa9bO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
