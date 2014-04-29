From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Tue, 29 Apr 2014 11:37:58 -0700
Message-ID: <20140429183758.GH15125@sirena.org.uk>
References: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398705774-12361-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 10:22:54AM -0700, Maxime Ripard wrote:

> spidev device registration has always been a controversial subject since the
> move to DT.

Why can we not handle this by using sysfs to bind spidev to the device?

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTX/GDAAoJELSic+t+oim9OO4P/A0v999A839gFBUtIPsjaZfX
fnwlIoUDAfj/yS7P9TkW71a2f3NmObpKsCp3dmphQVLG1il+HgSkGH/qihaDruZw
AvcIoFWE8tnwPRSget1UykDzkMuYzMqBc3TeyR02yihiEt7nUHDesEQtfwCfSq/j
2yq+Rvw4UGyCVJ08Zi5hbrGbzSB+XDjNX1vY/jRRNjKZXepNbqrPuDyhfZ+XyZbz
ijTv/V1MU36oTP1aA5JNm11GMjD3/8GQ/wCq0CsoCRJiaPnZpgvSUXgAuXTIHP+H
d4Rm5yn8xe6EzAJn88kUjVLpbTbq+DxGVtXRMGMlFgkIBphI3G48QoU6ojW9jqzT
c9lzJy+cmqbvB3typBNk/AbgYLKrkl3sYBl/k/FjVbkPRAINkKreOkLCuCw5ZdxR
44b0xsaH2TvT9yml0Xj0y+7STBbTXGvX+t5+mipG+Ridx0a5lQ+NAcjzEt6or04c
q86GOgvSjmTSA6JzhFLTlu+Y8kYYT4wKW1jblnvLCLe6pigNXF2oqKWlWn6ohtAp
+PZKBwcbvuCXCU+0gMF6tVHGzTRu37xzD5pGNp/wMNN4hV8oLzWh5I//fYhj0ngg
xZKZ+WfwKv9VchoTiTyVMfLGMf4Ri0AGAbaAh3vR/qoWiACIFw0vWL4RxZjsnbu8
0CniKFUtrfu7BCF37IEg
=omHj
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
