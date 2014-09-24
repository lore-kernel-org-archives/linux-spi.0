From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/10] spi: dw-mid: always use duplex transfers when DMA
Date: Wed, 24 Sep 2014 09:44:07 +0100
Message-ID: <20140924084407.GF4015@sirena.org.uk>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1411060140-2801-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5tP+uu4DqNOLJklJ"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411060140-2801-3-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5tP+uu4DqNOLJklJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2014 at 08:08:52PM +0300, Andy Shevchenko wrote:
> In case of DMA we never got things done until we enable both channels. In case
> of receive only or send only mode the user has to provide a dummy buffer.

The driver must never impose such requirements on clients, they
shouldn't need to know about the quirks of the controller.  There's
support in the core providing dummy buffers for transmit and receive,
you should use that (possibly extending it so the dummies are only
provided for DMA).

--5tP+uu4DqNOLJklJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoRWAAoJECTWi3JdVIfQZH4H/idaPNP2clsZIguyvYfWGdMq
1O/rsIdylDSluLD5foEP0shQaLEFzk4fNwAvN++dIVFBUqyDT+Ho3jpG0BTo8HgK
0WBOr0OomMLG5vm2o3ELq2SbYe8LnitdR9P9ED11Nr+n0nc8MfAm4s1wQOZURA44
D9C+xc2HmCJTN/lvF+d8L1Cm+inbr44yZNa9dtE2No/IJ/ww1PdxLbKLaCfiZqBh
n8GvcAH46RQ7+7GJCgsmtXon9E604xZV5rlnXNB6WerNlxsFostVACQL2dAJh9RB
Q9hS01eKs/KeEAuff9LoE/l39fyZbdRR6Tw/yIm89Oc9CWBZybKNUGMrQFXgci4=
=Hwqk
-----END PGP SIGNATURE-----

--5tP+uu4DqNOLJklJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
