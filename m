From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 7/7] dmaengine: intel-mid-dma: remove the driver
Date: Fri, 13 Mar 2015 13:51:13 +0530
Message-ID: <20150313082112.GF32000@intel.com>
References: <1425912531-23457-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425912531-23457-8-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150309181151.GN28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150309181151.GN28806-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 06:11:51PM +0000, Mark Brown wrote:
> On Mon, Mar 09, 2015 at 04:48:51PM +0200, Andy Shevchenko wrote:
> > Since the last and the only user of this driver is converted to use dw_=
dmac we
> > can remove driver from the tree.
> >=20
> > Moreover, besides the driver is unmaintained a long time, it serves for=
 the
> > DesignWare DMA IP, for which we have already driver in the tree.
> >=20
> > Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>=20
> Applied everything except this one, thanks.  I'm OK with applying this
> if Vinod is - Vinod?
yes I think it is right time to do so :)

So:

Acked-by: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Thanks
--=20
~Vinod

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVAp34AAoJEHwUBw8lI4NHX5AP/jwHlEv78P6lQ0B141OP+q/m
aDjS/VTX0X9ytEPOINI9OxDkPBR4wyx3P/q112ImPIqePsdE22B0bIgLGVjLUAQv
mXBam72Ku6XRAz8aNT+l4bFw7Cr+NALqnOoC2EHWJfEgxCqB0eBMDK+FrnFycNga
HkLeZkoNO2PYkEF8+gKMdZkHtAhGUTy8bdZM3xRzGQEKS2+ezBswX2aM+L925yoU
4q8/JM2z5XqB20PZZN9pUJeiaUsRtSvT+Rv0Rd9aIepHepbyjRxLiX9oXDDuU7dL
TaBil3WnkTcVsa+p5SAFlQqx0kBSDXR/7txs8GLK5Jx/ZyhrYTgJJIpBUZISQ1Mm
SGtiUKIBIng/Unu8nZ6T+wIn2ojmm0dyaNSXf8cFXi9nVzBpUpokwPYi5ALDqaZd
qGGaygojyz/X2Y3FGV7GGU6DZGs98TFpdOQ/1VcXfQEX84pC32QF3DyzlHwZORBV
EV8YOSdB/1R6KDfBceGdb5NFl0+7n5whW7w+23kO7Kk5PNyRl66RYOddLy8jtneO
bntZ6RokiIFJWQS4rjzbO/ma4DJYO1UACkut+UAvAPy077q1TFAwQaggRDTHc6yr
ozuDzeUR6Jxm9rlHIs+zg2vdShG1dJ4ILGPZV9DXkN/R5U1gvkjkB93G8Kuzc7b3
Q/XY8pWKny6JhOwIo7/V
=mHYU
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
