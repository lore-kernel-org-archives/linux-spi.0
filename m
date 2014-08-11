From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: Fix the spi task hangs waiting dma_rx
Date: Mon, 11 Aug 2014 19:56:29 +0100
Message-ID: <20140811185629.GJ17528@sirena.org.uk>
References: <1407618418-5427-1-git-send-email-jorge.araujo.ventura@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mqg8Hw0aybcCoGup"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jorge Ventura <jorge.araujo.ventura-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407618418-5427-1-git-send-email-jorge.araujo.ventura-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Mqg8Hw0aybcCoGup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 09, 2014 at 04:06:58PM -0500, Jorge Ventura wrote:
> From: "Jorge A. Ventura" <jorge.araujo.ventura-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> The spi hangs waiting the completion of omap2_mcspi_rx_callback.

Applied, thanks.

--Mqg8Hw0aybcCoGup
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6RHaAAoJELSic+t+oim9J0wP/2ZKHWbwaHTI46+iDlF7IJr3
z9uJwcV6loxcFKb2dHhmxweLQriydfGgEu2rMAJ3a4HKt5n0Ti8u5U6K5RwP1RWU
zWoq5wuzz4x1P4PjEiVEAVA5+Zplf+J32N14AU3kmzV9tXkhW02k/HujM9py9X5i
y4lzetTGlMJpWdo9edSn9m1ndTsw61z9ZdCN03FiVujmFGHCbb7M2giyDpv+lekE
lsMVsHFrbvH9UTQP2wK5b+BOr2Ro0JcQY6vcHbEuzKLPcchh2IOMs6EqpV966Ryt
5BgTbB0NMOBCFBSgEpe2H8onjCGqC1I8WGjLjvhs5XU00TkXxa7YCsBj7pL7Uexx
uRv3qeoT2XAJsMmJ6uCSi/Ohb/vzXfJXHtAObrRqNL4F1JhLAmg/0Ei9GphYYIIg
ZIabj9HntgG1uH8j9njsx7Rwl98lNg5axQvA2RUbJ75I22JzVhuAEt8rexWwWqls
HH/4eTDS3k5ym4UO/Zo7uHq8F6sERMHJV8Edxoo8D3WB6n96NEO+N051shxPGuyJ
FEFHsMVctYFaa7nd19/FSR1im3dbzvrm3Al3XQ3avJc4JVlIrS2rQjlXmjAEHvQY
SkwnYgnnIWZ3TgaEhmMPNu9PDht6Uk1coXOXKGvAvRkjOLYnTqCzd3r7EN8dENng
7wJI1wMTekW7JfO3QQtQ
=Wzhn
-----END PGP SIGNATURE-----

--Mqg8Hw0aybcCoGup--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
