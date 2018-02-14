From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: spi-gpio: Delete references to
 non-GENERIC_BITBANG
Date: Wed, 14 Feb 2018 16:01:22 +0000
Message-ID: <20180214160122.GE12658@sirena.org.uk>
References: <20180212124532.25776-1-linus.walleij@linaro.org>
 <20180212124532.25776-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180212124532.25776-3-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2018 at 01:45:31PM +0100, Linus Walleij wrote:

> The non-generic bitbang was a feature where a platform could optimize
> SPI bit-banging by inlining the routines to hammer GPIO lines into
> the GPIO bitbanging driver as direct register writes using a custom
> set of GPIO library calls.

> It does not work with multiplatform concepts, violates everything
> about how GPIO is made generic and is just generally a bad idea,
> even on legacy system. Also there is no single user in the entire
> kernel (for good reasons).

It's not expected that users should go upstream and it doesn't seem
helpful to delete without replacement.  The original idea was to allow
things like setting multiple GPIOs at once if there were calls for that,
now that gpiolib has support for that we should at least convert to it
before removing the hook.

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqEXVEACgkQJNaLcl1U
h9B0GQf/SclSl4u89MHim7or/YsyKmVANnwm7Wi33AaeengZLvej110/Qh3eSN/3
u67oUIhL/am/pORVE46vSQKwUF6mBoBrwqsGZh0Lb+yZVT8ghouY7kdGJRURNKT+
CeRAJAzC/Akcp+H5Q12IVpJivE+8eB84z7IY1gkxSthUqqNg9Gc1qUTzjYzprMym
M12rZf3J8EY9ZT7qQpwrBoVPBPDeU4ZZpfc3VnrBiQkyyFrXJ+BxEYloy9v6jn0z
VQdKVezOZ+IwtRYKm7UTklJPGt6hXLALqvJRpTmmj/oSPmTHkCeTVh5WBuJVlldL
s5ukK55Tj4Oe8cwkZN86IRUmdctYIg==
=XOp8
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
