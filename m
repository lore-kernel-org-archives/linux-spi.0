From: Mark Brown <broonie-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] mtd: m25p80: get rid of spi_get_device_id
Date: Wed, 1 Oct 2014 19:20:03 +0100
Message-ID: <20141001182003.GB17974@sirena.org.uk>
References: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Artem Bityutskiy <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411984074-3850-1-git-send-email-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 11:47:53AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> This simplifies the way we use spi_nor framework and will allow us to
> drop spi_nor_match_id.

Please don't CC linux-spi on spi-nor patches that don't have SPI level
changes, it just clogs up patchwork.

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULEXSAAoJECTWi3JdVIfQ2roH/0OaqzUv/QRZUlaWQtUih6CX
vHdg2Uy2SHZR9xCIOUXypgHKhGbHIH+BLD4bdwXd5Vwtus4V2Ah+46OjXGNzCi12
s6y+ycNDDWrAeAB5EqoxIFLtffV4WxyQiR0kCGismyoWOlRPLx8yTo6mVU+viTw9
qIJxmAkqwUOqkHAj8Wr0Vhbjpj/uQ6Vf405nnW/Zbo+jdVHTWf88tOoR6DAkNVvu
DcsXICE2T9JzNxRJn4Vz7dDYpy1UT4l1pAo53/+g6tMIa4FxviFBvZN0PifwfrzZ
eJx7NubePA5rCckz33Xj8pN/DBo3SsDjtEzz3X4PYWhhCQkMlT2e3XZh6kw7oDw=
=ef0F
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
