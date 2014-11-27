From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: st: Provide Device Tree binding documentation
Date: Thu, 27 Nov 2014 16:30:59 +0000
Message-ID: <20141127163059.GZ7712@sirena.org.uk>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-3-git-send-email-lee.jones@linaro.org>
 <20141127130053.GW7712@sirena.org.uk>
 <20141127145542.GH4628@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dfAulW8sdm/Y0CsS"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141127145542.GH4628@x1>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dfAulW8sdm/Y0CsS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2014 at 02:55:42PM +0000, Lee Jones wrote:
> On Thu, 27 Nov 2014, Mark Brown wrote:

> > What do the two different compatible strings mean (for example, should
> > ssc4 be used for version 4 and higher or is it just a quirk for that
> > version)?

> This appears to be historical.  There aren't any functional
> differences i.e. we don't match on them.  I believe the former is a
> more informal, generic name and the latter is the official name of the
> IP block.  The I2C component already upstreamed has the same naming
> conventions by the looks of it.

Probably best to say something or retire one then.

--dfAulW8sdm/Y0CsS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUd1HCAAoJECTWi3JdVIfQOWoH/1hYO3qV5JbFVeE0xphBa4Td
1xry2lXjk5lelhXBiNcpkEq2hLJVXQntjaLu5L2syKi9TvD9JNT6HycJvVv33vU3
jlkcY7A6hM+ol8ExKBH0rcUQS/mWFPqj19+WtKKR01NlP08qaN5KHJmxcAseGxNV
J2Y9t4usSRw2XTtxOXN/R4KcwZqZSFdLA+NPFJv92B9UVnzEnlKCLDxdB8ETSfCS
C7MBYmmYyDvbF1waozT0bLBV2qMLj8L+pA3CGWBW8zZQANL1FNHsC1ciNx3Qa2y7
Di1Mgs1UexxS+zl7OgWGyPc3MQorck6DOPhJkBwct7HliP9egEUCvw1yVsY7dk0=
=mAJ2
-----END PGP SIGNATURE-----

--dfAulW8sdm/Y0CsS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
