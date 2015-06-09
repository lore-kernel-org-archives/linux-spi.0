From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/3] spi: atmel: add support to FIFOs
Date: Tue, 9 Jun 2015 18:30:04 +0100
Message-ID: <20150609173004.GO14071@sirena.org.uk>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <bb9ae6c3a3567d4fae7689a31f771da6036661bd.1433850255.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+aOZGdcGYL8FotQd"
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <bb9ae6c3a3567d4fae7689a31f771da6036661bd.1433850255.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+aOZGdcGYL8FotQd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2015 at 01:53:54PM +0200, Cyrille Pitchen wrote:

> To enable the FIFO feature a "atmel,fifo-size" attribute with a strictly
> positive value must be added into the node of the device-tree describing
> the spi controller.

I'd expect the driver to use FIFOs any time they make sense, I wouldn't
expect this to be something that requires configuration - I'd expect
that there's going to be at least some FIFO in all versions of the IP,
even if the size varies.  Is that not the case?

> When FIFOs are enabled, the RX one is forced to operate in SINGLE data
> mode because this driver configures the spi controller as a master. In
> master mode only, the Received Data Register has an additionnal Peripheral
> Chip Select field, which prevents us from reading more than a single data
> at each register access.
>=20
> Besides, the TX FIFO operates in MULTIPLE data mode. However, even when a

This is very hard to understand as I have no idea what single and
multiple data modes are, sorry.  Please write your commit messages so
they can be read by people who aren't familiar with the internals of the
IP.

--+aOZGdcGYL8FotQd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdyKcAAoJECTWi3JdVIfQK0UH/26wVok4vSoxLx+X576KU4cH
tdNWK/GNQVxiHH9k46jXMJ2oN+rh8hpJGpIZKw9Lcjqor2jP1pSOfcFcQJIhCkBu
uiGEUBb/AwcQNCuwyhg47flYqRZUiq4w+dkbx2GLOvOkXIIw7DmSRq522hHk7Qqo
Lb8BoJha1T8Tjk28vd0KuzeosjRDYvVEiTafkzSbvJWUekJlHo4hZN8JpwILyIlG
RjX9sSJYHX0I3Gdyjn7pheTGaZ0NQBLI3+93+lgzzx+2mCciYyVn4C4D5XH80O5G
fP3h93prWSjYZRnD9ErrMHjbxifT9QJPawHByEe+cjspyAf3Qla7r5ApcrXmgaY=
=jnsy
-----END PGP SIGNATURE-----

--+aOZGdcGYL8FotQd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
