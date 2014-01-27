From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/14] spi: rspi: Add support for RSPI on RZ/A1H
Date: Mon, 27 Jan 2014 20:07:04 +0000
Message-ID: <20140127200704.GK11841@sirena.org.uk>
References: <1390553044-11860-1-git-send-email-geert@linux-m68k.org>
 <1390553044-11860-10-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qp+4iQ/pA/lPyvuI"
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390553044-11860-10-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Qp+4iQ/pA/lPyvuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2014 at 09:43:59AM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
> Add support for the RSPI variant in the RZ/A1H (r7s72100) SoC.
>=20
> Main differences with RSPI on SH are:
>   - Lack of TX only mode, hence we always have to use full duplex
>     transfers,
>   - The Data Register must be accessed used 8-bit operations.

Applied, thanks.  Ideally (and hopefully soon since I have a use for it
myself) we'll have a feature in the core which automatically provides
dummy data for full duplex mode but that's not a blocker here.

--Qp+4iQ/pA/lPyvuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5rxlAAoJELSic+t+oim9MJ8P/3JnXjKPwVylMkRRbNuD6+SF
/Br4AtAovVFjNpr0vVJ6bcsZzDfpoLwvSWDKkfzZcTqWukpk4rKZILfwCCtX31FC
sDHr0IiimYhv8S+TgycspRWy0aj4lNsycyP19iCnaZ2WSJzGuDm5qVbBrYXaLR2y
Rh9tq4E0DlCoJhPN0PUyl/a2BU5Hf5qajTuzfki2+OyvaLJPA9XGxqzaUDd7xk/l
4xNRnOk2kw1v9bbXN8n+d2v98Xiv6dEV7iQTf+ZHhI8+6I3PYsGY+zrvmHYGu3pi
qE+WmKgPKkgNBHR7hMQtqNCaC/frf3DyTpzpaQ79gIm9vB+9sntRvkh2/h0atSF2
L6cVghdxvuDJaMeBw7OifvpFI4pxDM9gHW7U/XuGJDitv+n0z8EkmRpbr4ePw+Cy
Vu9x/Kjnc5233m4it8UhBJ8hDOBUGVKtDywEMSLRd1XCwz8Z48KoUckzV4c42epB
Rih08+mseJajj5fGmUNK2YMEWBbm9EsW8lK1FmJTfBmXrPgHmLeB19y5DMrvkHwy
tGC9SlbtG1K9UQNbAmnqP6LGPMqoYj26KJ0p3XKHBL74Rr0P9MGbexMt9pfDu3bR
6NO3qpbHbRd7nxDjK2qs90rMIvToobBZN4njp0Eao2VxatZBrXNNLWextDiE94Vo
r9NcCGr3OjvVzvNTQIop
=hCE6
-----END PGP SIGNATURE-----

--Qp+4iQ/pA/lPyvuI--
