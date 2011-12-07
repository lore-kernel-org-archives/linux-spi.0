From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] spi-topcliff-pch: Fix count calculation issue
Date: Wed, 7 Dec 2011 21:43:44 +0100
Message-ID: <20111207204344.GC3744@pengutronix.de>
References: <1321511841-12824-1-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kok.howg.ewe@intel.com,
	qi.wang@intel.com, joel.clark@intel.com, yong.y.wang@intel.com
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1321511841-12824-1-git-send-email-tomoya.rohm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 17, 2011 at 03:37:21PM +0900, Tomoya MORINAGA wrote:
> Currently, count value is not correct more than len=3D8193 like below.
>=20
> len	Current-cnt	New-cnt		Anticipated-cnt
> 4095	1		1		1
> 4096	1		1		1
> 4097	2		2		2
>=20
> 8191	2		2		2
> 8192	2		2		2
> 8193	2(NG)		3		3
>=20
> 12287	3		3		3
> 12288	3		3		3
> 12289	3(NG)		4		4
>=20
> This patch fixes the issue.
>=20
> Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>

Which branch is this patch based on?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7f0AAACgkQD27XaX1/VRu18wCgieyMu97KZviV7ovGE8MjlVzu
nj8An3SOFxGxtu0td6qHmvohCm/abNiU
=Xqwo
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
