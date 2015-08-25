From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/4] spi: mediatek: replace int with u32, delete TAB
 and define MTK_SPI_PAUSE_INT_STATUS marco
Date: Tue, 25 Aug 2015 18:47:21 +0100
Message-ID: <20150825174721.GH12878@sirena.org.uk>
References: <1440387918-22191-1-git-send-email-leilk.liu@mediatek.com>
 <1440387918-22191-3-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jaoouwwPWoQSJZYp"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440387918-22191-3-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--jaoouwwPWoQSJZYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2015 at 11:45:16AM +0800, Leilk Liu wrote:

> this patch replaces int with u32, deletes TAB, and defines
> MTK_SPI_PAUSE_INT_STATUS marco.

You've listed three changes in one patch and they're not obviously
interrelated.  As has been said before one change per patch please :(

--jaoouwwPWoQSJZYp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3KooAAoJECTWi3JdVIfQL1gH/1IAlVcjXNIUSJBhRaJaHA2W
MPy4v5ahSC45/5zayi9jMUlU6fG/owD105MDTsHaROhL1roFLo3AEbs9RVfj6P0z
bTAk7/SM8wS7C5iwCUbmEljmRZSFMBr1N+Y1/aNHB51o6CpOijkEN44hjVzN7TCO
tFxIoo1UCynOkWjTtCyLm3RnNOvhBxZLKM0Wt1Pm0wC0CDsY6Q/Fv9jzVC91iHBG
g1T5eSA+XXs75iZA68GNoBrUb75J3IU8wVZCakVuD3t+qskzsMr8PjnLBu/VahCS
2hztij7BnEKFM7FFkeqhEi2P8UK7e4+Auuk1pO2bndJHiTb3uVqHR4lmjLFAgwA=
=9cGh
-----END PGP SIGNATURE-----

--jaoouwwPWoQSJZYp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
