From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: omap2-mcspi: Add gpio_request and init CS
Date: Fri, 8 May 2015 18:09:16 +0100
Message-ID: <20150508170916.GD2761@sirena.org.uk>
References: <1431041814-24757-1-git-send-email-mwelling@ieee.org>
 <1431041814-24757-3-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431041814-24757-3-git-send-email-mwelling-EkmVulN54Sk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 06:36:54PM -0500, Michael Welling wrote:

> +	if (gpio_is_valid(spi->cs_gpio)) {
> +		if (gpio_request(spi->cs_gpio, dev_name(&spi->dev)) == 0)
> +			gpio_direction_output(spi->cs_gpio,
> +			!(spi->mode & SPI_CS_HIGH));
> +	}

I'm not seeing anything that frees this GPIO?

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTO27AAoJECTWi3JdVIfQ+yMH/imw2dB9l0bpE6CO953PGZIw
zwtvwrcmYPhsY4KNCAUuHYUl3OYUYMVm3qOnzHLXkR2Yol3vJPA4qSSqiDNPJOi5
FSPZIplGEOHEFCzR8Fn167MbYwOTMA3AG/0uH+SJhMeaHnCg5/3NxPka0+2js0JY
e5FWkGSKn5Yyn9Oto0KAzym3uEpu7OdZdG1kd+5bF5GuoxtmbVtLirdWnsMy0kuo
qzhRJ7osGiTcjgUq1Z6eqkJtbuXcs+TKnJqw3bxnAyYk93DoeiXn2fM9Z0AZekFP
SGeycdNQQRFZjujqwRG7wxp0l7QnY5/vOkxTIwxcC/Gylc6JFBIldnSvJwyyr+E=
=GzPy
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
