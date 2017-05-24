From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: use gpio_desc instead of numeric gpio
Date: Wed, 24 May 2017 18:00:22 +0100
Message-ID: <20170524170022.7rlib5c6ijw4aakg@sirena.org.uk>
References: <20170523040322.10433-1-chris.packham@alliedtelesis.co.nz>
 <20170523040322.10433-2-chris.packham@alliedtelesis.co.nz>
 <CAHp75VcHktwnXg26sq6x=EqM6TFAEc6yQrRFZQu1CCpYYfq6wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6b465kbdxucgcqvf"
Cc: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcHktwnXg26sq6x=EqM6TFAEc6yQrRFZQu1CCpYYfq6wQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6b465kbdxucgcqvf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 09:28:22PM +0300, Andy Shevchenko wrote:
> On Tue, May 23, 2017 at 7:03 AM, Chris Packham

> > By using a gpio_desc and gpiod_set_value() instead of a numeric gpio and
> > gpio_set_value() the gpio flags are taken into account. This is useful
> > when using a gpio chip-select to supplement a controllers native
> > chip-select.

> I think would be better to move everything in SPI core to GPIO descriptor=
s.

Yes, this sort of bodge is just far too ugly and I'd not trust it to
continue to work. =20

--6b465kbdxucgcqvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlklvCUACgkQJNaLcl1U
h9BmkQf/fvzShh80+bYiPLES8wolUI3HTaAQtuVftYbXX/RjhqKxBhhZ2TDGuqgx
Gg1dZ0d6TnXeYO7T2SlPgJ2ZMvuXxtjSaVaYMcvbpG5Z0R+rF9bcyLwempUoTa0K
lXy3edkH9+sjLJgPqpxBHTVZaK0SQ63f5FWN/bFu4dkGPB/sQ90TUGOj3TmF4TEC
0/euwEfWn4geDfFkiQDEeYTsVt0jjIyR+1O0+YHkAYzlliknpHTYd/zv0jSARrkL
VDxSz7UopzBqb++OttpAoCPli9izqNy07D2kB+C7UyWEu+6boT/FPqUNDKkZMmCe
35BNVQd6NFBIWUY2Ki89SMFSebrgaQ==
=2aFR
-----END PGP SIGNATURE-----

--6b465kbdxucgcqvf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
