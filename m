From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] spi: dw: Fix dynamic speed change.
Date: Fri, 7 Nov 2014 10:15:42 +0000
Message-ID: <20141107101542.GB8509@sirena.org.uk>
References: <1415303667-31584-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/mAvBbWDJ4sDNDUu"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, setka-3PjVBYxTQDg@public.gmane.org,
	tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415303667-31584-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/mAvBbWDJ4sDNDUu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 01:54:27PM -0600, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wro=
te:
> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>=20
> An IOCTL call that calls spi_setup() and then dw_spi_setup() will
> overwrite the persisted last transfer speed. On each transfer, the
> SPI speed is compared to the last transfer speed to determine if the
> clock divider registers need to be updated (did the speed change?).
> This bug was observed with the spidev driver using spi-config to
> update the max transfer speed.

Applied, thanks.

--/mAvBbWDJ4sDNDUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXJvNAAoJECTWi3JdVIfQFosH/3rTm3hoxdQnSAaqjNL5WIiP
PldIV+pSbqTBIVWIwSUYYl8tl4t78dXxQLNVKcLJiTfL5QQ+gT29fGSLssmbzs4v
KdT7+OOfsxb8gjW93Q8jkU4u0GQqZZDp3JwJiEmAlmZHKn8zG2yCc1ooQbrnR39x
N0rixqLRkI6tvKA6ho6oS3KWYF+aU7gUdWXFsZ2ae/1TuFAw+QvCzSRVXVrWLpoK
hN04fkAkmkkZUtnYejrIpRPeSUceFsr4y+5IUabHmJJefzhPJcd+/UolhStxyvY5
RWCLO1h+uNwsbzxv1nlekQM5+OOUrdIU8FHk83jbdFeZEl6Ak50arBWKXTMdE9Y=
=lFQ4
-----END PGP SIGNATURE-----

--/mAvBbWDJ4sDNDUu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
