From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: fill/drain SPI-fifo as much as possible
 during interrupt
Date: Mon, 23 Mar 2015 11:49:14 -0700
Message-ID: <20150323184914.GK14954@sirena.org.uk>
References: <F89FEE91-D292-4835-9F49-76A69A17BA4F@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F89FEE91-D292-4835-9F49-76A69A17BA4F-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 03:11:53PM +0100, Martin Sperl wrote:
> Implement the recommendation from the BCM2835 data-sheet
> with regards to polling drivers to fill/drain the FIFO as much data as possible
> also for the interrupt-driven case (which this driver is making use of).

Applied, thanks.

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEGAqAAoJECTWi3JdVIfQs4IH/RhH868Dk/aLtdFOC6AuhWw3
8OSgVJQt+eWcw9Z7YFcS0o8ozw+rChTDGj+7Fuqww5M1Gpco/c+Yvo8bf5CMD3DU
WQ82Ch7UdnzMldMtnNngsfW61EyJKjmDko/7wwe7k8SkCyosfpnFM0f3/OrU44Hj
5cyIwYK898VVFB47gwel4qYbFrAvoZSkLRD+RWkThXogPWOn9RxtBxFAu6Rh0IY3
YivWkjLNc4YGxfpFHyWsoP6CrxdCf4ypikWcuhYvsMPxO+4kLXlU4r0eL01ZL9K2
V89jdmaxwe7k7myr7sGRXI0QMlhKDv3A+GO6TLLCmjFQ10sIlHAp9Bv2zC0w1gQ=
=L6/A
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
