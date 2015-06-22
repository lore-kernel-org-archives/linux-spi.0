From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: img-spfi: fix support for speeds up to 1/4th input
 clock
Date: Mon, 22 Jun 2015 16:19:28 +0100
Message-ID: <20150622151928.GT14071@sirena.org.uk>
References: <1434631854-11258-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mmNGG5QdSOy2YTWF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434631854-11258-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mmNGG5QdSOy2YTWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2015 at 01:50:54PM +0100, Sifan Naeem wrote:
> Setting the Same Edge bit indicates to the spfi block to receive and
> transmit data on the same edge of the spfi clock, which in turn
> doubles the operating frequency of spfi.

Applied, thanks.

--mmNGG5QdSOy2YTWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJViCeAAAoJECTWi3JdVIfQW/wH/j0iGJvOTMTgYczCRf42nGVJ
hVjB1T9wClXyGpCSFqNB/69O3V7D/rD/0XrmLn2JQjKywqtLBHv/vcb63u0uPCO4
d+AbKTczv92KT754XO5aX/7hI5Li7XzMjPqEZJGb6Ljb+O5gyQcDItmE9lZYHuVm
QF7Fm09t/OUooWHez5VxYd/sjJbMG0QF6OxDIQ3EfxwsFIS1KLTsqFEQjXJ019O1
GCP1LRc0ZXcctscqcPX1IIzmVxhnjWxEGVX4biGCDOE+GlWNx1Su7oL0J/M2BCE4
O+6tdesPgiX0YLKsatoEynKG9+F1QkAKMavab+quF46KPxn/Wg6tm4jca3XDuVI=
=uShr
-----END PGP SIGNATURE-----

--mmNGG5QdSOy2YTWF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
