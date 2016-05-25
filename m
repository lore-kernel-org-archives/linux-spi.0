From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 11:38:10 +0100
Message-ID: <20160525103810.GU8206@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej>
 <5744BC76.9090403@gmail.com>
 <20160525092034.GE1337@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7oqf3GZ7P06zs6V6"
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160525092034.GE1337@leverpostej>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7oqf3GZ7P06zs6V6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2016 at 10:20:34AM +0100, Mark Rutland wrote:
> On Tue, May 24, 2016 at 01:41:26PM -0700, Frank Rowand wrote:

> > The code and behavior is in the Linux kernel. It should be visible in
> > the documentation instead of being a big mystery of how it works.

> As above, I don't entirely agree. Mindlessly documenting existing Linux
> behaviour can have the unfortuante effect of moving people towards the
> wrong tool for the job.

Yes, this is exactly my concern - the articulated use case (which didn't
suprise me at all) is for using spidev which is itself not just Linux
specific but this particular version of Linux right now specific.  There
are lots of things that happen to work but are in fact terrible ideas
that leave messes for our future selves.  We need to distinguish between
things that are real, meaningful system descriptions and things that are
implementation details resulting from the rush to force everyone on to
DT.

--7oqf3GZ7P06zs6V6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRYCRAAoJECTWi3JdVIfQQYAH/jFnDJHc2isn9cM1xXGAfYI6
eIM3tzhcghVmJj9Ranlnazxw9Gg+4t7GceyYV35MCRpj3TX92BzArTnWxDePJaKG
3Ytyvbv2xjLP4yOVWkukigvXJ6t061YWJalG8PZ6lLSaQj3lCHOVuCrbhbZzKrK7
BWYJTKseDQ2Bta4ylK112iz0TG+4+tr7/CJ/6PrmLicfvHlbdLsUyBkHq28l1Owh
+Hm3iCxbpENANvlgG+4uAJSYtOoP9a2AsB4dslHiZ9AZQbRrbpZrt2U58n6EkYST
PpoK1GOboFkLnXHzQ6pHhnUN87IglklLERS60GImQhNK8sc6nwxW8SFwbZHbaGI=
=25aX
-----END PGP SIGNATURE-----

--7oqf3GZ7P06zs6V6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
