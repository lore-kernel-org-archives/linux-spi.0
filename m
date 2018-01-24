From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Wed, 24 Jan 2018 15:09:28 +0000
Message-ID: <20180124150928.GE9366@sirena.org.uk>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAHp75VdB2e8Qwr7+LT3jT6HB2rSiSJ3TrMdBqVZYqO=KE6QBmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Cc: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdB2e8Qwr7+LT3jT6HB2rSiSJ3TrMdBqVZYqO=KE6QBmg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2018 at 04:19:41PM +0200, Andy Shevchenko wrote:

> It would make life easier in the future to switch SPI core to GPIO
> descriptors completely.

Linus has patches for that which I'm expecting very soon after the merge
window.

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpooacACgkQJNaLcl1U
h9DD0Qf+IsRrQVm9O3IgAmH3KNILMLcbuU1zjhBBfDeIr+WGZjce5ciAFnVGjlJD
UkQNOgFAQDUNQa8DFOdx4zbtmqb2zLedm6/Las5A4v38BsDMA/W3auAQEsPdrI4W
ptg9EZsl2a8CNMpasGiKmVSGaNc9+Z/Dq4qZoJmLTnqX9ZyFQCFZRgPb6eZbeFAW
26lXR7DfnLCsOgsWvtLP66diueymH8WSA49ckjh6sfKZNWrgpljcjdzuj8L8xkE1
ZJRmpE6k7p6b5KNbreGuXn0wBYAUsL+iZSqSfsRSET/CSeqCPOgdVP9o071p9eyC
HsVcRoEx7Pg1DXZUkTG/AQhwkrUBsg==
=niNL
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
