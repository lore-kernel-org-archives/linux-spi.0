From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: Fix unconditional call of lpss_ssp_setup in
 pxa2xx_spi_resume
Date: Wed, 28 Jan 2015 11:24:57 +0000
Message-ID: <20150128112457.GT21293@sirena.org.uk>
References: <1422432582-12287-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lN6+o8OR/WtMj97Y"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422432582-12287-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lN6+o8OR/WtMj97Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 10:09:42AM +0200, Jarkko Nikula wrote:
> Commit 7566bcc76b15 ("spi: pxa2xx: Move is_lpss_ssp() tests to caller") did
> not check LPSS before calling lpss_ssp_setup() in pxa2xx_spi_resume().

applied, thanks.

--lN6+o8OR/WtMj97Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyMcIAAoJECTWi3JdVIfQIjkH/07uNnymELlfIi3TMjJDmPza
dirHfQ/PelgtpzOuFpJtGY/R0Bwx8ztkKILd2PMev8fgmx+NtLDuZPJFK9OUgf/m
Z4PhQxBqgCyUD2epm4Zjyb7+xqDA4JTZypA7csD+5pTWidQYelGnOomB6b7/9MGP
GAGAD3ZLkdS5Orl+jAI7g3y3YIQut7jPrVUMu5zrLfs6s1a4iJA87+Q8tStlzMoS
VQdUytYgVl9eMXsITZeW1m8jEApWIvt8NUGm7ppLD6vT7nWxguSIEPkg0IWP1qpG
R2OAFYgvCNY55qW5PJP4M/vixf93w569+FGvdLs9pwomKG+2I/cPJjiXaRbvhJo=
=/lJx
-----END PGP SIGNATURE-----

--lN6+o8OR/WtMj97Y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
