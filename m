From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sh-hspi: Convert to let spi core validate
 bits_per_word
Date: Sun, 23 Feb 2014 12:46:28 +0900
Message-ID: <20140223034628.GA25940@sirena.org.uk>
References: <1392214192.11101.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MbsZhpoBPAblP5dJ"
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392214192.11101.4.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MbsZhpoBPAblP5dJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2014 at 10:09:52PM +0800, Axel Lin wrote:
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.

Applied, thanks.

--MbsZhpoBPAblP5dJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCW7ZAAoJELSic+t+oim91wIP/0iQnmAQR/782mfZwbg5Fnf/
r3/CZPaAJClZbnhA1Uk2tmKz5yO+/CbJnsh44ZvTkEKvD4N77qYukSRnZzek6wIp
vWqkKu81S+/I6jUo6cWcDJ5FbBrgXB79eLOSgKDECZNwakT4bF6akJMB3YY/fo2v
NmXeXiSndWn+OB7NzIFC+KHNOl/6caVk7WqQ7rZQSwEnNVAtzA0J5o0QNKi1Sxk2
PEHNwFifvsNB+r9T/bIQe48xBn7nkoX5/xC2Cr4OhRf+vXE+bxojOjugnpTcM0Bp
qXFuov14MmGYwUF1KZcrpSA+XyTjH9yMoq+FPiwhOfgeakVNiuG28rXEkCi12VHt
+zsZJ0rt9rpWhCbZiJ7jDe9BjbL/mUqBFoWdyXJaVI3Cfx6PxrcMN2k78Nsx8zgt
AEVv+eUHfGqp7NdraWjspSa9vKYHwU/ZIb2qQrRFugd/GzA0Z7+3CnfVsB5aOE4/
ajTM91u53wnCYHWmS7zkhoaJxwj97FikOcUrcCAxMY253IA+nOa2Fsd8NVWifaMU
82KEI85ZpjwAYmZFrUfiDzqKvVHk+2F2NqcPrYmKYal9S8X49L0OxYSUKlCTKiZH
RH07WMd/9h5+7YcrvhPb5kzNYBQg31JqTRFOC8tm8AE/7J0cti0rC+fERKVgp3is
df62XsCUsn38MBqsV/9x
=WAoJ
-----END PGP SIGNATURE-----

--MbsZhpoBPAblP5dJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
