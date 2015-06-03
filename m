From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via
 sysfs
Date: Wed, 3 Jun 2015 12:53:19 +0100
Message-ID: <20150603115319.GF14071@sirena.org.uk>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org>
 <556EE446.3060407@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hplhpi8yEJNNWiIl"
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <556EE446.3060407-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Hplhpi8yEJNNWiIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 01:25:58PM +0200, Lars-Peter Clausen wrote:

> Having those kinds of stats in world readable files has serious security
> implications as they can be used to implement side-channel attacks. They
> should probably only be available in debugfs for root.

We do get to control the permissions on sysfs files, though it's a bit
more unusual to make things root only (and there is the histogram).

--Hplhpi8yEJNNWiIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbuquAAoJECTWi3JdVIfQ3JEH/3CmjTlRH35IsP2I1u7swIPt
TS+Tce02gwfbZEcqIB+2nfFQ7+F+7xG5BjGTCY7OQviHIhGE6B5AcxhfPcgPRA9R
TNNaqSoLFfuU5jJbJ+dC9E7WIViekD+bOFq3LSjoawSKFzj8JIHJjFqm5Cd5Qsl7
7b0MGr0cIVX7h9Fy+ZR+pT4Ryvfbv/zd6kF34gTkeXig1AmcGXRmvwOrngHl/RTz
ow4DV4NV0KtO2WeSVxPrEEKhOkh3TFVQ439PzMw5vXJWUehwloRgwPJxCYExN6eX
90qz62FLLdh4TIcd1sGDFdOfXio9IsjVMyhww7P8nYGtihDAc10OG+xLURPDENk=
=op4Z
-----END PGP SIGNATURE-----

--Hplhpi8yEJNNWiIl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
