From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] spi: efm32: properly namespace location property
Date: Mon, 24 Mar 2014 14:42:52 +0100
Message-ID: <20140324134252.GE2631@katana>
References: <1394829262-28022-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394829262-28022-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2014 at 09:34:22PM +0100, Uwe Kleine-K=F6nig wrote:
> While reviewing an i2c driver for efm32 that needs a similar property
> Wolfram Sang pointed out that "location" is a too generic name for
> something that is efm32 specific. So add an appropriate namespace and
> fall back to the generic name in case of failure.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMDZcAAoJEBQN5MwUoCm2ig4P/At8aP6cwTiqdwA4KNRYXG5d
Qoqqjbx/4ihNDUPv5zQNm9QfoUhDT/X0tILFnCMlFfi+yziC+vsw4IIYSqQALuyj
eXI8qmyuIrNjJcseQLsZyupSbzDDw+dUEA+XyTiKh/hUfEbZb4YxtqTnlfP8Hcsj
IdDw4dThTh9XaBXdFo76uCXFVGPCWRgP+jczyJTeJ8yUgorh7NAbLr0d/oQvoxKv
pXSOhaBPxWn9QOm6c4yH21N+Mb35JU7TKc7YW7zF37adc+DC7DOUj7GtCWHm+Ti7
/0BNbw/GYpROHU5UAL7TBwE7iOXhG67nvWjca66uAkc4R4G8RBe5UhH9cEqNu4jp
oO14zXx4qKTVOoeqoQYurVRANAgIfrzjWfg8+pm3GS97gTUG6YZ1a3DUYAztqIA0
/IATJQx8hjwG7N9FXHKPLqTG5tQAt5LoWdlEYIjJDDasXONs+w0JX4xucT9SQ1xS
zM9dIZi4kPCIBs919x6aXqwoYAhhPaGokrzHlrXA2MDab7GcYuecrVbteOHBa7XK
7KGd0HOt07bshJrEHbaA+Y96IkD/flvBq15KjYwOb/u7CwJOblhQAmIsaUmJwJvY
Cj+fskoFcIB1f3sIxy/rah+021AuK+T/FThyycwb2iT39NUkvwPRJHiCb1ggf+cc
GlYvrPBVG0NCIA7NaHEX
=+Wnt
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
