From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/10] spi: dw-mid: follow new DMAengine workflow
Date: Wed, 24 Sep 2014 12:08:49 +0100
Message-ID: <20140924110849.GH16977@sirena.org.uk>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1411060140-2801-5-git-send-email-andriy.shevchenko@linux.intel.com>
 <20140924084453.GG4015@sirena.org.uk>
 <1411554938.30231.12.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411554938.30231.12.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 01:35:38PM +0300, Andy Shevchenko wrote:
> On Wed, 2014-09-24 at 09:44 +0100, Mark Brown wrote:
> > On Thu, Sep 18, 2014 at 08:08:54PM +0300, Andy Shevchenko wrote:
> > > Though intel-mid-dma does not follow a new DMA workflow let's prepare SPI DW
> > > driver for that.

> > I don't understand what this change is supposed to do - what is "a new
> > DMA workflow"?

> The client is obliged to call dma_async_issue_pending() which starts the
> actual transfers. Old DMA drivers do not follow this, since requirement
> was introduced in 2011 IIRC.

> Current DMA driver for spi-dw doesn't follow this, but dw_dmac does.

So be specific about it missing the call so someone reading the
changelog can understand what this is supposed to do.

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIqZBAAoJECTWi3JdVIfQgSoH/3UW01OuGM/QyKswQzU5X/uI
5CLQ+aWgL3BHEuPWXg/LM6KkB7rRnk2GlXBTHL7G7PFSk3rvJHiEhuaY4aFKWL9S
eTXYOYC9lBN5DBMHOQQGHZmplhW5vAT6gIRCkIV6zLCtGMW+bgqmeI1LAtuNMc5b
YrW+LqR9MJ7wqN19XA2s2NoEIvrOz/STHHtu1MD0939+pZSzxgVeS9mw1RUzgrbA
+gXUnf54Avb7xlPuwEYGTDrB5w/+lCDaVC2zmJ1UqClDrP9Yxqgr6JwqgwkRCWFh
ZW+GBfIHGUP9VoqpwVbwui6e1nn2JsgQ7z5n5JYjJHhXMIhCXBF2Zh31I2t01uU=
=Xlq1
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
