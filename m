From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Remove duplicate code to check chip_select
Date: Wed, 12 Feb 2014 16:01:04 +0000
Message-ID: <20140212160104.GA28112@sirena.org.uk>
References: <1392127650.9833.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vx/u1Rx7tHHd/cso"
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>,
	Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392127650.9833.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Vx/u1Rx7tHHd/cso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2014 at 10:07:30PM +0800, Axel Lin wrote:
> In spi_add_device(), we have the code to validate spi->chip_select.
> So remove the duplicate code in various drivers.

Applied, thanks.  With this sort of stuff it is a bit easier for me to
split things up per driver - it's easier to judge what to do with acks
and it works better with the forest of branches I keep.

--Vx/u1Rx7tHHd/cso
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+5q8AAoJELSic+t+oim9D88P/RDoaVjMcvrnoFIHn7XXojS2
ucqAiPGiepXgbUtTA7XV8gCYtYc85eD1d2DEBSTNN7evd3rV/UGYqZ1qXOPFkpHm
OEaCDtBWXIS+BM0IYquP66/yG5zIWx9x22t5nya2i+Nx4S5iK/tPvjc0Ifd4+Nlp
8yXTm6Kf+3PZMsLpNdS88yGLbHpYAuCxpTi/S4cCA3PygYaGw6UtchbBQgQTMelZ
wRcpFqYtJ4+MMqUO8IV7pLynVab0IrZLmZIQrk9ybu/btQY09p2SKQbIBwvpvO/U
+ueYOyZQrr8nQRRGqc+UIFtDIUj8JYRJnsnubcl/8L6xZju3hFlDgHGpRDNz4a+c
y3jpzTAIr0fMtdndsya34oBUDO5LqsErOAqXQCsxbaT89hwjzBXOeLizRAzQ3fFA
s7Ib+jGGwpcJ0WtpQ1qwBiA1PJ9tYikVEX9r1yGqw391z1ANXhLXRcQyODGDOx2n
V9pXWDAFgkSwQYdXnRsJS1wrjPbjyhZtUI8gXo+PAZXslShbu+vblCSyF189F1e7
aptb3mgrnyFhdhl/s8+KD7NSt4eL3QGwt17DI8DPhLISE+/YFNa8hl8Tf8b5mtBx
K5V4BoYHzsC6kwia49sYgn1GYhx/cAxKPyRK2DVQw2QEhJegnxzRaHTMHVX/uuR1
qsj30B+awBzeEN/2lSeA
=Sjji
-----END PGP SIGNATURE-----

--Vx/u1Rx7tHHd/cso--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
