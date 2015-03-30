From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/6] spi: bcm2835: add polling mode for transfers below
 30us
Date: Sun, 29 Mar 2015 21:27:27 -0700
Message-ID: <20150330042727.GC1568@sirena.org.uk>
References: <808DC596-35BB-4A08-8CF4-DFAB6294636E@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <808DC596-35BB-4A08-8CF4-DFAB6294636E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 29, 2015 at 04:03:27PM +0200, Martin Sperl wrote:

> +	/* check if we shall run in polling mode */
> +	xfer_time_us = tfr->len * 9 * 1000000 / spi_used_hz;
> +	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US) {


> +		/* Transfer complete - reset SPI HW */
> +		bcm2835_spi_reset_hw(master);
> +		/* and return without waiting for completion */
> +		return 0;
> +	}

The logic here is fine but it's more common to construct these things by
having separate functions for the different modes of operation.  This
makes the code more straightforward since it's clear that there are
alternative branches being taken which isn't so obvious here as the
polling case is an else within the main transfer function.  You end up
with


	if (polling)
		driver_polling_transfer()
	else if (interrupt)
		driver_interrupt_transfer()
	else
		driver_dma_transfer()

or whatever at the point where the flows branch.

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGNCuAAoJECTWi3JdVIfQ4CkH/jEhamB10Vx8Y39+5xQCK/eN
1/udosT0XRPTzpCmGIV9fAtT2wFCmArkTVwabhLsfzS2eG0Aqmy0XVaqjjx8ZNZ0
5phREwmXOK1PJzSu5NIF+KPtYnCrYZMzVZN340BRUmr3ZvMOkbVqyKkIeEqGOeEk
agH7uxVd7XWgyui7OFfSa7xEPVSj6yM5VthPR2118g+AYbj30st1fqPBZhtLqKrU
TGuh0MoMl28OMHL4U9cM/dUV3Zfkx85coOoewWtLFqFrc8jtTXhD1d/MKAXsSnHq
Y46P+k2h3JzawhzGHw8l6ZyOVRXDwPKLs8qMQ4xClOykHILSv1cE7OLBJnvNBLo=
=UDa6
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
