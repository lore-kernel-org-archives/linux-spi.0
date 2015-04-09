From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Thu, 9 Apr 2015 11:52:02 +0100
Message-ID: <20150409105202.GU6023@sirena.org.uk>
References: <1428528961-7838-1-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H6tyVQTLTcEE6OpN"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428528961-7838-1-git-send-email-mwelling-EkmVulN54Sk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--H6tyVQTLTcEE6OpN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2015 at 04:36:01PM -0500, Michael Welling wrote:
> This patch allows for GPIOs specified in the devicetree to be used as SPI chipselects
> on TI OMAP2 SoCs.

Please keep your commit messages under 80 columns.

> +	if (gpio_is_valid(spi->cs_gpio)) {
> +		if (gpio_request(spi->cs_gpio, dev_name(&spi->dev)) == 0)
> +			gpio_direction_output(spi->cs_gpio,
> +					!(spi->mode & SPI_CS_HIGH));
> +	}

For this to work we need to be sure that unspecified GPIOs are invalid
which isn't normally the default - zero tends to be a valid GPIO and
that's also the default for otherwise uninitialized data.  Is there
something that takes care of this?

--H6tyVQTLTcEE6OpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJlnRAAoJECTWi3JdVIfQ6IQH/AlTgrRG/bMnJ/KVhssjyomk
GXdfyJaL2XpmfQNTfPTHQzvHA2PVRwfQYINyF4+Haa/VpMogFy+D+3hQo06Gv2nn
aBH3LAx017QrZ2xCLA+/6IehzABwg58HOiOaPEei+gL5WOofpSkUCLqOYSpKKDET
OFW8Y88FlX8b5r29ncl/BZszMMzw4SHtQZds5Ul6IpXq7s/ulUX+HOHXlfBnOOAh
p1CPjtqBDtUg0gLE3YSqIxQM2qqrEcMFVK0aXkuLoRmjF8Ruo0uv5x+A6iYTipfj
QE75LgVtbu044hS0e36nZfc7dAc3OEqvJnvm5xsrFeGtvd5xUp3NP84SEho2hJI=
=Drvz
-----END PGP SIGNATURE-----

--H6tyVQTLTcEE6OpN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
