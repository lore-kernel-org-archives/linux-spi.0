From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/14] spi: rspi: Use core message handling
Date: Mon, 27 Jan 2014 20:02:33 +0000
Message-ID: <20140127200233.GD11841@sirena.org.uk>
References: <1390553044-11860-1-git-send-email-geert@linux-m68k.org>
 <1390553044-11860-3-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EcSFpNr6Vcxykj4g"
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390553044-11860-3-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--EcSFpNr6Vcxykj4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2014 at 09:43:52AM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
> Let the generic SPI core handle SPI messages, calling into our
> rspi_transfer_one() method.

Applied, thanks.

--EcSFpNr6Vcxykj4g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5rtWAAoJELSic+t+oim9TMMQAI05p/OChjqFN7PhEjOwTXmv
SHFif3a5jFkp66Dz+plErgVQ5Jwozkuvo8jDh110xRtxYoO4YrmzN/w2/oNyRy86
QSAd7+WqA+lFdOKoQKmUmhBSuEVmlHQpsesoiy00HMA0DdCCKl17oNbMf9VbKjKM
yuIUSo++KcLjJK9ekvre25QaU9lLijQKiXzbVSq6IrnVGG/p2g7JtHtyvAqXMM+8
lM9mvJDsPjo7CXBm6KO6Y2GcPiyU4i0GuQYV+b0ER0O5wj/By7oWLIaQA3dEkaOG
SF8+vnVmWKH8ZdkbNLoAM0ibetLSLbKpB0aTswbGwBFjNcaW8wgiFHO6XKnjZF+E
vLlcfdxDaldQOVdz+UrZ3VHIpqUQDXjlYsoUkutauoiYvABVe5dmLh5V1PoF3Tbu
XpT+aXM6EvQH4UBrujjSthTZYvH1xa/zHpVQDdhYUj8vncx1NgEX9hLeiK4axLCF
X60J2krJLkWItu1gO3fpaqCQcE8Dhzl0p2GAf/h7Tbn5V0e6sET8vmibdDILcGK0
8zbTXTEb5dW6IJV0k6RPpABAsi+pnRdUuDKOqEsv1nLsYprSJePfCQCMFJnmghwT
b+6riQr2L4/qUyPsZExGk/6TFDAqK8KbLN68HwvpN5Br4Aa7jgqav1e0p14UnJbS
gimin8oPc4cQEWYz54zm
=l0Wu
-----END PGP SIGNATURE-----

--EcSFpNr6Vcxykj4g--
