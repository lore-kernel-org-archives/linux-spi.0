From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Do not configure the controller on
 each transfer unless needed
Date: Mon, 3 Feb 2014 18:26:01 +0000
Message-ID: <20140203182601.GI22609@sirena.org.uk>
References: <1391354652-32092-1-git-send-email-stefan.sorensen@spectralink.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUygiN5FMnIY1JbD"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan =?iso-8859-1?Q?S=F8rensen?=
	<stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391354652-32092-1-git-send-email-stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SUygiN5FMnIY1JbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2014 at 04:24:12PM +0100, Stefan S=F8rensen wrote:
> spi_transfer->speed_hz and spi_transfer->bits_per_word used to only be se=
t when
> not using the default settings but are not set on every transfer, causing

Applied, thanks.

--SUygiN5FMnIY1JbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS7982AAoJELSic+t+oim9YlgP/1YhI7lktatikbrsXU0/79R5
LdZ1UhnHSDRmXVaqTS0VE9kQe9Hd5B+hw3d57d65Yv7W3uR0OWaB7XC/Vgv2H/C4
WLeUjqWZWSer5pFUPSlMdpALdNqdFb/K1ErOtN8Mct4FhtKQ68zmLgqdj1u9LWHX
dahN82tef2umR5Eu0A2f2HRqER+DfCBE6R6WKz7LqLOJM4SZQ45j2wpiqtS0I0ca
r/pkyvmF808cPI0x4iNX/DN9kQl/RTbhEN9ZzGB5KYKnFhgYaSvk6Kas1H+QmAxJ
GHDf/0p0PVdnUJVrWLa2wGOpfhCzJDI9iYAgcniogM1vbNqlJRtwoQrmzB1BA3Wb
rM1w50Yx5D3dSSRPNYQRNelaHesxe+jWzHVG9ZAPt8lrpYFurbDnegsr1r37/D0P
AMHOPnsT+1usLA9bNruLwh6alASdnJee0oM27ADeZEMaZUN9K7ibK191ZE5ruC8i
+sclvfB/gFGLM5hplbdrPkM050u7Z98JqaU7CgKf49oTDaDNsZlQpyNHP3tE1a5E
tGSNb4Ql8yn/onh4pxWF0CHp27Gqrca5KfQl6dZbbq/xkln2Bc+KgpUYsqtdSqob
LoxNUlRPfPxXjxYmrsAhftDQdglg/rB7kDBYGexrmEkRLrDqvrzr33M0rRLum/Pm
YtmydXFo0TvtttTf2GKt
=Sayj
-----END PGP SIGNATURE-----

--SUygiN5FMnIY1JbD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
