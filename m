From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: mediatek: revise mtk_spi_probe() failure flow
Date: Tue, 24 Nov 2015 13:05:23 +0000
Message-ID: <20151124130523.GM1929@sirena.org.uk>
References: <1448332712-29039-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q8dntDJTu318bll0"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448332712-29039-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--q8dntDJTu318bll0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2015 at 10:38:32AM +0800, Leilk Liu wrote:
> This patch revises failure flow while pm_runtime_enable().

This still doesn't explain what the purpose of this change is.

--q8dntDJTu318bll0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVGCSAAoJECTWi3JdVIfQYnEH/28JsFFbizaNYvfTU3LBBtHT
27jBlS90oOF6ZuvEjf8lZbjcEi/AFYNlSESDT26ySPMB/u7EiqDg0vf7ctqW675L
2y4JFtlWZgLDaUCpaOgkYVmAuRFaIlSTLxIn47463S0F5utHgsncOO7V4x0rElR8
VsGiCidVmwQVPrnyJ/pNcJl90GjHtzgrSSO3jaxX36MCCX9KwPFqbkHWkJSso0tG
YnycdpBxbp+JuS4GyJUkiLmwpH55xwCxWN0N6UlSarqQuCSv/B1pgVvKd5HdvERV
XbufUn0rvnn7nJlqeDOWQHdmh32BGe2gG2ehkWD6FpfysGb9x+1RJ3QnkziPL1w=
=oDZq
-----END PGP SIGNATURE-----

--q8dntDJTu318bll0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
