From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] Documentation:spi:fsl-dspi:add DSPI dma transfer
 support
Date: Thu, 27 Feb 2014 00:38:22 +0900
Message-ID: <20140226153822.GC2394@sirena.org.uk>
References: <1393311258-14380-1-git-send-email-b44548@freescale.com>
 <20140225090830.GO28555@e106331-lin.cambridge.arm.com>
 <20140226141947.GE23892@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140226141947.GE23892-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 10:19:49PM +0800, Shawn Guo wrote:
> On Tue, Feb 25, 2014 at 09:08:30AM +0000, Mark Rutland wrote:

> > > +- use-dma: the bool decide if use dma method in DSPI transfering.

> > Why can the OS not decide this based on the presence of dmas which it
> > can use?

> Yes, OS/driver should decide to use DMA or not, but it shouldn't be
> based on the presence of 'dmas' property.  The DMA is a hardware
> resource just like IRQ.  It should be just there in client device's node
> as long as the SoC design assigns the channel to the device.  The device
> driver should make the decision when DMA should be used, e.g. big amount
> data transfer, and when PIO should be used, e.g. small data.

Right, that's very common - but that decision is usually taken on a per
transfer basis so a DT property would seem odd, especially just a simple
boolean.

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDgpmAAoJELSic+t+oim9UwgP/iKN+UxCcQesTmx57ClFgynd
Skz32s76kUAa8EOGHyDmZ1UdEad6AytxpYv0YKIlJPQBO+CI7eWGXJ2yHGM+FLxb
QIG6ZFVd/u6q47NV4m3kxNsyX9EXyBCWqoCOGK3uffV6QdWPGXiCcV3CnK/Fpptx
qbZxQE1uwYBAVBzO7ravumvxE+uUZOVhz+IoMm0OMUCyCtwm9n/1RHXqdgqHprYf
1QysQCnNQP5g5tZ2l+lh+MRvLVRhFAOykeTHcapdpPkv1A3isitz7fEiVPVaaqnP
tGYDvxJfmBvwq7KH3OgAIhsJH1Pv1ax4rPFPZI0ufo5LfUwrgev0/bKeivVKAXfd
P4m7UCId/9TVPFubPhXaQ0Fltfiy9OmfYj4G5oZG4Iw8YQSSdQr1cU+CtC1wlreY
IM/kAGj08ZoczJxJlLHNTAK1VUv/alVR8P6nVvmyY793idTmo5FwBhOSe+wVRdVK
aOT/7nbUMsuCjzyNK/nwpp5Z+yYGTD4QYtBCqTbVeGylTDpxMaCJfb29nlity88P
17CydR4JDZn9/vQ+rAiYlADoShhPYheTw4aepXDsnaBH+50Y9OALg59DzvmWeJ/g
Oi+PocFsC1gVmuJ0nZ5l8nkbJKy8BJay+jeEQMPN6DbTgcxMEu3dzfjgW1QoN1d8
STHVYk3DV3ICXcT4vVlK
=Asic
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
