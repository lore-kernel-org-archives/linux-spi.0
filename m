From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Configure FSL eSPI CSBEF and CSAFT
Date: Wed, 16 Apr 2014 22:05:28 +0100
Message-ID: <20140416210528.GB12304@sirena.org.uk>
References: <1397678979-7655-1-git-send-email-Jane.Wan@gainspeed.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="upHqgONuYbTeMWr5"
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org, b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sr-ynQEQJNshbs@public.gmane.org, insop.song-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jane Wan <Jane.Wan-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397678979-7655-1-git-send-email-Jane.Wan-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--upHqgONuYbTeMWr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 16, 2014 at 01:09:39PM -0700, Jane Wan wrote:
> Make FSL eSPI CSnBEF and CSnAFT fields in ESPI_SPMODEn registers
> (n=0,1,2,3) configurable through device tree.

Applied, thanks.

--upHqgONuYbTeMWr5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTvCVAAoJELSic+t+oim956sP/0RFWCq+s8VfcmaasODaTNU+
sjoBmhK7/xcbn7jFfgDtLD9tMpS+3UNNkumDagepvU1VSfjbSUvYS9/5MkCxPYIG
S+6hG8PI04wLV5Fgs59ZmX1pIKcQXq2zfLrylv8hynVjSC6+MTZTpLhOkE2uUoz4
A/EyS6z4KN+jcGeqNkl2mAXBBxg8pk5GubwtJc7Dnx2c7QnsiH4jNbKejs+OWqr8
QalKP6DN7kuvrrS8ZalUNJRJ7k8yTywS/FrHqVGwhjbUrOSGC60KyPWZPG2Yq9Cf
f/n+mO2fmWlRDXsINOGW2nHrha8TBRpkg0llyMvu4ItLHkUCEUQVVloDIAUz/5s9
+h75wHqhL+ztjp+OAZZMiS4HQChk4P7ImWejW1RvqE+mYUqcd6xxJaR3VPVo1AKM
vuR7kVE+HAsAHybdBv9A0kENxB6Yo76jjVOKIwFIv+50Y+OO+eYlSSPJHYKc4Afe
dTBZLXQFo6e+QDWx2jDOJX6YxLhOY1iFKou1LfDW2vTxfp0bmHNbqHx+6z99tLW6
cs6JtRLQfXqbaK2xK3okJDieoK2a7fFY5k0S5TKkV8SWOlU9L3BjAlpEsRpjccz6
yiM5O/RAXzaRbbeAQgcVQSioxdjI3itK9zOYRywtJHA6/EGX1myoQFFBJ2BnlDx4
Z6GUkQ7Qx74ZWGL2X0ki
=QfXr
-----END PGP SIGNATURE-----

--upHqgONuYbTeMWr5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
