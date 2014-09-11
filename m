From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: SPI and module auto-loading
Date: Thu, 11 Sep 2014 20:33:25 +0100
Message-ID: <20140911193325.GT4015@sirena.org.uk>
References: <54119DB6.8020807@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uLzYCuFow5JXEQYy"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54119DB6.8020807-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uLzYCuFow5JXEQYy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2014 at 03:03:50PM +0200, Javier Martinez Canillas wrote:

> This can be easily worked around (and probably why it never was an issue)=
 if
> the OF and SPI tables are kept in sync but I don't know if that is a hard
> requirement for all use-cases (e.g: a SPI driver that is DT only?).

I'm not sure I see that as an interesting use case, it seems better to
have drivers usable without DT and it's trivial to do so.

> I'm sending an RFC patch [1] to know what you think about it.
>=20
> Thanks a lot and best regards,
> Javier
>=20
> [0]: https://lkml.org/lkml/2014/9/11/127
> [1]
> From a7cd35209a597a578df6c801e5ff7b63b584bf3e Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> Date: Thu, 11 Sep 2014 14:31:04 +0200
> Subject: [PATCH RFC] spi: core: report OF style modalias when probing usi=
ng DT

We already have a perfectly good way of sending patches.

--uLzYCuFow5JXEQYy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEfkFAAoJECTWi3JdVIfQBKMH/AvgdddkgsAuZXg0uSXksiX3
UvFMGkZKC3GPQFagIuItNqMVzR7VCNfAQE84RX7ms7tuoco07mTRj+C9rcktxdxy
qtHavXlHzRtCNIUttL4RSA9R1vLxyKj5AF5D0IsWuzetcyZ2SVF/uWUO/+Gk8hGr
NSujW8pNQLSjWp5J+3/C5cjjELhp+QHuSYB7Zyozks9PDpmKZ7lFhiPSR3TDDQ25
s7TTVWZIXmpm5Tr/agx2GuKLbQyE6oc2tSgypSPcjTmnezCeZ3ksKT3qWKvdDEyF
1wgLuNW6Iskv2YCG6w1LgX1rqZOe2vCp7uheK06fXke86P2GlieE/MonOm7AIQc=
=ysPq
-----END PGP SIGNATURE-----

--uLzYCuFow5JXEQYy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
