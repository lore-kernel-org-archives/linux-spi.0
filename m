From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Mon, 27 Apr 2015 20:55:50 +0100
Message-ID: <20150427195550.GE22845@sirena.org.uk>
References: <1430106270-17142-1-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S41bfRIpiBrW3HRl"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430106270-17142-1-git-send-email-mwelling-EkmVulN54Sk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--S41bfRIpiBrW3HRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 26, 2015 at 10:44:30PM -0500, Michael Welling wrote:

> +	if (gpio_is_valid(spi->cs_gpio)) {
> +		gpio_set_value(spi->cs_gpio, (cs_active) ?
> +			!!(spi->mode & SPI_CS_HIGH) :
> +			!(spi->mode & SPI_CS_HIGH));
> +	}

Two problems here.  One is that the above logic statement is just not
readable (the repitition of hecks, the ternery operator, the
indentation...) and the other is that the core chipselect support
already handles GPIO chipselects so you should really be converting the
driver to use that.  At the very least the code needs to be legible
though.

--S41bfRIpiBrW3HRl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPpRGAAoJECTWi3JdVIfQnSwH/Rtr+23EgqtLvgrKO7ou15/3
Wg8iW/GpJP6aetwqooTlxeENaYDHZQaFA3pVuiuWkIorJkFM41rj6wfXZkt5x0dM
VSeqNyMKji5guqT3DSKlK6+wZl3OkrJ561wY1nY01OzGdhun47wZ1yXENbfqpCLg
6VgcnYdsmXicyjNAynohaVDRYjOVQEw7hZNVsTHLBqieX02gXdKudGbt/JoOl9/P
xE/OhERseyGg9V4Y68beaKiZLIiYUTwz4sTFevTwfaBxR2Pf3WD+mQllvx7mf2mx
0KSPXM2rgTX2Qav3j+SY050azkjWRyyVbuMnBIYvO2iTUkgi2n10CNY4VkCChck=
=2uNy
-----END PGP SIGNATURE-----

--S41bfRIpiBrW3HRl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
