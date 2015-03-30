From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] spi: bcm2835: warn about native-chip-selects being
 used
Date: Sun, 29 Mar 2015 21:22:06 -0700
Message-ID: <20150330042205.GB1568@sirena.org.uk>
References: <0330B85B-A297-482B-80A9-E01F236D33D2@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0330B85B-A297-482B-80A9-E01F236D33D2-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 29, 2015 at 04:03:26PM +0200, Martin Sperl wrote:

> Could get replaced by something similar to this.
> 	if (!gpio_is_valid(spi->gpio_cs)) {
> 		if (spi->chip_select == 0) {
> 			spi->gpio_cs = 8;
> 			gpio_set_output(spi->gpio_cs);
> 		}
> 		if (spi->chip_select == 1) {
> 			spi->gpio_cs = 7;
> 			gpio_set_output(spi->gpio_cs);
> 		}
> 	}
> But I do not know what is the correct call to use.

I don't know what you mean by "correct call" here, sorry.  If you're
talking about working out which GPIO maps to the /CS pin then can the
pinctrl API help?

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGM9tAAoJECTWi3JdVIfQGSsH/3FMb2i26nJstntIk/jLLZYj
fYr/NyzKX+yqCmSXY4wDYHc3d4g0vSLp09fJGJTRZDgYR0++laS/mrRuFJkC8S6U
hvvYjPZyXtzsgZjwa4dPoyWRCokNscgNKHmAmCFFjqy949RBCmiY24RRXSb9y2a1
/lYILauX08+7iDqROSd0lgLFj5RjKfz5+H/b3BcgqW1cwGTENlBiBT6mQsexhFmt
YB8YNhnP8dO/GC99QYyN/IPOUvCrEXARYEqfr7GwUrTKyhBmXOWO1eNvvIadcvy7
rXSCgGayAg5HQGYSC35IdlLLoLc+OKJDrJen0tjjJz6suUFzzKeWI8tQO77fqzQ=
=y+PF
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
