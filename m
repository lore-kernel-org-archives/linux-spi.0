From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi-fsl-dspi: Fix CTAR Register access
Date: Wed, 9 Dec 2015 20:41:03 +0000
Message-ID: <20151209204103.GJ5727@sirena.org.uk>
References: <1449642099-13045-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xSXKkePCxtN78XFb"
Cc: stefan-XLVq0VzYD2Y@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449642099-13045-1-git-send-email-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xSXKkePCxtN78XFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 11:51:39AM +0530, Bhuvanchandra DV wrote:
> DSPI instances in Vybrid have a different amount of chip selects
> and CTARs (Clock and transfer Attributes Register). In case of
> DSPI1 we only have 2 CTAR registers and 4 CS. In present driver

This doesn't apply against, current code - please check and resend.

--xSXKkePCxtN78XFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWaJHfAAoJECTWi3JdVIfQ7IcH/jJ87LZd7wNw0T2LkTbcTxtU
w7+neTjcSGHypNV41B8k5vBoeLieerzWtCaIQLQcCQnykCpSbfnHC5J+h+zDG+6E
4NAhtWXnaMvr+zHL/MlsfRjAOvVJyfqMvYH8BvkDjF90d6LO1ndsbOHSz4g8j/re
aBoNljVH2/h+2CHCaJPpSX6axqYdEYzail0yPSJYtPRULw78sEkZSB8ON2krM5Lh
AKmECq3TVUBA/t4bYSaKnpB2pWyTy+kPQbUTv2IkUw3ioLTRxoSCgN9GzTW0t6nQ
LfNIwVw1qXdSm7Kimpc+c9TOftanHlwC2XorpMZ8JIp5rEeNAWTCagEP/kNdxSY=
=3E7a
-----END PGP SIGNATURE-----

--xSXKkePCxtN78XFb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
