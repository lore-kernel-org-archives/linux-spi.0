From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [spi:topic/mtk 2/2] drivers/spi/spi-mt65xx.c:362:24: sparse:
 incorrect type in argument 1 (different base types)
Date: Tue, 11 Aug 2015 10:05:23 +0100
Message-ID: <20150811090523.GH10748@sirena.org.uk>
References: <201508072245.3TStW9QR%fengguang.wu@intel.com>
 <1439261095.21454.6.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lei liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439261095.21454.6.camel@mhfsdcap03>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 11, 2015 at 10:44:55AM +0800, lei liu wrote:

> I use these commands and also find another waring:

> ../drivers/spi/spi-mt65xx.c:589:25: warning: incorrect type in argument
> 1 (different address spaces)
> ../drivers/spi/spi-mt65xx.c:589:25: expected void const *ptr
> ../drivers/spi/spi-mt65xx.c:589:25: got void [noderef] <asn:2>*base

> should I also fix them?

That'd be great if you could!  It's not 100% essential though.

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVybrTAAoJECTWi3JdVIfQB84H+wSFZmnhZflc2Ujz2sJw6O+g
RneYDKEid18N3hjba4ZOE7U0HzYULiAQQmJJwvwfwimkiBzIMrAftw8aKKhu32rQ
guJnHRKiES+n46pakEyK5XK0zUJEanv30hQiaKrmOGjrM0KS62bC2CTrrdfz8KNp
US2ZSycvGJe5a9BYZR4e3SrJ65WN4r769La8huXv6cjyivz2pXFadFd39usfV95W
oQ8QODvvytAsLk7CSsEodi6iTgIASDKVXAIzks94ZNVYzY+0496jFH5J4juKLslC
/a4Byh/EfPdQyomne91WejHGNkdX+25ig2CfKoqp32BmPZT1lIInfbAfFT5oVfc=
=/9bQ
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
