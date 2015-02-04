From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: only include mach/dma.h for legacy DMA
Date: Wed, 4 Feb 2015 20:14:24 +0000
Message-ID: <20150204201424.GD21293@sirena.org.uk>
References: <1423004615-16085-1-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+ADn8P7LGHbCQUlh"
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


--+ADn8P7LGHbCQUlh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2015 at 05:03:35PM -0600, Rob Herring wrote:
> Move the include of mach/dma.h to the legacy PXA DMA code where it is used.
> This enables building spi-pxa2xx on ARM64.

Applied, thanks.

--+ADn8P7LGHbCQUlh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0n2fAAoJECTWi3JdVIfQwXoH/jn+gASYym6DDRGrwc8ivkcq
QT621Aa0cB3WE3/0ZC8iIGaBzBQKywaJw6gjTjMDBTT+6PEZ/tsPe7VeW1gdmNtD
7Xwx8Y/cKnfyy37ClxFda7FdY2z79MFbGEbuxVS4TjsW0gKaXpvBY7X/56f7XXRj
wPK3M6ZGFTSIaqmZ0F8anABgUpyN9gF0bagfZaA7tpAlc1Fat2YhLXP5aGcy0ZZQ
NQmLe+kgLLCMy/q8u8vDBdpmWfutEjh+hP72q1Hg2CFSGHYVazNLsQzQbOTjignk
/2lIj8QhpfB7BF5bjADdUpXiPzcci/XHEYpYXdVYL4MnTUqINVMV575gSYbkFnA=
=W9M5
-----END PGP SIGNATURE-----

--+ADn8P7LGHbCQUlh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
