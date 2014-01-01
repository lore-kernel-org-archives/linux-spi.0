From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: clps711x: Driver refactor
Date: Wed, 1 Jan 2014 13:23:34 +0000
Message-ID: <20140101132334.GP31886@sirena.org.uk>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VypWdzyUxItf8lKe"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388556568-10973-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VypWdzyUxItf8lKe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 01, 2014 at 10:09:28AM +0400, Alexander Shiyan wrote:
> This is a complex patch for refactoring CLPS711X SPI driver.
> Major changes:
> - Eliminate <mach/hardware.h> usage.
> - Devicetree support.

This really needs to be broken up into smaller changes so it can be
reviewed, your summary would be good as the cover mail for a patch
series but not for a single commit.  We need one change per commit with
a clear commit message saying what's going on.

There's a large set of changes here with no explanation of most of them
which means I can't really tell if the changes are doing what they're
supposed to and at least some of them seem to be doing things beyond
either description above.  I'd expect at least two changes, one for the
mach/hardware.h elimination and one for the bindings, but probably each
of those should be split into several changes.  For example the bindings
changes might have some patches doing refactorings before adding the
actual bindings.

> -	/* We are expect that SPI-device is not selected */
> -	gpio_direction_output(hw->chipselect[spi->chip_select],
> -			      !(spi->mode & SPI_CS_HIGH));
> +		ret = devm_gpio_request(&spi->master->dev, spi->cs_gpio, NULL);
> +		if (ret)
> +			return ret;

For example this is a refectoring to use devm and request the GPIO which
is good but definitely not something I'd expect to see happening in the
same commit as anything mentioned in the changelog.

--VypWdzyUxItf8lKe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxBbTAAoJELSic+t+oim9CU4P/jQCZrqwhWHWM2AUfEvJYfF8
bRalxp+Nxtg3NCcjt+sEKIugJUgrkJoCD/AnLGxq96MiyS1tCNZ1fDACeS4Pnqnn
Pvr5JSSIY2b3SE1lKwBTzAZEq02XAez6tRzyu9/PKuwaXfTcdjsvYLv6k0f5bQTq
gugU1p7NofrXfdsb45NFIAgGgMOf45ryV1riauElL4JUjt77wDDI5RCsFCdfFZEr
UiTgMiYq7Yj9UlRwtE1melmICbBMKrwFHjT7nIR4rA6bqPy7Qn03KzGWfB2bFbaD
MXpMZ5XSdxwEMAUvZjj/oEPjjvEaRJ+22FkwExVkCKHSTlpF6GhXwBSt8zEIqMP2
BkCyKGICIFRfmMt23UgLkfTGPtDS9cHsEmgqNjMjhrLX7YxTWUiVjqs+GzCL/dhx
UqMEGUPxTvoDIHSZW1BClF2wo4f2hXcZwaBqM8mX1fnn7xkWOPqhI1pLS1+kGIMT
a1x+Q7X/f2QFsGZOv+eSZjEVKOXZEk1gv372QLQG+xbwLSpNhT2JtgalBMXKgrP4
+U1egI+srQo0CmDGHEeImlXarMsJCKEblvuBAY6CJh9sF25Rqhqie/+5dKuM1EMu
K/rArDg0O286StP4Tu7RKhhdbK4yaa8+wx27QOhD4tMB1KZn+MdBW3X4ylasbTwk
qzXL2gKxzM6thxuTvmk1
=ymwa
-----END PGP SIGNATURE-----

--VypWdzyUxItf8lKe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
