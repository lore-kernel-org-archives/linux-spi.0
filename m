From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Setup the master controller driver before setting
 the chipselect
Date: Fri, 16 Oct 2015 11:28:46 +0100
Message-ID: <20151016102846.GJ14956@sirena.org.uk>
References: <1444942305-24038-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bEAlbH1hodbw2omC"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nsekhar-l0cyMroinI0@public.gmane.org, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org,
	m-karicheri2-l0cyMroinI0@public.gmane.org, iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444942305-24038-1-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bEAlbH1hodbw2omC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2015 at 03:51:45PM -0500, Franklin S Cooper Jr wrote:
> Some devices depend on the master controller driver setup function being
> called before calling any chipselect functions.
>=20
> Insure that this is done otherwise uninitialized structures may be
> accessed causing a kernel panic.

I think this is a sensible change but can we please have a better
changelog - why is this the best thing to do rather than fixing the
driver to not crash?  There are a bunch of good reasons to do the master
setup before asserting chip select but a driver crashing isn't one of
them, it's not clear that this isn't a bug in the driver.

--bEAlbH1hodbw2omC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWINFdAAoJECTWi3JdVIfQdk8H/iWU/1wgGtoajLHnPvMSEKkz
zIRtLTy3VN5iDSz28FjtS7khCYybBQ0cUQ+rF8Tup+NwNjat50OVJJGwsvgwy206
GEqq28fr/vwP/Zy7NJT65m087QkU4lfbp2tXkbGrxSLrXNlfQ0ONIy4+uhPHQb4Y
WJ+cyl4GL/FXgHW7J5k3EysA3I87PpISrixY5AboINbiiK5ScgAY0TfFpoP83qLp
lv0/vaxJRFvRMFWhyD9E4GiWF0sAIWcM/svrR/yxhKZ8p+FH1ntBYnGtmhDFORma
693pvcNmOzwhNxmqw3nz0kPtgAU8J7jTsevU/IJQMKczB1Bzoop8pqxwdK4yeEk=
=Q/Mc
-----END PGP SIGNATURE-----

--bEAlbH1hodbw2omC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
