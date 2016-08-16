From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: introduce max message size flag in spi_master
Date: Tue, 16 Aug 2016 17:42:04 +0100
Message-ID: <20160816164204.GV9347@sirena.org.uk>
References: <6c95366c-7fcc-ef4c-033a-f9f6e152a669@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+vl+q9EKybVy/Rgp"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6c95366c-7fcc-ef4c-033a-f9f6e152a669-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+vl+q9EKybVy/Rgp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 07, 2016 at 09:47:18PM +0200, Heiner Kallweit wrote:

> As there are no (known) spi controller with differing size limits for
> transfer and message, introduce a flag in spi_master to indicate that
> the max transfer size is also the maximum message size.

This is a *really* cumbersome interface which will doubtless be found to
be broken at some point by some hardware that does have separate
restrictons on both.  Let's just specify the limit directly unless
there's some pressing reason not to.

There's also something off with the way you're posting the patches, your
patch series isn't threaded together. =20

--+vl+q9EKybVy/Rgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXs0JbAAoJECTWi3JdVIfQ30QH/1G10NoEbQojjCdSxsUdRun8
A63pC+L/E9/Pt6T+VRzTY+UESWpn2+IzZxcGZ8DbxrL3R81yEUvy2ZgdMQ9mfUxM
DIdvUbdHHlDoF98FFLGO0tayaGLjMfFmsrkOqdO5mOIhu1N6LICXAbKxlUVKQDr4
c87DLJl1jElUDHJbkiuwY2Kn89phtlwSTqvBu3bHRinMiiWoxliAWioJlX4wpx2p
wbQlV8tWjCoMb2SDvRsC7hLw+Lu1ZYOrik5IKyzECmfe12wsY4gKHNBZbMkujq5y
2ymXOGMOjjW9cpa6qHAAonlPalsxq/RTRCL+42V5r6Vo7G6nXgz6nPtvOQx8dDE=
=HLhb
-----END PGP SIGNATURE-----

--+vl+q9EKybVy/Rgp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
