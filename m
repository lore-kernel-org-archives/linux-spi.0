From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Fri, 22 Sep 2017 10:26:21 +0100
Message-ID: <20170922092621.uq2xsvxangeetewi@sirena.org.uk>
References: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qq536yoti5x7j5ze"
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ed5b8ca2-b853-755d-2801-57cc0b626508-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qq536yoti5x7j5ze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 11:02:31AM -0700, Randy Dunlap wrote:

> spi-sprd-adi.c:(.text+0x3ee): undefined reference to `__hwspin_unlock'
>=20
> v2: allow build with or without HWSPINLOCK, but restrict to =3Dm
> if HWSPINLOCK=3Dm.
>=20
> Signed-off-by: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>

Please put inter version changelogs after the --- as covered in
SubmittingPatches.  This still seems like the stubs aren't doing the
right thing - if we can use hwspinlocks in a module when they're enabled
I'd expect to be able to build the stubs that way too.

--qq536yoti5x7j5ze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnE1zwACgkQJNaLcl1U
h9Cp1wf/cG2IeJDVyZ6Jd15eaSp2FKhFjsgCKZ6uUisBrI/I4zEX9r5c2xIRoeAb
X3ZW6tZl+yiyB2o+49P+qKttKXB0JJWVw1ZnUoK+QWzhP4ZXr1ua+21h70Aq7ECD
LCMntStzvPfy0PYewohcOAuL7u6QqSoCbxXJ/f5rTUTtFkTPY7AfrXjNDEmCe794
F81H9EOJOYYSl+/HqG+16nTXJHeUPf8rmWkTXzemjhno6ObixfJk1LUIQkreJape
IEG0f9lBafTriebcefwxttGKkvdyna4oCqQSOv//U9dqUweQ48p+3rJNVVSRPkJr
9wWttDmYf73onFTiBthGmrt/9IGLhQ==
=xZDt
-----END PGP SIGNATURE-----

--qq536yoti5x7j5ze--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
