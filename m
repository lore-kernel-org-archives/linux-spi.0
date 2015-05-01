From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: s3c64xx: Constify platform_device_id
Date: Fri, 1 May 2015 17:38:34 +0100
Message-ID: <20150501163834.GJ22845@sirena.org.uk>
References: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430495047-31122-3-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UMzi0qLJJs/nSM1I"
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430495047-31122-3-git-send-email-k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UMzi0qLJJs/nSM1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 02, 2015 at 12:44:06AM +0900, Krzysztof Kozlowski wrote:

> The platform_device_id is not modified by the driver and core uses it as
> const.

Applied, thanks.

--UMzi0qLJJs/nSM1I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ6wJAAoJECTWi3JdVIfQOncH/inA05+JDVMKigD4OvxyMuLH
QnSd+LCpe0eMBQicrzE4aQJj47qGd503HtXnA6cm/8b6/05uzSPQgQUBLYjPge+E
bbdS6KTRjBSQAlmDZz1dAMTiwuKlCKhdzz5eaiPoanPxJOzHJHMKyiMtBqjEFV08
8Y5uemf68qrR2GVgCIrCJA0nyGSTpyMaW2iP1CZpOgC5zM4TMg10Oh9hnvWW1AKt
xQU8L6t2eYI69NWQ3s9tEjZ4pP88rioYGNRfd8BFFCXUa1pu4CR4sQ02dsapvfom
UZdTe/HgN+pTGBVm11nGNirVit2MyCFD4bOWQv+pv29Pjjz+mVMZGPlbWfYhbFo=
=+uX0
-----END PGP SIGNATURE-----

--UMzi0qLJJs/nSM1I--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
