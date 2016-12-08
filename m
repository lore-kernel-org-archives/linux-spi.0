From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: mvebu: fix baudrate calculation for armada
 variant
Date: Thu, 8 Dec 2016 17:56:13 +0000
Message-ID: <20161208175613.o6fu6vchcnuvfngg@sirena.org.uk>
References: <20161208163708.9775-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u74skrevfl2yt5vy"
Cc: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>,
        kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161208163708.9775-1-uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--u74skrevfl2yt5vy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 05:37:08PM +0100, Uwe Kleine-K=F6nig wrote:
> The calculation of SPR and SPPR doesn't round correctly at several
> places which might result in baud rates that are too big. For example
> with tclk_hz =3D 250000001 and target rate 25000000 it determined a
> divider of 10 which is wrong.

I'll throw the previous one away to pick the fix up here.

--u74skrevfl2yt5vy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhJnrwACgkQJNaLcl1U
h9CVSAf/TI28Hzr61c+ThkCcNWfVuqGJrilgs5Hx5lCZaiJbo+xN4KzepHO/iml8
0nyM0oY4TPjEugPzVBahNCX03NWIGRlC4SvEZ4OqhDDbIGV7UV84wJuby9KR+Drl
jQzv1NUXAKOalyG+1QSM7fuj8hIDmHuuthpM5aEFudybKm6Xs3kZGG2WjirOvk5K
BRjRuIgUsHrJzSJ0u4M2HKDPdmzge0Y106dW/9FgftKH+MC8YnBOEzblCEcOLOU1
ll22yOM4toqGKXNHiJpDEKQ53n79878RxsTdNI9shM6MCbWJAs1cTZwyPLM0siwV
JaGwiz3y3SF8qbrcdG6IvP8uy5FU5Q==
=6bPT
-----END PGP SIGNATURE-----

--u74skrevfl2yt5vy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
