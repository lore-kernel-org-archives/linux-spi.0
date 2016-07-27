From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: vulcan: Add ACPI support for SPI driver
Date: Wed, 27 Jul 2016 19:20:51 +0100
Message-ID: <20160727182051.GU11806@sirena.org.uk>
References: <1469510526-7593-1-git-send-email-kamlakant.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lCKkSrrNUaKEhaIQ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469510526-7593-1-git-send-email-kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lCKkSrrNUaKEhaIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 26, 2016 at 10:52:06AM +0530, kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org wrote:

> -	if (IS_ERR(clk)) {
> -		dev_err(&pdev->dev, "could not get spi clock\n");
> -		return -ENODEV;
> +	if (!IS_ERR(clk)) {
> +		xspi->spi_clk = clk_get_rate(clk);
> +	} else {
> +		u32 freq;
> +
> +		err = device_property_read_u32(&pdev->dev,
> +					"clock-frequency", &freq);

Ugh, this is horrible, especially with...

> +		if (err) {
> +			/*
> +			 * Use default SPI frequency for Vulcan unless
> +			 * changed by firmaware.
> +			 */
> +			dev_err(&pdev->dev, "Can't get clock-frequency,
> +						using default\n");
> +			freq = VULCAN_SPI_DEFAULT_FREQ;

...this just completely ignoring error handling (it at least needs
fixing for probe deferral).  This actively breaks things for existing
users of the driver.  Splitting the log message up like that is also
very bad, the log message will end up with a newline and a huge number
of spaces in the middle of it.

This should be specific to the relevant systems, not unconditionally
changed for all users, and should be implemented by registering a fixed
clock on the relevant platforms like spi-pxa2xx does on Intel systems so
that the driver works in the same manner outside of probe on everything.

--lCKkSrrNUaKEhaIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmPuCAAoJECTWi3JdVIfQvncH/2SAPrg+Goxe5WBFD/+SnqxR
p08q6Kv1xSSaB9Yj09x1awQa8zX/XdHjqNKe+/xkVysS2x7wqfXmv0z7g4vNfHv1
l1nA92mP9eLtFQbBfnqqzOtjXZ06U45bUWn+6TBSX2YBqjIdMI537NmsG77qo88G
RjE8QlqXTTschqR6bRpGPN+CBlUO5kDxCTJr+g4TeCCu/ht8z9+2ylQBPWUnvUuX
R/HJB56C5zCTsNLp3Q+xdtuopfnDqPba5iih8I+InTTWS1ekViGSkMi05ZQ5K5oD
ZgghO75CT8gTePlLuQUwzXJcwiK0aJU4Vxl7PSszmwwMZzfmHojR9z7av93Y3DY=
=2yVv
-----END PGP SIGNATURE-----

--lCKkSrrNUaKEhaIQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
