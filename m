From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 4/4] spi: sun6i: Support Allwinner H3 SPI controller
Date: Wed, 2 Nov 2016 14:40:11 +0100
Message-ID: <20161102134011.aotjogti4vl4ebdt@lukather>
References: <20161028065412.23008-1-woogyom.kim@gmail.com>
 <20161028065412.23008-5-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7jqiaq7vz2zjy3ub"
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161028065412.23008-5-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--7jqiaq7vz2zjy3ub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2016 at 03:54:12PM +0900, Milo Kim wrote:
> H3 has two SPI controllers. The size of the buffer is 64 * 8.
> (8 bit transfer by 64 entry FIFO)
> A31 has four controllers. The size of the buffer is 128 * 8.
> (8 bit transfer by 128 entry FIFO)
>=20
> Register maps are sharable, so sun6i SPI driver is reusable with
> device configuration.
>=20
> Use the variable, 'fifo_depth' instead of fixed value to support both SPI
> controllers.
>=20
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--7jqiaq7vz2zjy3ub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYGey7AAoJEBx+YmzsjxAgQ4UP/iJWM6G5KwwVrWCH7+2ZvsyL
55JXP3XWCOZYELcLJgeksWLuMZMuy/oGtKVNyK91VC33lOYF4RXzHAc27pO8MRN6
bw6WyNVXobMGPIP1qciH4yLKwwJwGvHMG5a0I5RMBfEOCkOl1HUuNbRwnO8Zrc/5
i3PLxYR8Y0qciOWrC1f5j84nX92nUz3YiNOTJFWRFM4phtKRCjHWgwYXzHB4xWc2
cyYrRZ8UzZ9iQvaw7gm1DUheTIzVaUc7S4mtUtrVd6wb4lzAZbOG9MRvfUhQp9TJ
2Q2d/tDtyfIYn+reRoMly19q4wEqxMqgwINt0V8EIUnOL6jNKQLQVSBDym7swf8R
7vEYFtcV9H5zjOXHx6ZDgvgFAd7KD9c8WrJ5yybjxgYFEGMWoApbSFXkp/nU8Zjb
/ZTitSFuPPRTwME1xjQNqunZBHs6WvBFx6V3jdW2GBgA6MgqueudahHb/du+vavi
ZX5sp5sZApXQ6eK6KeMPk1/Ro3I18pvxDPe0m1TFXNxFfRo1pKQAfHnQH+r51cCA
pw3uroJr5057xwqj0ESF3f9tWF/l1hCtd27cjwqzzy7dMl+v/BnJ/LE6rDux5/1C
pmFYhlNJpAl/rUjfctIq4snjjhslArV//nPV0aPoncU/sArJfO2kUL//lBXBctUu
0mZ4jcEp+TGndnC6yG67
=JqxL
-----END PGP SIGNATURE-----

--7jqiaq7vz2zjy3ub--
