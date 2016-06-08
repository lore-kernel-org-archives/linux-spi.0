From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: rockchip: Signal unfinished DMA transfers
Date: Wed, 8 Jun 2016 11:55:38 +0100
Message-ID: <20160608105538.GF7510@sirena.org.uk>
References: <1465371171-20810-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wtUqn8XWZYmnPFNh"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1465371171-20810-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wtUqn8XWZYmnPFNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 08, 2016 at 09:32:51AM +0200, Tomeu Vizoso wrote:

> +		/* successful DMA prepare means the transfer is in progress */
> +		ret = ret ? ret : 1;

Please write normal if statements so people can read the code more
easily.

--wtUqn8XWZYmnPFNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXV/mUAAoJECTWi3JdVIfQk6MIAIRxpZvRpSGabzTcwIIvNign
i2wpwjSiR3wgDGwWx3OIp4rEXj29mwqz2pOXh73E73lCQisyxwclqHLeLy1meEPm
MxJNJDSIf2t7/Qkbfi58KyMac+m1O6DRQK9Aeu5ZqTAWMUCm4+XsprmrGF5NTdSk
GJV9tkuT0z4BvFGe1mJZMi0sxdKNS9QkcY6XPKPB2o5venOjtjUs0rXfbjyXiii0
/cqjqVk+l2ctOk56EycHxYiZBgT+PgIBJ3PFwQ6DCAOf3v9Y6k339kZM9mnVJH9b
j4/u48kS5nNWR95iNtiqoEalZ3xjsDG6SZnx4g8jNR3nXRPn6rekgsTvbRRGiT8=
=ksGT
-----END PGP SIGNATURE-----

--wtUqn8XWZYmnPFNh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
