From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] mtd: spi-nor: fix DMA-unsafe buffer issue between
 MTD and SPI
Date: Wed, 3 Jan 2018 11:49:31 +0000
Message-ID: <20180103114931.GF5603@sirena.org.uk>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <1514313927.26695.19.camel@impinj.com>
 <20171227103609.GQ1827@finisterre>
 <1514405711.26695.67.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Cc: "nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org" <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        "computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "vigneshr-l0cyMroinI0@public.gmane.org" <vigneshr-l0cyMroinI0@public.gmane.org>,
        "boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org"
        <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        "richard-/L3Ra7n9ekc@public.gmane.org" <richard-/L3Ra7n9ekc@public.gmane.org>,
        "marek.vasut@gmai
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1514405711.26695.67.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 27, 2017 at 08:15:11PM +0000, Trent Piepho wrote:

> A random collection of spi master drivers will accept DMA-unsafe
> buffers in some way.  In some cases a framework like spi-nor provides
> the fixup to spi-nor master drivers (none so far) and in other cases
> (atmel-quadspi), the spi-nor master driver has its own fixes.

Everything really should be DMA safe.  The thing with skimping on the
DMA safety is that things generally won't explode every single time but
they might explode.

> What exactly is caught as DMA unsafe and what is not will of course
> vary greatly from driver to driver.  Some drivers will catch highmem
> memory while other drivers will only detect vmalloc memory.  Some will
> only catch an unsafe buffer if a specific SoC known to the driver to
> have an aliasing cache is enabled.  Some will check buffers that arrive
> via the spi_flash_read interface but not via generic spi transfers,
> while others will check all spi transfer buffers.

As I keep saying here the real fix would be to have a simple API that we
could use to tell if we're dealing with something DMA safe.  Right now
it's a mess because you need to pass that information around through
every layer that references memory which is a pain.

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpMw0oACgkQJNaLcl1U
h9AQSAf+KdLHQShKUCckRDN+9aVdQFD3qT+Bx28dXtpMxXM+XGUk0RMl4Hvbkb2Q
Q31Oehypjtk9sY1KS5xh6AgvPQrAEfo60gSI36FG3gV8G+3jFxm3qM1mxDweHCey
VNegIt2Fx6EOOqRjSo2s9y8BJNNXKEaJqBamBhkSqNTHEnD82IpVfrmEoE5AVsa8
PyL1v4i5T6hPxoyg81aXIeD3DGEemOQbWEJenDTGGc8X5ieaKfq9bXydTwbMbtYU
qSaGjbGCqqOjUItEVUPo6WnCOVQhow+JPgPJ3vMCdH0UDNCr29cEupRbRMYAUPo4
Op15qcLdpKjnPgo3yj3iFZcG1YiMDg==
=ajYs
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
