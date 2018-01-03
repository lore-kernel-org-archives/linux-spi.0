From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] gpio: of: Support SPI nonstandard GPIO properties
Date: Wed, 3 Jan 2018 15:04:52 +0000
Message-ID: <20180103150452.GB28713@sirena.org.uk>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <20180101133749.29567-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180101133749.29567-2-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 01, 2018 at 02:37:45PM +0100, Linus Walleij wrote:

> Before it was clearly established that all GPIO properties in the
> device tree shall be named "foo-gpios" (with the deprecated variant
> "foo-gpio" for single lines) we unfortunately merged a few bindings
> which named the lines "gpio-foo" instead.

Can we get this merged during the upcoming merge window to make the rest
of the series easier to handle please?

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpM8RMACgkQJNaLcl1U
h9Da2wf9H/dlEjK/dPnVdkKUGNCoy2JNMYmqhsy1dWBlj0oDXTDb3sMW4tzi9+mW
XWDAq1Hasgf5foZ/Lsjpo+bGf7jbnoCFIjVGeL9JCHF7XrbKMuTikLsUP6jjzcTW
rWzRXGIjo6hXPnwdx/3dFc1Xlgn6uakC1nod57gyjrHefMLLfbrhNTdZu+9WZXEF
Qzjzj6vc13axSLDvPdQ4JKPsGHUFWr+V2Ab91Yeu5rp6D6w4pRKwuokTngQjyMZ8
OfmSrjgwNRTsJAwRAggAKNTlTTpD69lZj3fJ2IAEtyLq7wB0awY2vprqN3pjqaNk
GrupaG3qfZU6StaLTKYdQ+cixkTVcw==
=LKwr
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
