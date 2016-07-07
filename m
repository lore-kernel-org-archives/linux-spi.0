From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: do not disable the clock while configuring
 the spi
Date: Thu, 7 Jul 2016 14:24:41 +0200
Message-ID: <20160707122441.GP6247@sirena.org.uk>
References: <CGME20160707072419epcas1p3ba881fb9b3270eb8cde87380aea7bcf9@epcas1p3.samsung.com>
 <1467876237-12183-1-git-send-email-andi.shyti@samsung.com>
 <20160707095840.GH23620@samsunx.samsung>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YQQMu+1WUtOZ6W1X"
Cc: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160707095840.GH23620-4M0o0xkwKdT35fTxX1Dczw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YQQMu+1WUtOZ6W1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 07, 2016 at 06:58:41PM +0900, Andi Shyti wrote:

> sorry, I will re-send it because I should not remove the comments
> above.... in the future someone might wonder why it's multiplied
> by 2.

I already applied and published this, can you please send an incremental
patch fixing the issue?

--YQQMu+1WUtOZ6W1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXfkoIAAoJECTWi3JdVIfQxSgH/2DbRl77bFbweobnnQkjFl29
+yVtM5aKB6pWPZcVPSM1mXlYWAelzSHqLxugSV9IO9fYFMhFIgq76lmRT+yDuUHn
djkcg4ZEjuzhQlR1gxdujB1nCb+nqNqymjnHxSTLaO/47EuQh/oIZWrX53d5xyJw
4zWgWGGOQCt9w/7eiyhz/epNB5JSxovvBMd5K0E5onixkor9vzNFcqUgfZqeXvaJ
QO7263nriiwNCp5CJQDLnvqZS7XWO4hakVHn578KbMCVhFgCOyhoCjlfNA0QwIcL
qUyp/mSoXHjtWUKa0g5u7IvwJQGvkl9OYsT8MYF+txpXcQsCIkRoMQMq8FFRy3E=
=Lg31
-----END PGP SIGNATURE-----

--YQQMu+1WUtOZ6W1X--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
