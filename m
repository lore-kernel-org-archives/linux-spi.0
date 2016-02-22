From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Doc: spi: make xmldocs warning caused by spi.c
Date: Mon, 22 Feb 2016 23:03:29 +0900
Message-ID: <20160222140329.GF18327@sirena.org.uk>
References: <1456140824-15744-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q935UqjMul3XuJv7"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456140824-15744-1-git-send-email-standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Q935UqjMul3XuJv7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2016 at 08:33:44PM +0900, Masanari Iida wrote:
> This patch fix following warnings while make xmldocs.
>=20
> .//drivers/spi/spi.c:2354: warning: Excess function parameter
> 'message' description in 'spi_split_transfers_maxsize'
> .//drivers/spi/spi.c:2354: warning: Excess function parameter
>  'max_size' description in 'spi_split_transfers_maxsize'

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--Q935UqjMul3XuJv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyxUiAAoJECTWi3JdVIfQ4hYH/RZ+mYQcwVS/2DdULTKT335m
Ah5uwHJOjDxZ5V902CC0c+/Wxmfhm6ZazcDINwKC54d/zEYw9XpgrHvO/tu10AqU
5xk4MU9fKCaW1B5PkL7bwJ/74qt+UBkOMJuoXH5falVj6oDeynS35iRnRukqTLfc
7VGcWK+vjLceuny8WGXG2L+I8KljjIXq5ABFRmYF4qio6OOqMg7WDISMQ8fk9bhp
Mg1aTeXlDPPD2utX1XBQtaeMPiXm+05Si1F6/VfMzAq5xy0ixC7VElBXKAyClCVV
qF8YJS2fi5J8a1EBM5t4U9JNE3GCkm+tCX1w7l6QhUkcuUYdY5Bu0BDKXfe2kKE=
=XbCL
-----END PGP SIGNATURE-----

--Q935UqjMul3XuJv7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
