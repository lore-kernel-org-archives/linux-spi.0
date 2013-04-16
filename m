From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 2/5] spi: s3c64xx: added support for polling mode
Date: Tue, 16 Apr 2013 12:20:35 +0100
Message-ID: <20130416112035.GD26958@opensource.wolfsonmicro.com>
References: <1366015230-18243-1-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	grant.likely@secretlab.ca, t.figa@samsung.com
To: Girish K S <girishks2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366015230-18243-1-git-send-email-ks.giri@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2013 at 02:10:27PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>
>=20
> The 64xx spi driver supports partial polling mode.
> Only the last chunk of the transfer length is transferred
> or recieved in polling mode.

I'm missing patch 1 of this series.

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbTP7AAoJELSic+t+oim9XdQP/0wNHV+zaNIIN8vYWcemetKu
Rseu23iwbu2Aqm+6VhZZk2D4LKyllO4jsm7Cr7lnxEPVTd20gJWG4AggsdEpxzEd
v+FLUHaUMbeVmpjDByIjd1XfqtTWdgHmuVv6SzJJ/LpDTMfH9gOMmD4CNpjiYLEj
5Z6r0ZNjyKmN0NCp3cfjDCN5oyNBz8/w4teHtiBJYAt6HpZywez+Cryy+yQEklAC
IUhjkkKMdtJIrWXCPfou7wZiTUCoE3YWtNKN0Io4qfF+UK3ycJCm5Tl0ZQYsUpWQ
QCQwTmOmW9gLvLg7fQu2VxkKsyRipbQN4ciCMaOoge0fzBvnoHzFmk9ZvvCola2/
bOM6rGTr0n802negxUk0QXiMYHvoOLEBRkd9hRst46VxxL5lwZ4yaE5poFy6/FO5
YbmiVvuUmsoi7EYdSA6hlX0t0DfV3/t9jeqgzoUchB+iiLng2fX4HjOw+JG7mI2A
grNA0h/JFtlZOIsx4FNA7E/ofo/SSCyGXP+SIRDbCI9bL8uf648ZoTzEN8I6fRfW
8crFmijwlLgzqZl6Fgji4YUv0S57qVC/zij2L1nc5pfSuswVEeGSjTHQmiZYPD/n
bq7pfT6Vd+1ysQ/f++SJ09MesyCxfHQhIr6tP8Ir7Ou07MhRNThLq9IZOxUTHxV4
tHR2XYaSLDbyiuODrRop
=zpfK
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
