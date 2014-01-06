From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dw-pci: fix typo
Date: Mon, 6 Jan 2014 12:11:15 +0000
Message-ID: <20140106121115.GN31886@sirena.org.uk>
References: <397a6e6c794c4445150c823510187775b17e9c29.1388992893.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CMSRreXTSU7rpCqF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <397a6e6c794c4445150c823510187775b17e9c29.1388992893.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CMSRreXTSU7rpCqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 09:21:33AM +0200, Baruch Siach wrote:
> Commit 04f421e7b0b10 (spi: dw: use managed resources) introduced a typo in
> struct field reference. Fix it.
>=20
> Fixes build failure:

Applied, thanks.

--CMSRreXTSU7rpCqF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyp1gAAoJELSic+t+oim9EMMP/3hPoJt3dDZGzI8rxbUj4Oxr
MVhYc+ZvbEb398r9XQYuFyL8On5rlUUi+CJJ5siFcHhF9jJa+qtiYhXo1NfVQ2AV
4xbD9UGvTmqx7QxDsM2on2dqgqJyDLN5gnemkP4bMh+Dzdyxw+e0W7xw8+phMt/x
9VUZREvTt0IskcjMVpRr9i4i/0k+R/rayp++8cbd187mOBvdDN3CgyONIp5kJ2nX
b+57ZYhoGJ4ERjWHZUw5/IDOsJ0crMCYFCZbzJtUxMjqqSf5TVTUSak8fNbAq3Zo
bOWvOCPRaNElHfxZvQinAkHEk0GaM1v0WQKsxinsIKYkeZuLRfwx2bQGsaDWcH10
npgNC+Sd9ZYtK7uazCbbnWEHTfGovZzQ3hsuBpusytr1usxEIdnIGtVDNtMiyvyt
kfPwzYixnM6AITIuJaLFmgbGyYtt2fm49Wrvi20O8UE7A5b6dBPwQxM+gEY3ckhV
C6G0OcCsWBi0qMT/zGJXNpK4sLoPaEwdXaIb917ybIKp0PSObWqCiZCKOH4XUt9W
Qw7JgrC49HZohBj5QDNid8KNh7t8Iloy9RjbH+TUufnsInlbJ5hempsKrKqX7Ssb
Z9VvJyoIf0LBnjVbL61ohFkd+LFQovEj0fn4ZlAH46g2zNRQsJ7P6Vspb4jjDYIV
Zwy/CS+p2YG2TKdELadF
=zl6g
-----END PGP SIGNATURE-----

--CMSRreXTSU7rpCqF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
