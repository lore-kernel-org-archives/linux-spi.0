From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 3/3] spi: dw: move to SPI core message handling
Date: Fri, 6 Mar 2015 20:34:14 +0000
Message-ID: <20150306203414.GH21293@sirena.org.uk>
References: <1425301137-8043-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425301137-8043-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yvCNGRer04nRnE3d"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425301137-8043-4-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yvCNGRer04nRnE3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 02:58:57PM +0200, Andy Shevchenko wrote:
> This patch removes a lot of duplicate code since SPI core provides a nice
> message handling.

Applied, thanks.

--yvCNGRer04nRnE3d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+g9FAAoJECTWi3JdVIfQ8QoH/3nIPFSn5nsmwxtggyxKt/9g
n43v8RGiajfsF41wmirG9daqOtt6d5UntBTvzG7t9BtK25CUCHXWEpgi6mT2y1JZ
YsfYMxJPvNmkLLCZ5Mo5tyQY29RgQGv6yEen+um1fubpxMArPw/oSIQOsKyoy/fa
BwcC2BVfE9iQJDIo34LMUMgvF1SIw+BeGee8Q58hriWPq1WPcPdhPJgHhmfUsmJM
R+8SbU+6aU1DPzPj+LmnrGojeZ3ePi/eke2Aw0Lv9cMk5xsgTRKde6Q1MqkgnUVN
0gHZRfT1CfyDfBNqquOyIqhh7njivjj8+6kUoifSrqRfvNJU5UmQC1q21OplF6g=
=Btql
-----END PGP SIGNATURE-----

--yvCNGRer04nRnE3d--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
