From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spidev: Adjust five checks for null pointers
Date: Thu, 18 May 2017 12:28:46 +0100
Message-ID: <20170518112846.tcirhguyps3kk3ra@sirena.org.uk>
References: <c5452d8c-d123-d5e9-b2cc-a386d1325aec@users.sourceforge.net>
 <df3e58c6-f70d-a5d3-102e-4fab2f7df126@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7nt3fc253c7bqiji"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <df3e58c6-f70d-a5d3-102e-4fab2f7df126-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7nt3fc253c7bqiji
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 05:47:29PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Date: Wed, 17 May 2017 17:30:28 +0200
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit

Please fix however you're sending things out to avoid this noise.

> The script =E2=80=9Ccheckpatch.pl=E2=80=9D pointed information out like t=
he following.
>=20
> Comparison to NULL could be written !=E2=80=A6
>=20
> Thus fix the affected source code places.

This changelog does not describe any purpose in making this change, we
could equally well say the exact opposite.  Why should we do this?

--7nt3fc253c7bqiji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkdhWkACgkQJNaLcl1U
h9A6fgf9HXPPR89iuEWigyaQPZ6M+FvaSSXYVHuV1Qz2eSSP2R7wiNONmL6ZFyV9
K+WrW24VvBomWdwFQNxCYdDhmQN23nJgX+SPV100cSwVrwkqwWJ+jNYatDKEJhlr
PMhm+Fe5uwPMydGM97EO+R1OZ+4entJ3UYYYYVxnGuXBJFoGlWMvjB6wGctzT6V4
kxaTppgYuGTIi24k5H5rvi6RLEE5bswR1t1Kb9j5UnscUNBm1x3Cje0KIN3YXA7m
OLUH1lwOW/oTNowwrunPIkeUhoUc/6xpvMOxV276wY2AsDrIQ+RB75eITMmHz/q6
nVfFZxPK4PTaQZaEIKqMG9eMSbkFtg==
=Qx/I
-----END PGP SIGNATURE-----

--7nt3fc253c7bqiji--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
