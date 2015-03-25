From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 - RESEND] SPI: BCM2835: allow arbitrary GPIO to act as
 SPI-chip_select
Date: Wed, 25 Mar 2015 08:16:11 -0700
Message-ID: <20150325151611.GA3572@sirena.org.uk>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
 <1426755714-28130-2-git-send-email-kernel@martin.sperl.org>
 <550BAA89.5090707@wwwdotorg.org>
 <20150320095247.GE2869@sirena.org.uk>
 <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1756D77D-173D-4D6D-B629-59CC8A49714F-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 08:10:57AM +0100, Martin Sperl wrote:

> +static inline void bcm2835_set_cs(struct spi_device *spi, bool enable)
> +{
> +	if (spi->mode & SPI_CS_HIGH)
> +		enable = !enable;
> +
> +	if (gpio_is_valid(spi->cs_gpio))
> +		gpio_set_value(spi->cs_gpio, !enable);
> +}

This appears to be open coding the core spi_set_cs() support for GPIOs,
why are we not just setting cs_gpio and letting the core take care of
things?

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEtE6AAoJECTWi3JdVIfQ8qYH/2sstTQJXkT6MTNltSBhfGGv
+yllgCSlduM7PEB8FqklJESEcnAJn93R3kkyVgAPZdW3KzM4yLuIGzWbg/jZc77e
cpkn+p/1W1hUgNncgtU79cft56HcKYeGK3mJAouI+9b0e8mr8TR3MvxdnvMC9HzK
B00CDXAAt8MgyUZC4B4fpx9Oorx+wsRAMgObC+4bqdw4muyzNfo4/qJwCs7aaSR2
X45fazuN8/NluuDDyRR/4s23zfJ45vdAM/zYz9CzmSndNcVJ9H2Egc0OzLCD5P9t
UPoedALdESeWfDGw8Q808WSxc62BnDovcsksymApoVI/yjmGloALOilZyfqjafo=
=atnQ
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
