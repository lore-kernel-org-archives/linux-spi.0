From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: propper support of 5 wire SPI (SPI_READY signal)
Date: Sun, 21 Feb 2016 04:56:41 +0900
Message-ID: <20160220195641.GE18327@sirena.org.uk>
References: <56C6DB9E.5080905@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O2gaCPMlz9o7j9TI"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56C6DB9E.5080905-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--O2gaCPMlz9o7j9TI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 19, 2016 at 10:08:46AM +0100, Oleksij Rempel wrote:

> i'm working on a project which depends on 5 Wire SPI communication. It
> is probably identical to spi-davinci.c with SPI_READY signal. Only
> difference is that SPI_READY is not supported by hardware, in this case
> GPIO input is used.

> Currently this project implements SPI_READY and CS on top of spidev
> driver. What makes it really ugly, slow and complicated.

> My question is, are there any better, upstreamable way to implement it?
> For example directly insight of spi framework? Any suggestions and
> comments are welcome.

Unless the hardware support SPI_READY a GPIO is going to be as good as
it gets I think, someone else might have better ideas but nothing
springs to mind for me.  I'd be OK with a GPIO based implementation in
the core for systems that don't have hardware support for it but I don't
see anything that'd be fundamentally better in terms of system
performance right now.

--O2gaCPMlz9o7j9TI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyMT3AAoJECTWi3JdVIfQyuoH/i64uMzUc9YdJOfNb2kJmB82
QIXh8B/inz8/V9mo1ytoqKe/+k1kRbOTR0BLekSCzY7zTaDYyMpoAb0Rn8Nhbpuu
9JLB0JaYD+ESEljsg+Q9jIzrK6l/c+vm/saqlzMPV68LUCr7xLuxTR849COJy3m6
4Z0iYMWoS5cUVAu8tP6T+vhmRO3szZjSKthOoEuuC8oPQpNhmL1tCbaIX/l21xtb
wQ3l3mjUk+yqvTHuLrylTpt/crUs4zOCDfwnpnq7pKHG6HG4cygHm+7C38G9Tche
VWE9XD9fxqrBAsC2vueUNO8ZiKQn/FWzPdSpR2ULkCDtpISbe8IPRNEvgtMYxII=
=uc+X
-----END PGP SIGNATURE-----

--O2gaCPMlz9o7j9TI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
