From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: bitbang: only toggle bitchanges
Date: Sat, 18 Apr 2015 13:09:26 +0100
Message-ID: <20150418120926.GL26185@sirena.org.uk>
References: <20150331202306.GX2869@sirena.org.uk>
 <1428922770-16955-1-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HLsZ5Z1opAQvdr2J"
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428922770-16955-1-git-send-email-m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HLsZ5Z1opAQvdr2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2015 at 12:59:30PM +0200, Michael Grzeschik wrote:
> The current implementation of bitbang_txrx_be_cpha0 and
> bitbang_txrx_be_cpha1 always call setmosi. That runs into several
> unnecessary calls into the gpiolib when the level of the GPIO actually
> has not to be changed.
>=20
> This patch changes the routines to remember the last GPIO level
> and only calls setmosi if an change has to be made. This
> way it improves the transfer throughput.

Do you have any benchmarking or anything showing that this offers a
practical benefit?  Generally a bitbanging system would be using memory
mapped GPIOs for the bus so we're talking about replacing a memory
access with some shifts and logic operations here and while I can
believe that something that runs in cache is going to be an overall win
over going out to a device it's not quite so clear cut as it could be.

--HLsZ5Z1opAQvdr2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMkl1AAoJECTWi3JdVIfQ9TwH/3oTjNcx936XhfHUkyL8HJAj
0McffOZe3v71BE2D2z6pn0r1W9nd29v0eqvwD3q0AErtObTykVqiaA9VUbQlqdTH
Yhlf8Sxgo93fu44pT4iyWsjYEbaNb1Je4yChHLzx5vD0C29tngm+FvljmNCAc2ce
lxvw9rR2Rhk0FB5F9jw1EExZjztRi+Bg+2Z4jYKIxVZNvWvwYn4Um0zZsnvrI6n4
wvub4IZS6BIBJ+bSm0d1HWd8hk+cl26IzB9KjgeV+henwQqQCQoDoDTjcIiukMjg
hDy3XPktxO3vdreVUHGLlbRmr942Px1lgCe7WN/Z298ac/On7zYjknjcyUp/BgE=
=zTzJ
-----END PGP SIGNATURE-----

--HLsZ5Z1opAQvdr2J--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
