From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/2] spi:fsl-dspi:convert to use regmap and big-endian
 supports
Date: Sun, 16 Feb 2014 09:16:11 +0800
Message-ID: <20140216011611.GU4451@sirena.org.uk>
References: <1392190146-18852-1-git-send-email-b44548@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CjJSuxoe2P5GDFE9"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392190146-18852-1-git-send-email-b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CjJSuxoe2P5GDFE9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2014 at 03:29:05PM +0800, Chao Fu wrote:
> From: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> Freescale DSPI module will have two endianess in different platform,
> but ARM is little endian. So when DSPI in big endian, core in little endi=
an,
> readl and writel can not adjust R/W register in this condition.
> This patch will remove general readl/writel, and import regmap mechanism.
> Data endian will be transfered in regmap APIs.

Applied both, thanks.

--CjJSuxoe2P5GDFE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTABFYAAoJELSic+t+oim9u5MQAJsFsLlMi1wNNerOkwdlZf1T
cNsYkl7QQP+ibBIssNRjfX8XRDen8by0sVfkpzNAloUt7KezpqJGcg5a5nbl6UA+
XXpSayx2E0lwvx/Fod8oVm7qiwxXKE6xj23Q+RX7lBCBpHfX1PMnOefexbKNEpnZ
xzbHc3UwaKgGXpYcxk1w1A0ytbyf56UccW8e1KRbab1ENjDnjulb36cih4zcwKt5
NN0wDDDHXN5c0W+Ol1t1Q2EP8no2IBEdEkyDjEgWEGxxevLckykspAt3ben4fm9b
PflkxntS601Sy4sPI62DUEkKjVZ2Cn4GPO3BPCTI8sHwftKzhPhKCZ6e+EWnUtj8
YWo+LEps9jc9kVRWikhVbrxDlx1Ttf4TTyEQFLgkpNEK9x6gSKZbfZ1aE7svAMX7
wfATIH2YTURuS39ssWui9ecQD5FoIIYcJCPuQgR23A/pL+oNoWQoq4tF2/kvrYKq
bFN56Nz6+LuMVpKIcc3Uz4TyXCydH0Wc8Pyp2OyUedeEjB1fyQvT0P6th8TX8MlQ
bx9Z7ToHGI3BUx6JcPKpBHvpeEbVSjtxsvtBxwtpVtRO7r6m5kUa3pzMHnqo2kPq
NHkZIFEIOnRF9aF0bNGTWbWkTK6TXg6T+Tf5X0g+bTvDMYa9Z9OmvoWSPHe4rrOs
ZDD5KuTLLIzx8b1kxvcO
=fh4R
-----END PGP SIGNATURE-----

--CjJSuxoe2P5GDFE9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
