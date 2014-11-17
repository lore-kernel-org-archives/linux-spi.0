From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Fix mapping from vmalloc-ed buffer to scatter
 list
Date: Mon, 17 Nov 2014 10:40:30 +0000
Message-ID: <20141117104030.GT2722@sirena.org.uk>
References: <1416215672-31554-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K0M4iRgkWWXhiQ9N"
Cc: marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416215672-31554-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--K0M4iRgkWWXhiQ9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 09:14:31AM +0000, Charles Keepax wrote:
> We can only use page_address on memory that has been mapped using kmap,
> when the buffer passed to the SPI has been allocated by vmalloc the page
> has not necessarily been mapped through kmap. This means sometimes
> page_address will return NULL causing the pointer we pass to sg_set_buf
> to be invalid.

Applied, thanks.

--K0M4iRgkWWXhiQ9N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUadCeAAoJECTWi3JdVIfQObwH/3PCd/vyCyt+TVyNS1E1sviw
+nH7CGNVOHe/JH2riywIEN6BFZyzbkK3ZkTfVk8DvCxAh7KdIwP4YwAshQKC1dyR
n4zPB+0dnCCcjC7Fmx8mmoAWOGE26O2UM2phMzjT6eGODC7DJmSToI8ilk6L28eU
LqHefCmwMn5s+kLDbA0KGTwtoaRhgn7en2VZNx/IA+N/6VTVLvPTwA6JLf8h0onh
ZLMWXWqQ5i64T4/xkUBpafkKCW0R13eAaRJE8wlbqRAFiiKuNElNnk6Ybwtk5noN
mbCxwJzea/rqcr6Uwm5tx1GpbETReH2TYXxQCIR4UxoTfBh8/RKSUkGRniBNRSo=
=BNKp
-----END PGP SIGNATURE-----

--K0M4iRgkWWXhiQ9N--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
