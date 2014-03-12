From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: bitbang: add lsb first support
Date: Wed, 12 Mar 2014 21:35:44 +0000
Message-ID: <20140312213544.GX28112@sirena.org.uk>
References: <1394637636-29042-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394637636-29042-3-git-send-email-m.grzeschik@pengutronix.de>
 <20140312212941.GP3327@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MeyeQYaqfWO5VP1p"
Cc: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140312212941.GP3327-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MeyeQYaqfWO5VP1p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 10:29:41PM +0100, Gerhard Sittig wrote:

> Would it be useful to not duplicate the transmission logic, but
> instead to optionally "bit swap" the TX and RX data before and
> after the common transmission logic?  Just a though whether this
> might help maintenance.  There might even be existing and proven
> code to bit swap integers?

I was wondering myself, but on the other hand that's an extra operation
and this is about as CPU intensive as one can get.

--MeyeQYaqfWO5VP1p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTINMsAAoJELSic+t+oim9DX0P/RAmLTEFaJy3KHiR3NBjxCTK
MadhOGK/SEu8UiA8Kd08MPzKWP2qxj3omWm8CaP4tyXCzEhzqVkUYpDDec37YeXW
Ssbh/q05ta7m5k5XZ1v5XhFxsuPv8Ov4D2Q5tyODtf7HmgsFrEjMa2ZUUfa2cKXK
tOLW/TZjQJ+dQJzqMULeISvO3ytlSHD28aJk942uGtN8CcMFQ+iJqOD1eqT92HNU
GjfX1JIDdDYFECMMPW1Mxns43MJbqnP1nv7U/rP6tFgh9l+7Epqo8xba7j4px6pi
Bt7bLRkWqrML50ZPy6iz60uZMqcL19w3szinMiCjfjzK/w4Cqy7YR/GJ0i9P5Q69
MA+uIKt/C/OlFMmKx21lYiAQcPZGh28xYwwwPnWnIWODfnl5GiUuN6HvlhfMBEgt
hvLktKxDpxW7302ddW57PvAkM+9LlCaCkji7XK3/O4CQRGCiPKMrcw7yREt3W2J+
TtuPwxm5UGaL+8T7c94TaunA/eKIvaTHXaXiqt3iZU0W+b7w0L6HfCnjCI9E0xbo
kAontIN6r9fRbQaV7I7VWeqlNtetX2/A95F1HF67LunyBrLawcINEigqP6OPEYtM
5UVlJesttmPkoBtyOy+ASZeH65fI3sSusmL68PJM6s+Z+j4RSU3bAgoJT9CwxYD3
7d/JREhcq7tDBy66+ek6
=EqWD
-----END PGP SIGNATURE-----

--MeyeQYaqfWO5VP1p--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
