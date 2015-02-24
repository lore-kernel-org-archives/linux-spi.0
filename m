From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 5/5] spi: dw: move to SPI core message handling
Date: Tue, 24 Feb 2015 23:44:33 +0900
Message-ID: <20150224144433.GL6236@finisterre.sirena.org.uk>
References: <1424777534-14246-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1424777534-14246-6-git-send-email-andriy.shevchenko@linux.intel.com>
 <1424782738.14897.22.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEFDyIIeORe/70g6"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424782738.14897.22.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PEFDyIIeORe/70g6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2015 at 02:58:58PM +0200, Andy Shevchenko wrote:
> On Tue, 2015-02-24 at 13:32 +0200, Andy Shevchenko wrote:

> > -void dw_spi_xfer_done(struct dw_spi *dws)
> > -{

> This one should be removed from spi-dw.h as well.

OK, I've applied 1-4 but not this one.

--PEFDyIIeORe/70g6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7I5MAAoJECTWi3JdVIfQTLsH/j5L2pBfBiZYWyLrXU6LP4c9
vyHMCDrzkXFX00OjB9JhkafubakPgBjXjtOnrXgIyXi/QJS4JjG0UTWQxTJssCJb
BP3YOozAGctZR2HCOKliIky2U+LIPHW4aMXWZ11/beRmsC8LJxio6J0r4nlrsxkW
fFLmDTuCs7vMbDAiFOS2ydjVkdaA6nxLMed2JGP+Di2D4IxRMLuLYJbRDxiGdifj
48K7CqZ6gY/VWxTgwN9kz0idq87bhKhQfzqSPbWDPxCDS1QH6sxm6cAyKEHpCR0R
aPg8GH2E8f70MNVBZNzELEilMcPGHOGBWNR8Ct/I9B1IhL6CGVPBL0hhShy7ogM=
=jNbr
-----END PGP SIGNATURE-----

--PEFDyIIeORe/70g6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
