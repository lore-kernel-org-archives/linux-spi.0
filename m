From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: atmel-quadspi: Add verbose debug facilities to
 monitor register accesses
Date: Fri, 20 Mar 2020 12:11:17 +0000
Message-ID: <20200320121117.GA3961@sirena.org.uk>
References: <20200320065058.891221-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Cc: Nicolas.Ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org,
        Ludovic.Desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200320065058.891221-1-tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 06:51:01AM +0000, Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org wrote:
> From: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
>=20
> This feature should not be enabled in release but can be useful for
> developers who need to monitor register accesses at some specific places.

Looks a lot like the trace regmap would give you....

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl50suEACgkQJNaLcl1U
h9D1fAf/VQnn06p5m4B5/lqhwYYKIVVW6P9u/0hBvpkxfRGfRDTxHr4lEOVO+9me
fiHiUJiG7hRJZ7gkf9nT+yr/NG/Feih+70C7F2fkrNqflZqi7iFWEJHrT8gPjri0
zuSkqgYo7kLnkBlrrcgaI+00KK3J15c59SZNJa9Qes/3VWtfa0jSi3x2WgAMPuGm
z5YDPYMTAe6dqSYkYfU14FrWN+p7/039ylhVcwzWZ3aActb7Kjuw4+ND9S7u203b
+9j4IeIXpbSCEkE19P3ZczIbiCJJ0fmgZiDkNPL4WGUSDsE3jvLxcKpKSKKRuo0B
o9T+CGXY/Htz//y4U+jLBI9Cg3BMYA==
=JInW
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
