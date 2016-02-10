From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Bug in in spi-bcm53xx (rcu_sched) exposed by 0461a41 ("spi: Pump
 transfers inside calling context for spi_sync()")
Date: Wed, 10 Feb 2016 12:48:28 +0000
Message-ID: <20160210124828.GX13270@sirena.org.uk>
References: <CACna6rxQPv_Ut9NwN+BMbwSW+5-tJMoKXC3QWDfSP7zsCqfj7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wwU9tsYnHnYeRAKj"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACna6rxQPv_Ut9NwN+BMbwSW+5-tJMoKXC3QWDfSP7zsCqfj7Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wwU9tsYnHnYeRAKj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2016 at 01:21:04PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:

> Unfortunately the bug in spi-bcm53xx isn't obvious for me. I kept
> looking at its code for a bit but couldn't find anything.

> Knowing the commit that exposed this bug, does it give you any hint
> what may be wrong with spi-bcm53xx?

It's most likely just hammering the CPU for a very long time without
scheduling due to doing a long PIO transfers.  That change just removes
some needless context switching.

--wwU9tsYnHnYeRAKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuzGbAAoJECTWi3JdVIfQmHEH/RhMZ9FZvJ3PgVkL7pffuv4D
CQbnL64E4B+FfBWUzTwH6rfwNH6qKAhqMg2Dx1ScYyjMeWY7EU3Q5d+dlhihFAsG
RrqyZT99dE/aYAANprzj1aRb3i1N0uK0K+UacdNf80NHSXrX1j/Sz3uBfp1a6O6N
1JXeT+ED7aFlihrgQLj9Nu4KS9Se9tWhR+eLAkWdLL815wPtblV65z41CTjJ6ixN
iN+eBjX4OzzJIQOizLDBvIhGcmK5lQyUrOmfBWlQfx1PaOoyTq//T4LTOReW54Jx
EDPhLfN0xmVtzASwJOkOIbxhg8YtlqgcYIMog0kAFKi3bWeCMrLrF1Oz6ZlmT7o=
=B2lg
-----END PGP SIGNATURE-----

--wwU9tsYnHnYeRAKj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
