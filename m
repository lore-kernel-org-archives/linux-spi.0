From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: dw: amend warning message
Date: Mon, 5 Jan 2015 20:21:06 +0000
Message-ID: <20150105202106.GO2634@sirena.org.uk>
References: <1420207565-14712-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1420207868.12456.16.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4D23EFnZpzTzcHd"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420207868.12456.16.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--z4D23EFnZpzTzcHd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 02, 2015 at 04:11:08PM +0200, Andy Shevchenko wrote:
> On Fri, 2015-01-02 at 16:06 +0200, Andy Shevchenko wrote:

> > +			dev_warn(dev, "DMA init failed\n");

> Oops, based on some WIP patches, though still applies smoothly on top of
> recent linux-next.

Not with git am it doesn't (I suspect mostly because it's easily
confused by not having the required SHA1s but still).

--z4D23EFnZpzTzcHd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqvIxAAoJECTWi3JdVIfQ6AYH/j1kA6zFMXB/ckKEEDV42/2J
QlMLgANDV3teUdlwXRoRGZpCyrggQkq1uTdJcVUBpZxMSpZibw4eNDy/sg2rPhuY
+ItXThAnDmz4oN/eyoP2AuLWbnlfzZmPl+fWexT/25xhO7jYgAlzxmp44f8Nb3dy
97ESmUc36C+RCiPtqAXF9CdbEZUIwqjOtctdRPzGKkE+DnHdOsIDgAOjPEjJ5kwG
RVtHvhaFvzB5Bxj/I3FlGF1wB3+/zjE7N85LSGPj75Ym4r7PFKy8BEjEQIHR6tcr
Aj4DOTPN5icUsCB7AC84vFNB+JWydDgX+aHjmA26GJsoNOvk3vAE8aop617vVzg=
=/syI
-----END PGP SIGNATURE-----

--z4D23EFnZpzTzcHd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
