From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-espi: avoid processing uninitalized data on
 error
Date: Thu, 27 Oct 2016 11:14:17 +0100
Message-ID: <20161027101417.GG25322@sirena.org.uk>
References: <b5d3b5f3-034e-28c4-e616-69de4bf7cb8f@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b5d3b5f3-034e-28c4-e616-69de4bf7cb8f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 27, 2016 at 07:55:30AM +0200, Heiner Kallweit wrote:
> When we get a spurious interrupt in fsl_espi_irq, we end up
> processing four uninitalized bytes of data, as shown in this
> warning message:

This doesn't apply against current code, please check and resend.

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEdN1AAoJECTWi3JdVIfQCNYH/jll2msfeYMbzvpvHbfHmVPq
c7qRdVOeyHr72KY20ZT0Xu9zC2f255rgUGi6e2UXLXyDn05XqpBvEPvJygC7sosW
JuPrt6jvnJEG1F4CriF/e/uR/pDyX2/fqswdQQrsHmWwLxBiVticdarDQPMna5Yv
rugQdh3xjDIM5YlOlC1iH3wd6jxnNFO+4nn/HdP+aGwyhBqYc2kxdDpCQ3iAubxy
4YEGYYvHsByH0iK6OCfoZg/wA2Rek1l7Ex/NCzl+GZbRR07h81MMtCGTaqffGlTO
YvixgFaInjg8GvUEeHRgEN23NdsvYYNzIPc5IuojgYzkK+w17Q1q4g6uhs5+UdI=
=lirX
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
