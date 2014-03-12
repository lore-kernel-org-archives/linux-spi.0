From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi: bitbang: fix shift for getmosi
Date: Wed, 12 Mar 2014 21:37:05 +0000
Message-ID: <20140312213705.GY28112@sirena.org.uk>
References: <1394637636-29042-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394637636-29042-2-git-send-email-m.grzeschik@pengutronix.de>
 <20140312212334.GO3327@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a7SarfeDDnAelrrD"
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	linux-spi@vger.kernel.org, linux-arm-kernel@vger.kernel.org,
	kernel@pengutronix.de, stable@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140312212334.GO3327@book.gsilab.sittig.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--a7SarfeDDnAelrrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 10:23:34PM +0100, Gerhard Sittig wrote:
> On Wed, Mar 12, 2014 at 16:20 +0100, Michael Grzeschik wrote:

> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

> Is the Cc: to stable@ appropriate without Fixes: or a version
> that's supposed to be affected?  Has a bug been verified and are
> you certain that the fix is correct?

Like I said in my reply I'm somewhat dubious that this is actually an
issue but if it is then it's been present since at least 2.6.35 (when
the header file was split out of the driver).

--a7SarfeDDnAelrrD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTINN+AAoJELSic+t+oim9P7oP/2E4tx+DhQsoMJ3ISU7XAtwk
c22yBL5i2m7X3lspmeWsqs9+/jDC9m4nEn+DEQOg2H95WXJTn4p2doV2aoLqsv4X
eGYMeEXGHa45ByAVRmwCUumY4hWFw4PltUCAFCEIOeJCXnYd8nXWBDzw5IAn9eVc
LyUGpFDXa2uDp34oXxuCG00axVnHJJydeLNexUINXplCl6IRdpGLdY0iKwHkQavd
kNvvpfl9fZCKIVF3rnU8Mi1pDyCgdQArNKlHa/8NERYoJ2W1NK5RoBuyp2wOSNZE
KGBnq8p5G2F721uwTFptcAqpvyFTthZQcfeX+UWcCLrgfom661yHcrr64AI1s3K8
VbtpHHkyjUePpfjL2c5H7y6F5qtCtNMxbxbSr6AZHlj0bNnXobpp8uV/R7/2lxN0
54OHo04vS2kXHV+c3vTg6vQIa75DFE2zK0qwhtHtwuTrbtKHIJWrk3ZbfJ+f9AGU
WVEU1kU+6XBWNSvqL5Y25npJTC6aruXrQ+CkXrddLonDzjCes8gNJyM1z8yqPlT+
YlN1fXNjAUkPpRtkouoy7LA9B1zl6/jnrCPTGoHIon0TWC3Jpjivh/JpYUWZ62wY
FzZOTnEfDTEs30dRMUBaZHxbfddPtevXjwkrkLiBZpBechG+XW4n7hxKN6k+FfWd
e02kQ2N6974ARP2nCxgy
=OYXK
-----END PGP SIGNATURE-----

--a7SarfeDDnAelrrD--
