From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-ep93xx: simplify GPIO chip selects
Date: Wed, 15 Feb 2017 19:01:38 +0000
Message-ID: <20170215190138.g7jsecekhtm4gvkr@sirena.org.uk>
References: <20170215164422.5957-1-hsweeten@visionengravers.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gpalbzfju3rrmpfi"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170215164422.5957-1-hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gpalbzfju3rrmpfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 09:44:22AM -0700, H Hartley Sweeten wrote:
> This driver requires a GPIO line to be used for the chip select of
> each SPI device.
>=20
> Remove the ep93xx_spi_chip_ops definition from the platform data
> and just pass the required GPIO line as the controller_data for
> each spi_board_info entry. Then handle the gpio directly in the
> driver.

Why not also use the core GPIO handling?

--gpalbzfju3rrmpfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlikpZEACgkQJNaLcl1U
h9Cuowf+KJ0AqFSN4FVksc82ol68xiHwfnbauMf1hBs/8BfRrZZGdPUXhQaEytSm
n7s8VBYxEU2PQMMVlV+Jk2pNo3QDYADy9trG8yCk0ead5wO0FMWOAhBL0zaRxf/T
+SR7GxdnKUkTWYwlE0cRr4VpUdzS5w8Ui+a8JdyaVzi4ls1AwoDwuVvlRnbNsqNU
IeEyOaRbivE/1h9E22BSh0BFn17WZ4Yr/HhMJucmaLcIatS36dKDSJS+ZdmlXJLC
4pgyV1+QiZBx/J+EbnHM37PSSZCcTdk4MLBgVx57RpyoW4FIteQk9BqzzHcMmCM6
otKM51vE3YvHHVsa83Uc67sBCdXKoA==
=r5l+
-----END PGP SIGNATURE-----

--gpalbzfju3rrmpfi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
