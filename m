From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: sun4i: dt: cubieboard: Enable SPI0
Date: Thu, 11 Dec 2014 17:57:54 +0100
Message-ID: <20141211165754.GF8739@lukather>
References: <1418033642-29731-1-git-send-email-mr.nuke.me@gmail.com>
 <1418033642-29731-4-git-send-email-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gVeFDRGtAQ0W7qcm"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418033642-29731-4-git-send-email-mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gVeFDRGtAQ0W7qcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2014 at 04:14:02AM -0600, Alexandru Gagniuc wrote:
> Only SPI0 is enabled, as the schematic denotes it as the only SPI bus,
> while other pins are reserved for different peripherals.
>=20
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--gVeFDRGtAQ0W7qcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUic0SAAoJEBx+YmzsjxAgZLQQAKYk+evblGH+D6JWjDwwdrdg
R9xlPXDl7D7NKiwM2xTpwrtKWfPFcP3UwtoMqNr+DIbi/nAcSCJn/AuQ5l7EslBA
ZlLR5q29ETophZ212YIftxl6fA+dkw2+Rwj+Cf5fxKsW82+RakOaOqf15TMYsTNM
bRYpe27qzVMOvW5A8mJetLDktHCWy+AUoLlc51ty04WuPrVy8RIK74xfEV9fDbFl
XwS3Rn8Kt69KKaW9SPbdDrs4PTLBqrrRgDyYqq+BttR+8wW6TJLJPLSFEj2k9gcm
m50cA9QSpyS2YhBhuAt1DtFOBs5SOqwwV4F9yueiXafKYH59a3q6rGwdA0M6m6Tq
PzgpNWaJ/FbZuzLg/WNG4ncAvkQE/z5WhXpwi5HFaiylubMIGve4/IjFu0kAMZVK
BGs6cw7ksR28WSTaRvvC/GHjvUSl9JeJBVSdAs+W56mVmEeU8HwOJUGrMXsQF1O9
9Wyx7Yp7ZBn5UXhNVbETbT3jHGHCkw9nEZBagq56YpfQHOKx9PFBcqRKnT5O38VC
IQa3S/5+MKb7IN2R2fegvJZQ3OsGL57LaeFS6kL6fVopIWClfqJ8sMS+/O3XS3u+
FJ92u5PIlfBYduPZXErcnc826ZcopMekMPk27HbO+qo2q5EYpu1CJZXJxUCXlQ5g
Z6TMyj3skHPNtze1Bgz6
=kDRm
-----END PGP SIGNATURE-----

--gVeFDRGtAQ0W7qcm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
