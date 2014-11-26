From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
Date: Wed, 26 Nov 2014 19:01:37 +0000
Message-ID: <20141126190137.GR7712@sirena.org.uk>
References: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GmuS80z8CDsfIMz9"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Padmavathi Venna <padma.kvr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415267509-16653-1-git-send-email-padma.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GmuS80z8CDsfIMz9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 03:21:49PM +0530, Padmavathi Venna wrote:
> Exynos7 SPI controller supports only the auto Selection of
> CS toggle mode and Exynos7 SoC includes six SPI controllers.
> Add support for these changes in Exynos7 SPI controller driver.

Applied, thanks.  It does seem like these controllers are getting more
restricted in functionality which seems a bit of a shame.

--GmuS80z8CDsfIMz9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdiOQAAoJECTWi3JdVIfQMRIH/1va7pnUO8GheS1EM+c/ZLUN
cdMpNq1SlRalqJUjIcSUDFVr4Dfaw5TCXLzexaYO1wcyDydstg2ECVVo+w2FWSuu
Ed0otRbr5hXbfT7YNglLm4V8qAXRUGu8o8msSz8hYGdPurOvNOQ3E8+0KIt6u+bc
H9nfzt+ivoTPth2koQxhNNUK08rA6Q0QbJt5ChSIfWD+0BfvFN4r8D4viK503kHy
9fT8FOUBjUha+wHt6OZoW769yUhkx3IACIQAKDmSB3ewb+0G2hAYtsvw0JWvIFUG
qPnp6V0IcLTHQpoKBlT5SNjmQd0oUJbIQpBxs2ALd42wYh3vYcyR3/WqVgG+HpY=
=Fs/g
-----END PGP SIGNATURE-----

--GmuS80z8CDsfIMz9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
