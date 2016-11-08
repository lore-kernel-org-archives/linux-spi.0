From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: avoid uninitialized variable access
Date: Tue, 8 Nov 2016 17:40:05 +0000
Message-ID: <20161108174005.mjxbvgbjjxmakhur@sirena.org.uk>
References: <20161108134624.1905209-1-arnd@arndb.de>
 <SG2PR06MB11655C10710B5FDDEAEA48218AA60@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oi6tp3tg6dayiksn"
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Chris Brandt <Chris.Brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB11655C10710B5FDDEAEA48218AA60-ESzmfEwOt/xoAsOJh7vwSm0DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oi6tp3tg6dayiksn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 08, 2016 at 05:20:50PM +0000, Chris Brandt wrote:
> Since I was CC-ed, I'll add in my opinion:

> While Geert already pointed out the spelling mistake (_in_or_our >> _in_or_out), since that function is only just for qspi versions, a better function name should have been "qspi_pio_transfer_in_or_out"

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--oi6tp3tg6dayiksn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYIg3xAAoJECTWi3JdVIfQP9wH/0i8KJBueVo1SsEsT/UcHr0U
6YoNccSIMXwY8CQkbOwckgGhl2fAWyszulcz2aXqZ29xdJRi7lXVLr/Y5NhUrGb5
8+/igFrIsua698nR2j1X6Ecy4H4nCprsNECrV0aMjLlo0L3hvjps4rhY4b/EYCAA
KbucHrDH2/05D+W3yAurYLeQI94fcz7C0BmiCqJokpQQW+4WSFyUYYoz7mI+Om4I
EDeGEee2TEDCB+jK+jaYKkIzv50dluL8t87IwOmxxvmcgY1x/Hero9+hy5iiFlCZ
BiIMq5QwzV1q+y6FBNT6Ml6Mg6J1OcdgZCc8fOofTBGxAJyiYadVZ2ppAwT93HI=
=7nyL
-----END PGP SIGNATURE-----

--oi6tp3tg6dayiksn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
