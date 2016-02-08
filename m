From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Add struct spi_master max_transfer_size member to
 kernel-doc
Date: Mon, 8 Feb 2016 21:15:53 +0000
Message-ID: <20160208211553.GA13270@sirena.org.uk>
References: <1454965848-5120-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454965848-5120-1-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 08, 2016 at 06:10:48PM -0300, Javier Martinez Canillas wrote:
> Commit 4acad4aae10d ("spi: expose master transfer size limitation.") added
> a parameter to specify the SPI controller maximum transfer size limitation
> but did not update the kernel-doc so building the docs leads to a warning:

This duplicates a patch Randy sent earlier.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuQWIAAoJECTWi3JdVIfQW+QH/j+Apkk0DXfB+t/02GlWnV8P
OAssCWtMShRt1cB8FlvUUA5Y8r76Ojs7ORuvmrHoeSkD4Hm0bfe50eDybWW07e2j
6EfP8KScZHaFixr3bat3w/gKKDdV20VvBT1vwBpL0XErzQAE1AagFUX4yfaaKAQs
asztfVdmWLmU9UpX65SWGTKGcBjfFHldUdv/oTOqV2b5JPwq3g8LO9bR+d7LSYjv
WMYqaXwU0WIhxzYXl2rnl2V75sK+hwk9zW3Kn3eR76/H8ZID6LpKu3J6LoKJZSTn
Liza5gVqcv2883MMSE3WRyYvwh7QfWIaAdiXXsJXWSVHoCdGhgNTQk+K4n6IXbw=
=uKRm
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
