From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: propper support of 5 wire SPI (SPI_READY signal)
Date: Mon, 22 Feb 2016 20:09:48 +0900
Message-ID: <20160222110948.GE18327@sirena.org.uk>
References: <56C6DB9E.5080905@rempel-privat.de>
 <20160220195641.GE18327@sirena.org.uk>
 <56C8DD64.1070700@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8iY9iRW2aj84vsbN"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56C8DD64.1070700-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8iY9iRW2aj84vsbN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 20, 2016 at 10:40:52PM +0100, Oleksij Rempel wrote:

> I would need some naming suggestions (we call our protokol SSI). It
> looks like the protocol used by us has some differences with Davinci.
> The Dav. using SPI_READY line only
> to allow or pause transmission (fix me if i'm wrong)
> We call it Request line and use it to: Ready to Receive; Receive
> Finished; and Request data shift by slave.

Oh, so this isn't SPI_READY?

> In this case probably spi framework need to be extended with kind of
> request call back. If data is currently not transmitted and Req line is
> not used for flow control, then call driver specific function to
> initiate data shift.

This is sounding awfully like SPI slave support?

--8iY9iRW2aj84vsbN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyux7AAoJECTWi3JdVIfQ604H/iixkbWYt6akzlmTLRbj9llK
8Xlaa5Yp2eC8KQ0cASlrAJKUW6MrQQMYEPxQlJpTCEtESnqPSEvLbUNZ/F3iYlJ1
OHlwIgFxs+VvYc9GlLl3qHUgJJbByCQPwP6pgWRcXVXHtV7nbCQLzza34olWjFP+
OOyxIQdhnsQwp3aNZHgkPWk68HYuAth43CtNPM7KALaQ3G+XgymnVTYCjWTajBZz
U48CqAR1T+7Mkup19HypNLuVAdIy1sCFLeLiYMsFVLw8iaGqpPd/hs+qR+abS9+i
/+YgSDOZeL1RS99I15JC6xPQA3P+ryDkJecWCUYWcaumA5kFvkJuWReYczeeHz4=
=7S04
-----END PGP SIGNATURE-----

--8iY9iRW2aj84vsbN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
