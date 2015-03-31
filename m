From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/1] spi: pxa2xx: missing break in
 pxa2xx_ssp_get_clk_div()
Date: Tue, 31 Mar 2015 15:05:56 +0100
Message-ID: <20150331140556.GQ2869@sirena.org.uk>
References: <1427809778-99984-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uMNE0C2is0k/ADx7"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427809778-99984-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uMNE0C2is0k/ADx7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2015 at 04:49:38PM +0300, Andy Shevchenko wrote:
> From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>=20
> We refactored this code but accidentally left out a break statement so
> QUARK_X1000_SSP isn't handled correctly.

Applied, thanks.

--uMNE0C2is0k/ADx7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGqnDAAoJECTWi3JdVIfQVZsH/R//CFJzwrE3GNMLNMJUb52J
OS20sMFGwo2zyChICUDuarmqdFHxiKDgm03i5TT4kTi4Irq70XH+vb8mZ6rqDS56
xchuLj2CtoTx2ReWMaCp0/O3or8EEhbNk4lYP4q2U1MnXok+X6OzBOFY2kQ3M5sp
98Svd2ysrkDT3+28cJTadG3fHTs1KaTU98R08x5q6ZUcABRF6KO7LnxnWxNfoS9t
W8SddM4YQCiE+rD6AeRXvM4TaPd149ivm4b8m6E2tdl87VSmXD53ZKcNB99JGEeC
qdwPheYg4mVE4Hqo5ASgINQ4cZsue2dRlHQNUykvjwnxMaxlYtHHtBGR+1CIzSk=
=VEgi
-----END PGP SIGNATURE-----

--uMNE0C2is0k/ADx7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
