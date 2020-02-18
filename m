From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/1] Enable SSP controller for CS toggle
Date: Tue, 18 Feb 2020 13:50:21 +0000
Message-ID: <20200218135021.GI4232@sirena.org.uk>
References: <20200218134906.25458-1-shobhit.srivastava@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e5GLnnZ8mDMEwH4V"
Cc: daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        robert.jarzmik-GANU6spQydw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        furquan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rajatja-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, evgreen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
        andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Shobhit Srivastava <shobhit.srivastava-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200218134906.25458-1-shobhit.srivastava-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--e5GLnnZ8mDMEwH4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 07:19:05PM +0530, Shobhit Srivastava wrote:
>=20
> SPI CS assert may not always be accompanied by data. There are cases
> where we want to assert CS, wait and then deassert CS. There is no
> clocking or reading required. On Intel CNL LPSS controller, it was

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--e5GLnnZ8mDMEwH4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5L650ACgkQJNaLcl1U
h9ADRgf+ICIk+9HogX5my0zjXhvZfYd0hbmxco9LskbJW49ggOsx15biJ4X4Zq3K
lZ89OD8Y6+pqvLZnNorTACnqoP/aq/zfBow5ULHUefblv8NWIQeRJ6D/N9f/ZAIo
JWuyV6Qbrtthji+3ZoMTf9N/dX3mleiGWLBvWnDsz+gYba7LM+CNS9/oHroIycdB
j7zrZRatG7+x7zO270HN0bga1PBxIfSyP16VELeL4MJ9eoquvqVnUkOWQ6S2NFSz
Z1j6w/pKmmt3DzoSzzCBrT7p6HddBGFTRvprSJtQvaFaT5FMvPflNGagP8zC8VRN
TvcVZjSOu5bf7lYCTQViJwWKIocyWw==
=00VJ
-----END PGP SIGNATURE-----

--e5GLnnZ8mDMEwH4V--
