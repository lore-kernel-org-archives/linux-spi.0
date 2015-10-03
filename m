From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: m25p80: Commit "allow arbitrary OF matching for "jedec,spi-nor""
 breaks module autoloading
Date: Sat, 3 Oct 2015 22:35:44 +0100
Message-ID: <20151003213544.GA967@sirena.org.uk>
References: <56103D97.60906@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56103D97.60906-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 03, 2015 at 10:41:59PM +0200, Heiner Kallweit wrote:

> Seems like commit 43163022927b6e7d202a7e6f939c3f392465494d
> (allow arbitrary OF matching for "jedec,spi-nor") broke autoloading
> of the m25p80 module.
> MODALIAS is "spi:spi-nor" and removing "spi-nor" as device alias
> prevents module autoloading.

You probably want to ask Brian or other people working on NOR about
this - I'm not entirely sure why you've sent this to either me or the
SPI list...

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEEoqAAoJECTWi3JdVIfQzG4H/2AMK4Kmq2748h+GIZCDBY40
SBjScv8XHu6z9Ox9FYMUQAJAUVLk1clmWZ6H/W5bLn0ovOe0sFshL+d1iVppqwJU
YwfSr6erFfeUatf/c3gtmtgU1XYmU48sdhHRhJhy6tQGlMKUzfYc7YIp2qDdJ+Ul
GyyCsdkWw0KpVT1/nP0UQmXmcVEbIWvILZ5fim8cmYdNUJewqJIDzbrS8TjUgDr4
FRZZHWRoLEEXpbU1a11bHYgSIB5qz1m9b/bXaV+uzSQ6f3zPFw+7Q6O4Wb4mBsZn
r4glVKHApdXS7na3QqMPzjGWA1W0+smb8hf7I63s36GfORFSWvO/FlIJZyk1sF8=
=KDHH
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
