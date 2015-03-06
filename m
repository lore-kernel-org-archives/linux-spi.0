From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: pl022: Remove incorrect TxFIFO full reporting
Date: Fri, 6 Mar 2015 19:44:41 +0000
Message-ID: <20150306194441.GR21293@sirena.org.uk>
References: <54F08D79.6060708@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P/Sb79LHiDvrIqvd"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54F08D79.6060708-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--P/Sb79LHiDvrIqvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2015 at 04:30:01PM +0100, Alexander Sverdlin wrote:
> spi: pl022: Remove incorrect TxFIFO full reporting
>=20
> According to PL022 specification, TNF bit states for "Transmit FIFO Not f=
ull".
> So the logic here is inverted. But "Receive Overrun Interrupt", which is =
handled
> here, is only triggered on Rx errors. So instead of fixing the if stateme=
nt,
> remove the whole message.

Applied, thanks.

--P/Sb79LHiDvrIqvd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gOoAAoJECTWi3JdVIfQWSAH/ixsGRQL8y5mM7MpO+mL2OUZ
FtR3Jb5DUPUDeDUFNl0Ho4PTdwKYvmJf2O+b9Zyf986FLlhv2IegyMATinKiTUWS
mUoczx8YWna4WfXYW9PokrXu8SR2dT/uZuWRAtA+iZESuhbq93/TvFG32wVOHZ9S
l74m+vUFpk5NkYHNGsr+9dxmnpXzOjuNT3xLpeJXDvzx9bwMU/cGvsgE82Q71TYk
nmgjR8Da7WEMFS3mU8nmuAyQ6Iq89lvNBv8JU9nC8R5UNMydMQnY2YtIZs0s47qn
I0SI/qLmZQjmkyqbqmTk2T3FUFKJ3DKDBkeLKt+Qt5JZL70L1nEMfcUq/3yD7mY=
=XQqj
-----END PGP SIGNATURE-----

--P/Sb79LHiDvrIqvd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
