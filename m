From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sh-hspi: Fix modalias for sh-hspi
Date: Wed, 8 Jan 2014 12:14:37 +0000
Message-ID: <20140108121437.GT31886@sirena.org.uk>
References: <1389178360.27961.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N4kpgS+/dPDBsTdR"
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389178360.27961.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--N4kpgS+/dPDBsTdR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2014 at 06:52:40PM +0800, Axel Lin wrote:
> Make the modalias matches the driver name.
> Seems the MODULE_ALIAS is copied from drivers/spi/spi-sh-spi.c.
> So both spi-sh.ko and spi-sh-hspi.ko have the same alias. Fix it.

Applied, thanks.

--N4kpgS+/dPDBsTdR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzUEqAAoJELSic+t+oim9pPIP/3ZQokzANjyCBchA42tBnQ5L
328QvaMZgk7iVsUt+SIh5zNu59jnOZ1L8O86GyvDB3Lrz2ZGcsxG0r4/jYv0+tqR
KxR7XaG4I8kSN/XIeqV11Q45Ch36KFRZN6MqKuIBg9lt6LT9zXwbsTFlnPZoSvta
u2jqTJDUI2ghuxPu4eyYwkc6r4a85IM9ygROavrzhqPOJZeAx/mJtzp+YFu+J0W1
5OPwkdbTsVQduF6vNP17rfJUNIzWVIFNqOHh+WPJq8nEMbKNV3jWwpMClgReyPj4
P9VBL1HB1Hiutyijl2BcqmR29gWHXLIeTARTWgkt7Xc3FKsKDbtpyb5vkuAet0P1
GLeLeiiJgh9+qbqUHEOmiLdi1lVCDfNplizFH5Ag3pLIPIjIOszQ38CmkqtVqyFS
JnC8sYgSx9lereP7jRK4fuN7XyAyEIvm7/U2Lkbn7S0y7IxpUW/eSfAK7gDcwY5f
FF1a684YwQuxkqKtWiKenHXJE28KLn1/VYABo1oHS6qTLV17ubtJ3wxeeNYZB3P+
ZTtP7SdE4oik6y3IA4EetbsA6z7PEyR4YlOHkeaMJ5fVMqCpzozF2fpx3BEk7IBA
E+qz/4/fBLycWDF90vWSt/Zv7+qKX5So5AbdbhOJdpUR99XLYlkNR/nVe5zdMrNu
YOsfOZRAw0Hsv6SFUxwt
=Mj2G
-----END PGP SIGNATURE-----

--N4kpgS+/dPDBsTdR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
