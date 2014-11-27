From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: Add new driver for STMicroelectronics' SPI
 Controller
Date: Thu, 27 Nov 2014 16:24:59 +0000
Message-ID: <20141127162459.GY7712@sirena.org.uk>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-2-git-send-email-lee.jones@linaro.org>
 <20141127125904.GV7712@sirena.org.uk>
 <20141127150508.GI4628@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zBkzUKoNN9/BHFeb"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141127150508.GI4628@x1>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zBkzUKoNN9/BHFeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2014 at 03:05:08PM +0000, Lee Jones wrote:

> > > +		/* Set SSC_CTL to 16 bits-per-word */
> > > +		ctl = readl_relaxed(spi_st->base + SSC_CTL);
> > > +		writel_relaxed((ctl | 0xf), spi_st->base + SSC_CTL);

> > > +		readl_relaxed(spi_st->base + SSC_RBUF);

> > No byte swapping issues here?

> I think this implementation has been pretty heavily tested.  What
> should I be looking out for?

The bytes on the bus should be in exactly the same order as in memory if
the word size is 8, SPI words should be big endian normally.

--zBkzUKoNN9/BHFeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUd1BaAAoJECTWi3JdVIfQST0H/2HZDGXTX2tMsJEAuWKCam/d
+dHlbwpd10cbDyLHMxX1FRToqMzTjTPRV41fVVqbOmIF7qXh+GeogAgeaZvdhAvw
v0GFS30LGtHbCJkLVwxOHAMZMJ8QhGh5aSUkKQVu9IT33FVnEECers5saWpnPMuS
cwvX9lnV6PjqTdsWsmrOaAPhWHJs7grKKtLn3dXStBUo/vXvfxqded9fWwL8t1Cd
4y+AYu/PAeME2wfakOwZ12j0Fn5S0fdvNX55UXbScn93eNyHU3mJqe/CnUmbXTfy
PyIC021qIxT+z5AKZgqDLxV8wHhDyTA6jqJ8PDyKU3PvLSIiYOCBorBUtl2Hxgo=
=3gML
-----END PGP SIGNATURE-----

--zBkzUKoNN9/BHFeb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
