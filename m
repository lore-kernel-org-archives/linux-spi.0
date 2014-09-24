From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/10] spi: dw-mid: always use duplex transfers when DMA
Date: Wed, 24 Sep 2014 12:07:47 +0100
Message-ID: <20140924110747.GG16977@sirena.org.uk>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1411060140-2801-3-git-send-email-andriy.shevchenko@linux.intel.com>
 <20140924084407.GF4015@sirena.org.uk>
 <1411554747.30231.10.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411554747.30231.10.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 01:32:27PM +0300, Andy Shevchenko wrote:
> On Wed, 2014-09-24 at 09:44 +0100, Mark Brown wrote:
> > On Thu, Sep 18, 2014 at 08:08:52PM +0300, Andy Shevchenko wrote:

> > > In case of DMA we never got things done until we enable both channels. In case
> > > of receive only or send only mode the user has to provide a dummy buffer.

> > The driver must never impose such requirements on clients, they
> > shouldn't need to know about the quirks of the controller.  There's
> > support in the core providing dummy buffers for transmit and receive,
> > you should use that (possibly extending it so the dummies are only
> > provided for DMA).

> Currently driver in case of receiving or sending only will never call
> the xfer_done from DMA callback since we never will have counter equal
> to 2. So, the driver already relies on duplex mode. Am I missing
> something?

Please re-read what I wrote above, especially the first phrase.  You
can't require that we rewrite essentialy every SPI driver on the off
chance that it's used with this controller.

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIqYCAAoJECTWi3JdVIfQmJAH/i1XWn9kK+b+ghGM1hLgbCYF
fPtzOfnrG4muY+L/fg3ipTWqJ0gIKhRZj2HGukr9x1rB6UFpnS3kNGbmBMejdfEk
gmGgfGj6FJIFlE9G4UQsmYVmwy/vWZ2pOYUAGWpEVUIExOu7EtRf/HzWWCr9u6sL
rqSei0/7LPLyVVf4Pu89dyxNVJ2uElJC4yDMqGNu6eGhMwnY6v1Mpg8i+7iZOTH6
twXPG0Q2J721P9vZUdN+LtxiwB0la/SQdxRCaveQPyahuM+QW2wDcuzvhjGTH3Q4
bbNWwjnP9YT2WYojRT1lHI92DZe79APHx5jk6SauRhAGobhmMCCkaLq+RuMFrVk=
=sfAG
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
