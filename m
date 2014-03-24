From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: topcliff-pch: Properly unregister platform devices
 on probe() error paths
Date: Mon, 24 Mar 2014 10:57:19 +0000
Message-ID: <20140324105719.GF2269@sirena.org.uk>
References: <1395647215.4333.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Cc: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>,
	Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395647215.4333.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 24, 2014 at 03:46:55PM +0800, Axel Lin wrote:
> Ensure all registered platform devices are unregistered on probe() error paths.

Applied, thanks.

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMA+MAAoJELSic+t+oim9SDAP/jQh4thcWsTQxOcYQKSf20gE
KA8p8l6n23DfwEMJhMpmVs8lW4FYHOzSG0bQVz5j1gs1KtlvIuYoFyN/MzE91yeE
iXu+GLG45bMldrRMXNzc63cbc6/IqlF5srN/WBnjg58VuBPUn05VDONuuHMYL8Ix
IHbSMNLMzeFGK58LECVezASxZijRkrgKjZqUvxi893MKlR5GgbVcu35MeoDps6O7
+/WMtYCMjPRwxN72+Ql9OE9to+6ugg4moYmv3UM9D8oqnsYiWS2sO9PTubpb1Gta
CmTZzy4/uZB0uF8EYIKEboOdx9NCgJDZmQHbU+nlUQU+8EPQzlieWFsk6weuz0Xh
3hW3s/YZ0wn/tx6gCRqvvHwmcsP4bi9Ezga9Ud6EDND2T1gBnkmiMTuY5jGtRKRA
NvpThxT9gyyEMX9ZFrxJPODdlgqIeKYlt2b0IPyCupoV9LkQc/phAHg4u3Z7YiDX
Z4P+9FlI1LPQquN+RsbcVGS+n4D4J9LzmZ+Irq/YVU2S4nRtX0RPyWBkAf06fKBY
lb93hdgdhuysp9qw5NV7C3NAbtW/ortlRbnCMvU0x4Tp62sYBZgXaBz+hFo7OVcN
GKb1ApOLZt7L2IXoLh+MNrDGiZRLltdDLEWJH9/KdIhDgqwjB2wh8qQKA8Y7Dlcx
IVPwCZz61Ci1qZmgrND2
=lYNa
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
