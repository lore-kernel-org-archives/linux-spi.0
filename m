From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/13] spi: imx: replace fixed timeout with calculated
Date: Wed, 17 Feb 2016 14:22:37 +0000
Message-ID: <20160217142237.GS7544@sirena.org.uk>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
 <1455715739-25161-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K3vkeaB0MlFjg8U+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455715739-25161-4-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--K3vkeaB0MlFjg8U+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2016 at 02:28:49PM +0100, Sascha Hauer wrote:
> From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Fixed timeout value can fire while transaction is ongoing. This may happen
> because there are no strict requirements on SPI transaction duration.
> Dynamic timeout value is generated based on SCLK and transaction size.
>=20
> There is also 4 * SCLK delay between TX bursts related to HW internal CS =
change.
>=20
> Signed-off-by: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

I can't take this without a signoff from you, sorry - the DCO is very
imporant here.

--K3vkeaB0MlFjg8U+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxIIdAAoJECTWi3JdVIfQ1TYIAIS9OjT0D8t4VvxasQCJBDN0
Ah0kGEOSr4MfwIgXtrASkdYyRIshqsb00KeC1ybTKggoPbs9oQfIkACPHqZbCWKJ
mNouxzd3CI/ZPv/QL1Xr+9AhZ/C/R2IJ3pPowzDvHNqT0Wa066MWo6Md6lhHYNkq
GbmRdFEq42/XSvd2bV5jip8UB0ajQzXiseIezuGBwqaSBjISFq1wn0GzSjhdHcvy
w0TDvdCaWeiCndZBdFuYWYgZP9EW/GKZZZ7znQBlcZaONb9iUBi1JDaSHGUJTYn0
QQH9xJpbBB6iCxYGIbnCOBVe98vmrHE2qj1cV2Fu2WT9mqKSMUmXpWQ84uEgYes=
=jJ7M
-----END PGP SIGNATURE-----

--K3vkeaB0MlFjg8U+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
