From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [bug report] spi: Split bus and I/O locking
Date: Wed, 3 Aug 2016 11:43:08 +0100
Message-ID: <20160803104308.GN10376@sirena.org.uk>
References: <20160803102838.GA2504@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6aLNMpa4RfPduGT7"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160803102838.GA2504@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6aLNMpa4RfPduGT7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 01:28:38PM +0300, Dan Carpenter wrote:
> Hello Mark Brown,
>=20
> The patch ef4d96ec4ad9: "spi: Split bus and I/O locking" from Jul 21,
> 2016, leads to the following static checker warning:
>=20
> 	drivers/spi/spi.c:1214 __spi_pump_messages()
> 	warn: inconsistent returns 'mutex:&master->io_mutex'.

None of the locking patterns here are new, why is the checker flagging
things as new here?

--6aLNMpa4RfPduGT7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXocq7AAoJECTWi3JdVIfQfQIH/RbjK7TDOPg0PA6tztMz8qis
KJgTxtcIYuEJCzk1I5gJohhAmRqlCgo1r3qxlPHBNGGfEXFUtVIiaOwUXmZiBsUE
9F3bAN26xz393TB6PZohgoNPC/3lJlPpjsnIpJuyfISfFr6Rt9c1+oNLFgurYXtF
yrFqx7BOCJPUjCABtdjOx7UIEUcAyn/do0k7iSw4NqcwE4nVQgxcKqr/c/fLbirM
TFiRLAJFx4SzsPQlIKzQLH9ycrjfqGOAZtcgN4gV4swCPBXWqGPDJlTk6wfc5Dm7
+xJSX3urDEFe0LmJvMxWYVAy5+ZSEFCDiOQZxYXWQUb5qIEi3TmTDVi5Rto5A0Q=
=Amxw
-----END PGP SIGNATURE-----

--6aLNMpa4RfPduGT7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
