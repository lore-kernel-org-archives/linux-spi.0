From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/5] spi: sh-msiof: cleanup wait_for_completion return
 handling
Date: Wed, 4 Feb 2015 20:53:03 +0000
Message-ID: <20150204205303.GK21293@sirena.org.uk>
References: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
 <1422865837-10357-3-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q1fIFGkghhj0JTDH"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422865837-10357-3-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Q1fIFGkghhj0JTDH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 03:30:34AM -0500, Nicholas Mc Guire wrote:
> From: Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
>=20
> return type of wait_for_completion_timeout is unsigned long not int, this
> patch uses the return value of wait_for_completion_timeout in the conditi=
on=20
> directly rather than assigning it to an incorrect type variable.

Applied, thanks.

--Q1fIFGkghhj0JTDH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0oauAAoJECTWi3JdVIfQnu8H/2LVx5f0f67KcCU4wgsb2XMF
5GLHT11z1nXBgKtR+ptGpW8xgVy5osXsXXd5RYL9aLpbewRkoqQvex8w0TMqhIcV
rynbeIaFmbFiyMz8oi7803ZCkoQzGcb9xbIp/H9ISKpxuaVHoC1QXCJYk97lhIhq
oaEmFQoEeyJ4QZINDGOeQWbDEUX4X2z3xYyO+D7mUDWiaU2ZmCi9kkmycasOKyUa
bISOnf7QQY3dSgj5PilgboyHZwSmqslt8aEzCtmiGfA/jynOMP94c836NKLccR5r
qx9YuKtA8ZK7BF6zhLMa6jW5cBTg78N2CGtirOGw2gXDCKm8iEcsYORIGmjEJYo=
=FyGw
-----END PGP SIGNATURE-----

--Q1fIFGkghhj0JTDH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
