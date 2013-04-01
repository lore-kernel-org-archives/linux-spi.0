From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] drivers: spi: Use PTR_RET function
Date: Mon, 1 Apr 2013 14:33:26 +0100
Message-ID: <20130401133326.GR18636@opensource.wolfsonmicro.com>
References: <1363252698-29500-1-git-send-email-gheorghiuandru@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GDLQamdgIxhPcIwq"
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363252698-29500-1-git-send-email-gheorghiuandru@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--GDLQamdgIxhPcIwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2013 at 11:18:18AM +0200, Alexandru Gheorghiu wrote:
> Replaced calls to IS_ERR and PTR_ERR with PTR_RET function.
> Patch found using coccinelle.

Applied, but please always use subject lines appropraite for the=20
subsystem.

--GDLQamdgIxhPcIwq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRWYygAAoJELSic+t+oim9a74QAIO+adbsA4QYPNlHiAonA7i5
npZlTxjGHxZhhafT5RQlkOGQupEdEe2eMoNdg08f9Tkf4zZK8upTeWhlZ5pT4Mc2
5TXMMw5cfXIlBTPRLf8G5XUwl52wT41V/BqjqNCg6RqbRifIcTYqNk/rXvfBYUaI
OgQgtrNDEJ/B3G4w7td7tXKF+mQYeeKvha+OeEBeDl1+O/xHtNK5fvPQMgr8jxFu
zRNIPLIH1YfnLDxbwT6L+IvN8Wls774A4Py2kBU7vQC9MOaL48Q+LNJDZwi7WrP0
Qu4mGqBW8URwxkfaiXAwE1AZ7S16S3s3KLUOzBkkHrkOFEMZKw34QsRnqor4gyG7
Qsws1rqjF6BHiH6fyrFYk4Cnh9l/wCf8oe+LZsKa17Icx2ohrcbvLkVxuepEp2J4
UDJSHpH2fjM5PYpw+ZJbQTsZleR5o5PtHXS5JczhuJlXuNdUGfznXh5/IssIpeMf
HQZLvYM7SrO/jNGSr6dsw4nWsnNoIYPhpeLKxjfazPEqi5hgz4JHluZxpOwkuYLh
5p+KZa/MKizDWPkvC3+DO9yrHcXGt+GUmzIWCtml/b8bYvc9PLJC7KQpXI/jmHPc
QHc6efGL7sZikJZmPZBhFt1nboD77yyeyFG/GNQoc6Sr/CJNX4R0BAQt6NpFstpq
dW8i2uMFqjXx+EVUyB6f
=65m8
-----END PGP SIGNATURE-----

--GDLQamdgIxhPcIwq--
