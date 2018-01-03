From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: spi-gpio: Delete references to
 non-GENERIC_BITBANG
Date: Wed, 3 Jan 2018 16:10:45 +0000
Message-ID: <20180103161045.GF28713@sirena.org.uk>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <20180101133749.29567-6-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180101133749.29567-6-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 01, 2018 at 02:37:49PM +0100, Linus Walleij wrote:
> The non-generic bitbang was a feature where a platform could optimize
> SPI bit-banging by inlining the routines to hammer GPIO lines into
> the GPIO bitbanging driver as direct register writes using a custom
> set of GPIO library calls.

> It does not work with multiplatform concepts, violates everything
> about how GPIO is made generic and is just generally a bad idea,
> even on legacy system. Also there is no single user in the entire
> kernel (for good reasons).

> Delete the remnants of this optimization.

What's the positive reason for removing this?  I'd not anticipate people
doing this upstream but it seems like a totally valid thing to do on
product.  It's just compiling out the gpiolib calls so it never looked
like too big a maintanence overhead.

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpNAIQACgkQJNaLcl1U
h9BcAAf/YWqmLIiDxsBxSABCsLlz6HkfUfFseGBMVvE4QS3qo4k+QabuLRz0HtUC
qGWnMT13rlMGo1r1eqpuC2tHv2AWhQljfCnhQOhPXE73IRBoJtBVZpDQVtASwRwH
+bWtRPZHr78exQFnP5XIqUkZ7ZA5+QEHuUOSKZFtf4ao5kb3trX4olH+JylRKDuY
wypqf8ReY0iiVfeVvAGpTilR2Fdnow908+/nb1ofetp6jlxgRbQ7x+IX18R6f3/x
aroBpg2YzjhrtX3nJhiew/matJsQVDhwRqvOpHgahZEA2BDDIYNJMKLqijwVGsuY
kfOwxUZhpSE5f6Og3Qi17zGF3xGjUw==
=eH9F
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
