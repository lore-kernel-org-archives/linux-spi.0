From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/10] spi: dw-mid: terminate ongoing transfers at exit
Date: Wed, 24 Sep 2014 09:49:28 +0100
Message-ID: <20140924084928.GJ4015@sirena.org.uk>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1411060140-2801-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MD+Ffo4VJSI0Ass3"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411060140-2801-4-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MD+Ffo4VJSI0Ass3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2014 at 08:08:53PM +0300, Andy Shevchenko wrote:
> Do full clean up at exit, means terminate all ongoing DMA transfers.

Applied, thanks.

--MD+Ffo4VJSI0Ass3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoWXAAoJECTWi3JdVIfQAPcH/ijSb93+MtAyv0Ew9852Vk+v
O+WPOAoWC5OWw+Juzy3XqAsRNCpdteb/8oYBca/7ehUUz42bgg9mqPMiAKSIWf8Y
Zyi5X0qzyhYW6puwQ5Wk/GBt1ue69OAzhI7lnJ0qpk7Ip1QHSDig4gKLwoNUQ5OA
a38Ti7jsvYX7tBRkpS9/HpiCfWoSRmdUN11Q05PYsSTITY5uyzKfku41dlZ+8byg
zS/QaEdEMzymGapjKacnNxjWacMb3DorAgDoZYsEjS+BVCI4fYCeJNuV3Vr3r2nq
Xxtics9hYIM6khrBJxxS3TAtJfAQ7xseZ8kw0PZ6hBGjVkkjsVOjQa//QUAGsSw=
=A8Sw
-----END PGP SIGNATURE-----

--MD+Ffo4VJSI0Ass3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
