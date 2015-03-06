From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: pl022: Fix race in giveback() leading to driver
 lock-up
Date: Fri, 6 Mar 2015 19:49:47 +0000
Message-ID: <20150306194947.GU21293@sirena.org.uk>
References: <54F08D8D.5000705@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lwR2mBJ7UDqzn7Ff"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Wilshire Jay <jay.wilshire.ext-OYasijW0DpE@public.gmane.org>
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54F08D8D.5000705-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lwR2mBJ7UDqzn7Ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2015 at 04:30:21PM +0100, Alexander Sverdlin wrote:
> spi: pl022: Fix race in giveback() leading to driver lock-up
>=20
> Commit fd316941c ("spi/pl022: disable port when unused") introduced a rac=
e,
> which leads to possible driver lock up (easily reproducible on SMP).

Applied, but a few things:
 - Since this is a bug fix it should have been the first patch of the
   series rather than the last.  That ensures that fixes can be sent to
   Linus and the stable tree without any unneeded dependencies on other
   trees.
 - For all the patches in this series you've duplicated the subject line
   at the start of the message body, meaning the line gets duplicated in
   the commit.

--lwR2mBJ7UDqzn7Ff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gTaAAoJECTWi3JdVIfQX6AH/1k6bZ8/XnDjyFzMVzzcVaf6
4whD7dfzr5WYNu4CD8Ze7c/ezLZp3oCi0GVaBgPgkJotC0Uy4HbpSqwQDVtc0kzs
BugyyeXxBdPDVwuIpcELw0AXXJVVtaphu2IXerrl3vttWyuoRcqm5YaTBrlkukvB
T9OtvgOkeXZ4zhnhejPC8kna+vaOgw9jI1tCf1LiD7tYWLcXYdIu0+1YY2Hs4H9h
EQjk/oduPdvse3RDXb//ONS8xYVZdIuRoTNYRnVwG7sUwxBpswzk1p1Ip7UpuVzx
N5P8ufRUZJDkP0P4K3ZZ+VpfGf6rPMK4+nqD5Bje2RD/oXu7GN+4oaYs+8miWlI=
=MwIe
-----END PGP SIGNATURE-----

--lwR2mBJ7UDqzn7Ff--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
