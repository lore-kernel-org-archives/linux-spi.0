From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: imx: fix ecspi mode setup
Date: Tue, 14 Jul 2015 14:49:34 +0100
Message-ID: <20150714134934.GV11162@sirena.org.uk>
References: <1436880205-25023-1-git-send-email-qxovxp@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7eB2J0nPHAYIuy9R"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "Andrew Y. Kuksov" <qxovxp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436880205-25023-1-git-send-email-qxovxp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7eB2J0nPHAYIuy9R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 04:23:25PM +0300, Andrew Y. Kuksov wrote:
> Fixed problem with setting spi mode 0 or 1 after setting mode 2 or 3

What is the problem and how does this change fix it (this information
should be in the changelog)?

--7eB2J0nPHAYIuy9R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpRNuAAoJECTWi3JdVIfQoIsH/iduSCy49KRRuohwNhKCdtuO
jCZ/v4buAZCYgG7HcOgyH4qBAfsioTrC0kJwRr5r3w2CaMN641XQmOiGtjmPrHyT
1e+lyfC5JYjPCSrMIdTKQRh1SJg3+qpLy8VibKs2oJFEHwZDFwizp83t6iv3p55n
qVKMZ7DxkPlZpbq2qyD9quevm7yHHWA3t81KwtnKdik/5gKlKceA7dMYvlhsWgbk
U0UNCZ5gqAubDJt8F2IXi5HaSOTPRVS5Ubt8WYLG2VWDv0V+KqCSKrZtwKKhNW0c
mTibd+Cpmio3/I7RY0kKREEL1Lb4Mciu1C/aH+1/WNIg6MMyE0KbFSgZnD9LVWs=
=7tGS
-----END PGP SIGNATURE-----

--7eB2J0nPHAYIuy9R--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
