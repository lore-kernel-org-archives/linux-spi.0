From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: SPI: performance regression when using the common message
 queuing infrastructure
Date: Fri, 29 Jul 2016 13:11:23 +0100
Message-ID: <20160729121123.GD10376@sirena.org.uk>
References: <577CD464.6050506@atmel.com>
 <577CD767.2080309@ti.com>
 <577E0EF3.6000308@atmel.com>
 <57959ADD.40700@denx.de>
 <41cb8a2a-7138-d2c0-e668-6c03add1882e@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Cc: hs-ynQEQJNshbs@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>,
	linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	"Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41cb8a2a-7138-d2c0-e668-6c03add1882e-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 29, 2016 at 11:33:00AM +0200, Cyrille Pitchen wrote:

> We talked about moving back to a tasklet implementation but nothing was done
> yet so nothing new for now, sorry.
> Also, I will be out of office for the next 3 weeks: I will be back on August,
> 22th.

To repeat what I said before the thing to do here is to improve the
performance of the core implementation rather than just open coding
something.

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXm0fqAAoJECTWi3JdVIfQ4FsH/1IRL5dUXw1EbyVuQMdQw0y+
AcIwLGJIPp1YLWNb7hqc2NlOxZ3CyOmwDM2z8cN0VFJ1qK2+ly8aPQH2uUGOn2Er
KmqVGGh3+Z6o7d8CRavaAeJ1t31j6ePlWT83nGygOxwVbBYgp2TJTv0dNLJYKyDt
W67KI9XZlvgg8SmMbl0BPtodp4ReOY71z/Xs/iip/ZsEIKM4at2D3HyZ7SwNykJE
pVCL3YdkiKNJPG5rTFoM9K2OpXuCKBdR8I7UQbnW+bfJKVPzXvQKHoAGUm2/Brc6
ST8WHprVvsaIPKzxq6I1HGvkOa7CCj65N2269D8rjbQ2x3J0o37rqh9h8DQWQNU=
=XhcB
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
