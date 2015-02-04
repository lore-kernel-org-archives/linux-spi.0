From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: only include mach/dma.h for legacy DMA
Date: Wed, 4 Feb 2015 10:30:27 +0000
Message-ID: <20150204103027.GS21293@sirena.org.uk>
References: <1423004615-16085-1-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wg47JZ3KdM6fhUKj"
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423004615-16085-1-git-send-email-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Wg47JZ3KdM6fhUKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2015 at 05:03:35PM -0600, Rob Herring wrote:

> Move the include of mach/dma.h to the legacy PXA DMA code where it is used.
> This enables building spi-pxa2xx on ARM64.

If this enables the building of spi-pxa2xx on ARMv8 I'd expect to see a
Kconfig change as well, we're not getting build failures at the minute?

--Wg47JZ3KdM6fhUKj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0fTCAAoJECTWi3JdVIfQPwAH/ArkgQx4FRYwAbvqAy+6vKED
qdZ2Eh6FQvARgaIWQjXL+ukkEYeMSl5Pm2QlW2X75uf0tahMVPTiXnAdKrkYtkKp
uXKYfjpKf43Ec6aIO4KxPE31SdnGLW4qkS73QMq1oxfe0OPJwRHQ1F/23KMNaZTG
ZyKPWhJ1Sz3ORa3WDk4ZVhqJ405P3Z/4r8dkvikAKtxtg9BRIUoW2nwhJUN4foMI
2CSq4KIvtKpjJ1KlQP62LgT2/8FNUo2pUCQ49yALu93xwZcSrubJIHggP/V7l4OW
iQwIiIsemIMcdE8i4j/1FZVueugr4OruVfoNLuBNlal7o0RESi0mWF4g75ZZukk=
=9Xun
-----END PGP SIGNATURE-----

--Wg47JZ3KdM6fhUKj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
