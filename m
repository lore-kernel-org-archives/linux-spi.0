From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 0/2] spi: dw-mid: fix simplex DMA transfers
Date: Wed, 29 Oct 2014 11:17:12 +0000
Message-ID: <20141029111712.GE18557@sirena.org.uk>
References: <1414513502-595-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20141028224156.GN18557@sirena.org.uk>
 <1414579076.2396.62.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gWZsHIcT9yoLX/95"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414579076.2396.62.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gWZsHIcT9yoLX/95
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2014 at 12:37:56PM +0200, Andy Shevchenko wrote:
> On Tue, 2014-10-28 at 22:41 +0000, Mark Brown wrote:

> >   Can you please also send a patch for Linus
> > setting SPI_MASTER_MUST_RX and SPI_MASTER_MUST_TX - this is a bug which
> > should be fixed in mainline but these seem a bit big for merge right
> > now, those flags will cause the core to always ensure that both
> > directions have data avoiding the issue?

> I'm sorry I didn't quite understand that bug.

> When those bits are set the core will always provide valid tx_buf and
> rx_buf pointers. How would it help us? Currently driver relies on tx_dma
> and rx_dma which are provided by clients if I understood correctly.

Uh, are you sure - how exactly has this been tested?  tx_dma and rx_dma
*can* be provided by users but vanishingly few actually do so.  Drivers
must not rely on the caller doing this, the feature will be going away
apart from anything else.  If the driver is relying on this it probably
needs to have the DMA support that's there removed as a fix and should
be converted to use the core DMA mapping functionality in -next.

--gWZsHIcT9yoLX/95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUMy4AAoJECTWi3JdVIfQNN4H/i41mpkAbIZA+0znb93YeuNl
AYzgQ9/jcWnDwlAZrJPQjdfE/M7MpbhG7zYt5GWzdAv5KOVwvcvBcdjIvV/RtJdV
rQAYNXUrQJg86R45fiiyzb6PusBxALv8Tm+a4UVK+/sh0NfIozhsNED6YcN4/ENs
IuuXdvnuSPY1o7MAFdzABTBtvuRbExrj9fdhiY/k2siE2GSdN9hq+bNqfWmxx05R
cBUc1rmdBKEdAaKjNgTheauqYdehFpxYK3khePM5x5Fz1TdNoKz+m498rVo5eUlI
1Xl24NLPdbPYiOUaEwUyU/fTB/vNTPvxC3BteYjKa0f+mK1q6maiDCX1v5PFimE=
=oioO
-----END PGP SIGNATURE-----

--gWZsHIcT9yoLX/95--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
