From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] spi: atmel: add support for the internal
 chip-select of the spi controller
Date: Tue, 9 Jun 2015 18:26:00 +0100
Message-ID: <20150609172600.GN14071@sirena.org.uk>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xFx/BiQzdL2KVl5R"
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xFx/BiQzdL2KVl5R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 01:53:52PM +0200, Cyrille Pitchen wrote:
> This patch relies on the CSAAT (Chip Select Active After Transfer) feature
> introduced by the version 2 of the spi controller. This new mode allows to
> use properly the internal chip-select output pin of the spi controller
> instead of using external gpios. Consequently, the "cs-gpios" device-tree
> property becomes optional.

Applied, thanks.

--xFx/BiQzdL2KVl5R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdyGnAAoJECTWi3JdVIfQIr4H/1xXABo+R020oWFVlIMrux5b
4rf3p4eFY1XDxBP1cuqud3ZbUJSCaQ52lhT3n4/YyAQAPmUG+rZW5RKcKS7rHMiU
/c32ZHgxEc1HRiVT2WxVCGMVbQbzCjmj4FfdMu5lAMHB2h6QqKJYOK/L6hBIj1wo
c8old3K/fsoivsTUqOGfZdHRo7KFhdemlUNclvYt6YHcYOjOXmHjRS4Wb8bKvR2B
+6ZGqCOEGzU2oBSn2+0y/S6AvpiDTo2HKpfN8yB1UVyzBIxQBKXQ4TqmiH/2ta3f
hk2OGPyLte4vI1Q7sphdd6nLssGkXXomnx7SJKLzHK8p8m4pIF+umM2dTCISi+0=
=hIB6
-----END PGP SIGNATURE-----

--xFx/BiQzdL2KVl5R--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
