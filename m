From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: nuc900: Fix setting multiple bits settings in
 register
Date: Wed, 26 Mar 2014 16:48:19 +0000
Message-ID: <20140326164819.GC14287@sirena.org.uk>
References: <1395412823.9974.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395412823.9974.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2014 at 10:40:23PM +0800, Axel Lin wrote:
> The correct way to set multiple bits settings is always clear these
> bit fields before set new settings.
>=20
> Current code does not cause problem because the reset value of these
> bit fields are 0, and these settings only set once during probe.

This doesn't seem to apply against current code, can you please check
and resend?

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMwTQAAoJELSic+t+oim9AfwP+wRNU1HQboIeWDBKODt8kr4b
POiAsUJ2ZgeyG0lPj2LOVZ1I1Z6VPz3j9X/CeVjU+oNPMpZBAJacNqto+bRGmRUD
4/2mdTIwdX9TYV082ltFymndpxaZLiEwKXzdDNqJ7/6KBQNJODD6d6Qr9uqdU1Um
B3G093+0bfVDe4CgHlHhhc5C8JO3v7DWd7pjFcYWDt04pLH889J6a7qURk8uXLd9
aRmnPtGG4gg8ULe5ATvOB+evwomIwan1ZKDwMqSrzIA4qXP3UZkYjT6wjBzd9KtJ
z9tD88bFiV9QccdkHBC+aRqlYDSoh+8PIjWvSUHu6mhWaLdv8nG1jekWsK4bNMUT
rPZ5qQ/oOMowG+nyn1OUWe6yXXFn8w7j980bk4wXJxd3lPj5cmh7NAMqtav36XrI
6jQJTMupgM6o8XUFd98/SHwR+a50mCuX+iQ2c5OWzlM4RMNhRqRPUUhBwadlYEhl
+nyvk1W2Lfsl34i2U5fOvmUQkUoYjFNlKgI7+ZHD4W0Y41hCAp3Nkc2tH+qYUJdx
NPsnASZuTwrVyLocgb0M2YTVpzosItavMYf5kBUSXvl9STPrii2YljYzyXF3pXBv
GZwdrDWw5gu9wlq3B49YAZ+0eLoop2712+qlR6HKcp4OpLn/aZpnjnlL14QCqOb1
eD9QLMyYQ7rufRm2DhGy
=kU/o
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
