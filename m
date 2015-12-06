From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi-imx: Add loopback mode support
Date: Sun, 6 Dec 2015 11:24:07 +0000
Message-ID: <20151206112407.GK5727@sirena.org.uk>
References: <1449192204-24877-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AejRorUv6TKH90t-VpsSGd6NiH9cCTJC5-QuMpiGPOPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5AejRorUv6TKH90t-VpsSGd6NiH9cCTJC5-QuMpiGPOPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 05, 2015 at 03:32:31PM -0200, Fabio Estevam wrote:

> The SPI_LOOP should not be added to all spi versions, only for the
> mx51/mx53/mx6q type.

> Just realized that Anton sent the loopback support as part of his
> series, so please discard this one.

I'd already applied this before you sent your mail, sorry.

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWZBrQAAoJECTWi3JdVIfQQu4H/jN1bToszDAUJ8N+d4UW2mZn
VuUlpi+fdaPwOmm0AgJLDhlLXlINx+A+Ka2K4+yek+Q/wyR8hKz9gGDHpqmxCZIk
gPaEurU/uQnoIJwin8xrNrHmO2P9200Zp8as5H19EMb7bVCP/ef+lkRfgTFlSTjz
mB2NlxnpNrBP8lUcIahgoujn9pbnEadBKMjHeF+Crc1Q1aO9qI5Eka0m4SgKUGUo
+/arkIUAPY96syxNbmJgv8skdUtaLngvl6o/5PFocMGNmGXtUabRJyvq1+WHIO6V
HFB/pKCdPP/5WBoFurTO3dX0iGrLcS1DgGzIdS95jwXKJOFSMuaByaULdo3CBRE=
=by5N
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
