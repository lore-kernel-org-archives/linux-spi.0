From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: use gpio_request_one for configured gpio cs
Date: Mon, 24 Jul 2017 13:01:48 +0100
Message-ID: <20170724120148.avqvi53wkdgctsir@sirena.org.uk>
References: <20170724095327.18602-1-mnhu@prevas.dk>
 <CAHp75VdQbw9rkxq0tvYquacYViZqWKAqOTKHjLPtP=uZi8zzsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ivayjwsukej2n2sm"
Cc: Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdQbw9rkxq0tvYquacYViZqWKAqOTKHjLPtP=uZi8zzsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ivayjwsukej2n2sm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 01:49:14PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 24, 2017 at 12:53 PM, Martin Hundeb=F8ll <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org> wro=
te:
> > Some gpio controllers requires lines to be configured as outputs to make
> > subsequent calls to `gpio_set_value()` have any effect.

> > Add a call to `gpio_request_one()` for configured gpio chip-selects to
> > make it work on (at least) mvebu gpio controllers.

> More and more hacks around plain GPIO integers... :-(

> Perhaps we need to discuss how to convert SPI core to use GPIO
> descriptors everywhere.

The best way would be to test the work that Chris Packham submitted in
May to do this, it'll need a refresh now and it ought to get some
testing on ep93xx but sadly nobody working on ep93xx has responded - I
think at this point I'd probably just apply and let people test -next.

--ivayjwsukej2n2sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll14asACgkQJNaLcl1U
h9Bvgwf+OUzzH0kJlmZsEuKGg5QQKWQIqxkOcKMUcSdp1jCnJN6gTCzR3DXP3Ufm
U8fUk2rTDFKVYLBFhbYepuZTrrBuoxMDJ7ZXNptUwG0Up1qD3VRU3luFMnDuuw3H
8qYc8Q7GMABj7U+5dsf/H32dNvoEFuboPOtiBK9wv6uhq98Za6EsnBOmCsDJNSby
Lod4rVWM6M5VEoxDKjVFnlzX7M2NzZIN6J68m/BY7Bx00LWUJDzzDJ/rt2FMgxln
da9EQ3ymETOI6MBqL9fltMu4HcRW3WJoehFX3rt9eNBTU7YGGYkWonUoQhra5GlM
p6NKHu9a3a+cgVRAK96G5Zj/aArmEw==
=dXXI
-----END PGP SIGNATURE-----

--ivayjwsukej2n2sm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
