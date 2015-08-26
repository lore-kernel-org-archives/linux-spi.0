From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: fsl-(e)spi: simplify cleanup code
Date: Wed, 26 Aug 2015 19:45:06 +0100
Message-ID: <20150826184506.GF28760@sirena.org.uk>
References: <55D9BAE1.1030306@gmail.com>
 <20150825174508.GF12878@sirena.org.uk>
 <55DE01FF.3000607@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55DE01FF.3000607-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2015 at 08:14:23PM +0200, Heiner Kallweit wrote:
> Am 25.08.2015 um 19:45 schrieb Mark Brown:
> > On Sun, Aug 23, 2015 at 02:21:53PM +0200, Heiner Kallweit wrote:

> >>  static int of_fsl_espi_remove(struct platform_device *dev)
> >>  {
> >> -	return mpc8xxx_spi_remove(&dev->dev);
> >> +	return 0;
> >>  }

> > You should be able to remove empty functions like this one.

> When checking I just recognized that this (now temporarily empty)
> function is the remove callback of the platform driver.
> AFAIK providing a remove callback is mandatory.
> Is it therefore ok to have a temporarily empty function here?

No, remove callbacks are completely optional.

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3gkxAAoJECTWi3JdVIfQ4qsH/iApQbhdnR9T6Jz2EGkHjDl9
3YyjroUwcEM82mVeRe2YNBRgsBcUD+pnqjTF3Xab5NVPE6iJ/80+XYUkqdL7qP/D
RtOx7LYkIlAN2xMoOYc4+pLmZtkQHRQfYD4NmQKxSa6COX4v5k9wMOgShcidF5ni
H1cVmFkBM+mfZZW1/uKm1hsvMAKwzkl5d94XPXSvnE/1JEr2xEfiJHf9Da6bulXM
dpB7tSZzdhItx6GHVwKY0ZGFvQs0Jy7PYuhk8t4UonGbu44y59kRLwt1Zp4oZB0t
oeDp7uzoJNKNyDx5XKnCy4L0KYqVhRM4Rsv5ij3zvmHIh410/N90u8OcoONJlqo=
=yJsT
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
