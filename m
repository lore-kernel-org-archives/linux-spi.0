From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/23] spi: fsl-espi: pre-allocate message buffer
Date: Thu, 1 Sep 2016 21:12:34 +0100
Message-ID: <20160901201234.GQ5967@sirena.org.uk>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
 <cabc3522-8ca9-516a-e0ef-5a2ed9ad8507@gmail.com>
 <448706fe-fd0a-7a56-b37e-0500c3ed4c18@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <448706fe-fd0a-7a56-b37e-0500c3ed4c18-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 06:44:06AM +0200, Heiner Kallweit wrote:

> Original author: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Why is this not a proper signoff?

> -	espi_trans->tx_buf =3D local_buf;
> -	espi_trans->rx_buf =3D local_buf;
> +	espi_trans->tx_buf =3D espi_trans->rx_buf =3D mspi->local_buf;

This is regressing the coding style, please don't do multiple
assignments in a single line as it makes things harder to understand -
the original code was better here.

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXyIuxAAoJECTWi3JdVIfQawkH/Aoty7co0sx1MlUhlwrtY+l4
bpmal18eN4HP9iqnttPfG+p2Fv+wYJ6madvOvOtTz98HR3Cnd9eWzXSmAsjulneI
F0NgK6t+pIVD/x1jNI5y2N2KIw8tG5rmD/NZMbFYIM7U0SK8xeSq0sPVB6bzE3qS
MPOAeGtcA8ffPNGmUPisRVs4dP4/fIse8WiP8d8jfonxPQTm/vs9CIAIrLttYBtz
YOK1fc/lcb+cTE4Cb1tOH18i2HYDZjgb55eTZoipS56FSaIbsi9tfm0vbZgPCi/y
LaWfJFhjgcu6aMgl1ZinxzDDotxdJELZcQg6z1OoUdBOhkUDbCLDoB3G10sFgmQ=
=IVsS
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
