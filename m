From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: set up spi-mode before asserting cs-gpio
Date: Tue, 4 Aug 2015 12:08:59 +0100
Message-ID: <20150804110859.GK20873@sirena.org.uk>
References: <1438092193-31799-1-git-send-email-kernel@martin.sperl.org>
 <55C0902B.2040006@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k2+Bt23KD9VIuFWa"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	TeNoralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C0902B.2040006-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--k2+Bt23KD9VIuFWa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2015 at 12:12:59PM +0200, Martin Sperl wrote:
> Any feedback on this patch? Can this get merged?
>=20
> Noralf (via private communication) has confirmed that with
> this patch his fbtft device (which uses spi-cpol and spi-cpha)
> works.

> On 28.07.2015 16:03, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

Please don't top post or send content free pings, and please allow a
reasonable time for review - you only posted this last week.

--k2+Bt23KD9VIuFWa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwJ1LAAoJECTWi3JdVIfQa5gH/RGLPLsHIeNEM9XYtB/H+4P3
ltFMTl04gOgjUmII2wqWGUuywN2sc+7Sp2EeDV81nVHEwgUhqet607uYtrCGhQEM
l5zyGTzs4PMgW5vMX465skfcuGAb3s5eKr8He6n3lXqmg6pvM12BrjYidSqLqLzl
ej2fGCgGt90MgG73fspxC43UUtV0FpiAlpR0/ZXkFUujLc7vMlQcr6VVtKqT1icV
n4TAtX5QYiyxhdzPngbs7+29TnY8YWxprdqczFGjWKAiO1j1ErIYsX+pNMGiereT
Q+M9zfKEwfSgQof/qv5ey2gFt8WBCStHxoan4gQPoiVRjYjPG0moNHQe3oNF49c=
=Ni68
-----END PGP SIGNATURE-----

--k2+Bt23KD9VIuFWa--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
