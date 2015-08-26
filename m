From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: fsl-(e)spi: simplify cleanup code
Date: Wed, 26 Aug 2015 11:58:57 +0100
Message-ID: <20150826105857.GQ12878@sirena.org.uk>
References: <55D9BAE1.1030306@gmail.com>
 <20150825174508.GF12878@sirena.org.uk>
 <55DCCDD7.5030307@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MXxcbiX/Q4+iy5U7"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55DCCDD7.5030307-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MXxcbiX/Q4+iy5U7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2015 at 10:19:35PM +0200, Heiner Kallweit wrote:
> Am 25.08.2015 um 19:45 schrieb Mark Brown:

> > You should be able to remove empty functions like this one.

> In patch 3 a call to pm_runtime_disable is added to this function.
> Therefore I don't remove it in patch 2. Fine with you?

No, just re-add it when you add users.

--MXxcbiX/Q4+iy5U7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3ZvwAAoJECTWi3JdVIfQh5AH/1YKsK+vzUlX19NUPX+i5iNT
jYxNr7PFUt0fEGl6EjSjnL0evKAfRpv3Lxy0JjP2iQ/nsu9Zaqki/kIAw1ET+hht
bPSIPsKSj6BCAEK54Sw/3Ch6KawkF5UcCBNVR8d/u9ovJGIODoI8N4SkDie3XPU2
/bEEekHCBoGHrHlX05VPcnHyDuHaAQ/CvWN0Y7qalJA7on5JQvw9bLkyXrWjT1gC
gR7PYVyXmLmoC8BnEFo7uIYkI4hCvvgIQNSUd8B3l8ex3kRqqnKrv6F3VdD2avoV
yzV8d8MWmLEIEF8ptgCL2il/BP6L3LmpPIiAIZpL7UjcIJ85GGtD3WtJ04xOFJc=
=dJIK
-----END PGP SIGNATURE-----

--MXxcbiX/Q4+iy5U7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
