From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: topcliff-pch: don't hardcode PCI slot to get DMA
 device
Date: Thu, 31 Jul 2014 00:04:00 +0100
Message-ID: <20140730230400.GC17528@sirena.org.uk>
References: <1406735430-18943-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VVAsavKnFMTAHITI"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406735430-18943-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VVAsavKnFMTAHITI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 30, 2014 at 06:50:30PM +0300, Andy Shevchenko wrote:
> The DMA is a function 0 of the multifunction device where SPI host is attached.
> Thus, we may avoid to hardcode PCI slot number.

Applied, thanks.

--VVAsavKnFMTAHITI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2XndAAoJELSic+t+oim9u1gP/3jLTMpesCZRDSbM+KM9sx6L
hyoJ3mT75+LhSNXia49wFjjgxKb8x6aticCoOQ4F5yafT971SoLj3isH53S9YPI8
vsIITWJdakDLERgEmjlRmSvXLeS59VGWeFMjEiUgcNcDOPTg7EP/u1TuS+EBG91Z
4Ll5wEhBj4Xawk/p3OZp6bfUlQlllW3GxPw6WaehwkqxCNkqlz10XmQE6BRYaH3b
SaDcPfT2k9IbxAxCCz+5omT64W7NdnPVrXFHvMG9Voos3qCY/VJbgCvLKaDJZnQ5
WkLNyWO4klPn7Gjp2vBHcg3wJGfLUhpeiwHgDZr1lTZJto9rQ0Pye12Onjs+tPXN
Vj8PJe5cTuKIBcfI2P/8JkU/5pyUIqKWxi8wST31eB/ppYQUP978hSUKe82JssMz
UBt/YEGQHZSZn6BQO6Q6TytkDAL7Jsdzcp5VRzFq1CL0mzMq95Edho/Bq1rVntmN
W+9EtKz0YyhPz5QjYEzOLgvJrfsozBZ9FzrLYgVHGeM50srf9AdHnvD2n0GWex1r
cWcJlgwy+neEDC2kK24pk6wYmsrOy6U/9YO+zjXZjYKuCiklpgBN7pN0GW8gCi8W
bK9Q6DhutKTeUjmxUJj2ybE2pOrzDslYdFjQffnTkenK6FC9U0ZY+mHYNs/2ghz5
JKeBdLsAUMjOqmj6yNmf
=HfWY
-----END PGP SIGNATURE-----

--VVAsavKnFMTAHITI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
