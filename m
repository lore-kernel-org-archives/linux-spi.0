From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-dspi: Fix memory leak
Date: Fri, 28 Mar 2014 11:47:57 +0000
Message-ID: <20140328114757.GC30768@sirena.org.uk>
References: <1395710345.29281.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fo/b2PYVqg2cQvBK"
Cc: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395710345.29281.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fo/b2PYVqg2cQvBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2014 at 09:19:05AM +0800, Axel Lin wrote:
> The memory allocated for chip is not freed anywhere.
> Convert to use devm_kzalloc to fix the memory leak.

Applied, thanks.

--fo/b2PYVqg2cQvBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNWFqAAoJELSic+t+oim9VsQP/1Z5qsCuQNZY8H6wsBvmd4w0
Z0lD5xkevivMvWtZAgqTBMQ+feRtN0gjwCbPFmTh9tS+qwJpSDq3Xa87yOER4vIb
KfeUfqYyKcQxaCn9bfupMD21k3Jidv5AA5la0aBZ6sQ/HnqPAVnwlWd75L8ipONd
WJpDgDTq6EbO/b7lNVRgBF+g4YUhqZwopRpGVD/9ZNebtMV3WpPR0IJUFUkwd6Uk
7TNCA3GRrqSBFs1YpPoZQKndnMN8xUWzEnBMUvqV5NMCHV5vQrh5q/qV/FN3CDNS
lhNL03AUhokFOHn9Ub0B/0AaQrsNp6x+2GEeBOTCxbERsw2yxvJAC7KwR0guwTXv
gcFFtsXy+33kms4NzVmejslO6JalfPcDpCH2+c9kb9e9XU7mBniY+Qx+PMZBxR/F
Zdtu+7Nb83iTpvAsDjQKm4xlB9NI/0s2IQlEUyxjOgVrilIXGtq/9M/Zgu+4UCZU
ebJDd6AXcHBqxs0lY9d0ShTTzkH5nV+kbnfS6eRR6OfUHaZbzupya9O/VVfA0wbR
jsoqPEduAtRscDHkhFjqScNdHMYHfwJmvgMGGriVMlr4zVZHzyruvHRXOucgjRkC
1djmg6yGKo1gsGlTM8oyyc47PbsqsXjW5fPE0E3OZ+T40Zh/AwJSwQRjLzjZ9bWb
JY5+iG+g+exJop5w/job
=YaFQ
-----END PGP SIGNATURE-----

--fo/b2PYVqg2cQvBK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
