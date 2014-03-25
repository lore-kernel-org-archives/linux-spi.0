From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] spi: efm32: use $vendor,$device scheme for compatible
 string
Date: Tue, 25 Mar 2014 17:20:21 +0100
Message-ID: <20140325162020.GB6374@katana>
References: <1395756019-23989-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1395759110-10747-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395759110-10747-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 03:51:50PM +0100, Uwe Kleine-K=F6nig wrote:
> Wolfgang Sang pointed out that "efm32,$device" is non-standard. So use the
> common scheme and prefix device with "efm32-". The old compatible string
> is left in place until arch/arm/boot/dts/efm32* is fixed.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

"Wolfram" please, next time. No need to resend, though.

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMazEAAoJEBQN5MwUoCm2LjEP/iJurDvjfKMWthuf3jtEMS5G
7il21mLTyYa7hYzdKpsrGFuHPjiAs7t3bnY2odoc6xpR5pweY4HoEIA/dor1u9Nk
5GH4uEmGICg5rl3VlUzMn44U4JVERyt/2JVmRAAcVbJzUmtUiDwF/Y9zIdUTCS25
2exJrs6K1b0zrRowF0BdE6CgcQRf72aIHn+yZ/saatKinWN5uby6EOUYJONk20Gq
mw0ar6D0U6u8etO2TTKrk5LHp1Kcz8Arusmn6cmCw2fYxtZYs4TnOjKX39vdnqwg
nh+RQfEAEzQ7QtyEhVkJcjMSHUkzGzhTPVlt0iz1ygAxj8mGZZoONhLRbvCaN02w
J/G/m5Tt9Oh9LOEP1l5kQFtI05Iw2J/e6v1Edi8sd2o5lWtEa8NrKvCrRkTktq5f
mQD4vw+L6GowT5kYi9OFHQ/2TfIXzRqbS4lUBHukhd/Z7Z8h6q09TV3VYakKnJ9Z
7+X7/A7ztnHH9p82iip8B7JFwiN1dLq+B2XDIGRJjimbsPs2yIb2803hkHjUXv9p
l5JF8+NevVvXxcUmHkh4PWSMimzjxNKWn1gpPoPElqVH5PXlQU56xdjhQjyAj7NL
8JXI1D3xdM+t9+/FZVqZufAigHCkeiJ4QTSvAC3DDklbpYv5iH6BCA/tQ7XKrtaD
DT0mUYGyLEAOU4WQfxR1
=+xDn
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
