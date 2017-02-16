From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: spi-ep93xx: simplify GPIO chip selects
Date: Thu, 16 Feb 2017 19:01:09 +0000
Message-ID: <20170216190109.kvsgigo4wlnaacvm@sirena.org.uk>
References: <20170216182614.47941-1-hsweeten@visionengravers.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fixrrqfhhc57eib4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170216182614.47941-1-hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fixrrqfhhc57eib4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2017 at 11:26:14AM -0700, H Hartley Sweeten wrote:
> This driver requires a GPIO line to be used for the chip select of
> each SPI device.

This doesn't apply against current code, there's conflicts in the arch
code.  What's the story here (should I just apply after -rc1?)?

--fixrrqfhhc57eib4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlil9vQACgkQJNaLcl1U
h9BIjwf+IamMiSJuc7sWtU52GNSMD34VW1UwHuR1vTb4xDZtZcCOnOxsuudLQ+eA
e8M/R2nsd8dwek+z1m9STAuphg7vKUruRMS0XvaV8w1l+/NxCYUj7Xm9Qf7Cp4sA
2mSGk+iJ79VhCw5V//ZgeOSOjdZ3CQZ8KIXurD76kxhhOEPt03Kzdd5rT9JTDqOL
E3BfQtSUkRNXQoBxhcyyWmXlA2g0cdpj55+ChGzu3y+xhQNKZUTZHrxIrm3vax/Z
vc2kBQXfn0RPV4aC+bJ556MoWLYN6Wc1BrAiU6gzS9rVSwIE54AwDPoct3H/p+fJ
YgNu/e7ttuXmB2jW4o2wDLfqNeXOZA==
=qyqP
-----END PGP SIGNATURE-----

--fixrrqfhhc57eib4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
