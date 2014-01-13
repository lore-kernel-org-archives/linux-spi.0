From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sh: Use spi_sh_clear_bit() instead of open-coded
Date: Mon, 13 Jan 2014 11:26:40 +0000
Message-ID: <20140113112640.GH29039@sirena.org.uk>
References: <1389578444.18562.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nCRcqX7cEx7rr7Pe"
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389578444.18562.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nCRcqX7cEx7rr7Pe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2014 at 10:00:44AM +0800, Axel Lin wrote:
> We have a spi_sh_clear_bit() function, there's no reason not to use it.
>=20
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Applied, thanks.

--nCRcqX7cEx7rr7Pe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS081tAAoJELSic+t+oim94VUP/1tuPcfWCzaE8AyJOity+StV
gq8UyG9vA2sBJ+mRBkSK1uqflXjlGhHxNzk4LoCosxcYPbNzLzLiU2vGr2l045YO
hkX4MuOOViykBkdHpRGkqrwwBc8qzW3HFFcWytPPpo3xtRZnfDxNPAxpm1+Ek0rx
4S6c+fGf3q0FYmioTiYwWk61yKxLqM7F6MN5k56BZqt2qhYtP2qbckAPTymh8CSH
t987JMD7daO3VW8CUE8EXZsf0SdNjyLGA1Nx7pe9lrnjSTCEm+4i7p0740ANUWH6
vRaf5f4iLhT67dbv1C2dSZ8EzKpo4sk6s5PbbFGFCJkICgEEakpxS3jWwkENaU6J
QtdIn8POTk7ritnwJ+AwDUN5aE3b78aXSfrAPnKxor1ZrCJJycto533HdPZmKjCi
zry2B4scsTJC9NrQfxTyZ3g7fSMdeL072qE9utAX2bLw4iAZT0ofLckqINIhTZA5
Vulqb7VuPy1+FlUw6wL9yDULfqXljbj4xeb1JVwG3DhzSjwgte+JqPF3ULQpDXib
cajWHYu6kGH88F+/MMyqWXmqxzURV8yb6LIukzpaBCZOWOqOjGVyZg4Bsggs7I8n
nUETwXKX6b4ob3qKxlZH9E1P/pkZGS8KlGtPSG0Pwb+go/h2qP3Da4lzGPQ1ragh
sXuGiYHWriMgMGDDB+V0
=/AA0
-----END PGP SIGNATURE-----

--nCRcqX7cEx7rr7Pe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
