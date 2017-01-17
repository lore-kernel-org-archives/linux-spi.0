From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/17] spi/mpc52xx: Combine substrings for two messages
Date: Tue, 17 Jan 2017 18:33:17 +0000
Message-ID: <20170117183317.if5gl2e6izbkwumy@sirena.org.uk>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
 <5c12cdac-8887-e5d0-ce80-ca4795354956@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7pegqmhrnjpcpr3o"
Cc: linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5c12cdac-8887-e5d0-ce80-ca4795354956@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--7pegqmhrnjpcpr3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 06:15:54PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 13 Jan 2017 14:14:45 +0100
>=20
> The script "checkpatch.pl" pointed information out like the following.
>=20
> WARNING: quoted string split across lines
>=20
> Thus fix the affected source code places.

You should provide more explanation and analysis for changes than just
saying "checkpatch" - it's not a 100% reliable tool and sometimes it
gives false positives or simply silencing the warning actually makes
things worse (as some of the other feedback on the series shows).  It is
better to provide something in the changelog which explains why the
change improves things, giving credit to checkpatch is of course nice to
do but something that shows an understanding of what it's saying really
helps.

--7pegqmhrnjpcpr3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+Y2wACgkQJNaLcl1U
h9CXYAf9HdUT4eJKLlF5JN5pqK8gS7waif9XmiI7E7D/KS3kFih+A1/YNew7BlTH
nxYTneTg4Y7NS13FjRX5TVewBiTCoAG6AidhaZDicjC1PPpbgj0JYUAsxr+A0xWk
TlZD3nYuQz9Kz0esnHiDFJahr9H8RYQtKAphQVcEeqnf9zoNT9P27w8kJ+Ju914x
iPCaqvrz/6v7vDzJUWWJbrA7dbF4aLkSkSoUMjSPNhLJLqtILla+YZ2HWuaUIAsm
AYrdq7k/oSuaC2m8uPWEyYovexxzN4zvvYd0hJi8LhNE9ZiYelg3uy9tFPt8awep
KSfvPsbgJrRQ/uU3Q1uYUxih3THMLA==
=ypdP
-----END PGP SIGNATURE-----

--7pegqmhrnjpcpr3o--
