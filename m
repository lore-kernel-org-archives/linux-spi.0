From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Kill superfluous cast in spi_w8r16()
Date: Mon, 13 Jan 2014 11:20:36 +0000
Message-ID: <20140113112036.GC29039@sirena.org.uk>
References: <1389531546-5867-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TCH5zSpbvKOKdCih"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389531546-5867-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TCH5zSpbvKOKdCih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2014 at 01:59:06PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
> spi_write_then_read() takes a "void *" for rxbuf, so there's no need to
> cast the buffer pointer to "u8 *".

Applied, thanks.

--TCH5zSpbvKOKdCih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS08wBAAoJELSic+t+oim9tkMP/igLp8pBBbvMLl7syF3nWCLC
Rh+6uWMyIiqUMsWm0cVeAmT34hWUv50laoj9YA7T266SGKxEgZ6UNSRF+4vM81HL
CLchscVhaHXxJjnadbtnOJbMKtSy801BnomcAbfVGKSF6qNVeCt9ci5urb3Jj4p2
EmPtFt1pYw2TpjLEEZv7tSHtMnFgev9XB6TlFuJ6YFtOAQMYH6huK2h6CXbpyK1r
YxSW2GoJta4XG8G6hkzMSVVZTJO8pd2OjEwoJNVpt/vtlJngGI/AElWT/zVKbHbX
Az4xpK4atc76+AgLW6NNeyN7+uEzoj17cvQrtEvLcM6MoXnEFKViCFx4/ksrdcE0
8/zGbRseWlVQvGkZKDRNtFbNyopuiO6KXlD9DCgJSA24vKuk8SgIG8h8FDw5LFKa
NdqFB0vebaWy5yrIdy5Ysilwjsk5YpC6xfNUUDpSzo+W8nUz5Rvbd4O3pPr6Moyj
NTmQIm6D6VOPOnwfsgEgEoPYte72u3+yVqtDR3gwk8AiP809spnuo7OSMV11gffP
RimcSoLe3kikFfOoobXtPXt5n2zgf6gk/ENleyvWss7aVBTQ7C5ArLHmyKCglwqz
F2CPBerUBPrzoliXLqFyALgaY6xINaCiafN3T6SfhDoTSq5BzjuZ/1g6jhcjZEwb
xQXJbkvvNhtJtq3/Lr8p
=aB3+
-----END PGP SIGNATURE-----

--TCH5zSpbvKOKdCih--
