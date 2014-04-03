From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] devicetree: Add devicetree bindings documentation
 for Zynq Quad SPI
Date: Thu, 3 Apr 2014 22:01:35 +0100
Message-ID: <20140403210135.GX14763@sirena.org.uk>
References: <ee057d8c-50d9-4d4b-ac86-d7c5fc44b1b0@TX2EHSMHS034.ehs.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LvnU4bbuCGLV8PtK"
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	kpc528-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kalluripunnaiahchoudary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ee057d8c-50d9-4d4b-ac86-d7c5fc44b1b0-8XeO8fnFoNELWPPp32rIc7jjLBE8jN/0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LvnU4bbuCGLV8PtK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2014 at 10:33:06PM +0530, Punnaiah Choudary Kalluri wrote:

> +Optional properties:
> +- num-cs		: Number of chip selects used.

What does this translate into?

> +		num-cs = /bits/ 16 <1>;

Why the odd specification in the example - why not just specify it as a
number?

--LvnU4bbuCGLV8PtK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPcwsAAoJELSic+t+oim93CoP/1PVC5uFm8g2siiedwBT/i6/
bxn9DwUFSjSfKJw17ChAec0HEczUq/VEM4b43aMQmgpOvfHtXaHLOvQQlF6naPp4
nBq7qG2zBEm0EnWnVXKonhVfbEvt1Dlf/SwuIfJNBZFZilFB13hHJaNC9twVaNdq
FxLHYBNvHv4i5gHJWtIue6f31HnVQptamx7KrOr+2eg/DAy2qBUdO4jUzZdOwBWu
o48997SECtfbhZ+FbUsmcNLSK4ClqiaiwCDA5712iNJV41UW3SlHgEsdr1AEnvVH
YPFslDOwE0VUH8ZhTLxRijToYFBhzQU0vk7m6VkrU1pKFIO1f1C59+03IOgEgcfA
AoDjs33c+/PKRuB92n8BckzZL8q3gYO+ugUqvNOQYId+HYKEv90SKlSkE/tkVgMQ
AkY+ke+DxjmfTUOMdpTG0fM+rhnJkTCwpSC5dGtk/STlK+Z8rU6wp43ZH0YFJ++Q
BvVxpwKNzL10ZltYzB8qbQR5cldAs1vyY45JlPDeXRzpFJpu1NcXaRtqMfM8y0ML
ZXBl9ZhHQ4tYsleKVclv3E3JZL2Id7gzJPrIHIPDt0gQAk3HaeLe6sKJndMpvaFE
sb3EEec4Wd4rLOZH3K5oi40WbVNWjC/87i4Vp2MptWoA8UOU9n9b2FYN4l46yTWh
SgqEGvfCx7mS7f+amF1s
=eYZ1
-----END PGP SIGNATURE-----

--LvnU4bbuCGLV8PtK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
