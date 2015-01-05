From: Mark Brown <broonie@kernel.org>
Subject: Re: Backport of spi-fsl-spi bugfix to 3.14.y
Date: Mon, 5 Jan 2015 15:48:34 +0000
Message-ID: <20150105154834.GV11764@sirena.org.uk>
References: <1420472564.803.9.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cUzoOeFTT7puyy6E"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Stefan Roese <sr@denx.de>
To: Esben Haabendal <esbenhaabendal@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420472564.803.9.camel@gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--cUzoOeFTT7puyy6E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2015 at 04:42:44PM +0100, Esben Haabendal wrote:

> Please consider commit 4302a59629f7a0bd70fd1605d2b558597517372a
> (spi: fsl: Fix problem with multi message transfers) for inclusion in
> stable kernel 3.14.

> It fixes a regression when using mmc_spi driver on top of spi-fsl-spi
> driver (tested with powerpc mpc8313 based board).

Has this ever worked?

--cUzoOeFTT7puyy6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqrJRAAoJECTWi3JdVIfQWi8H/1kxAGrrDcnP2l4IFYBHJZ8e
oL2J/Isl2HVPmzfbo5e8TSyV3KPIFnBTPM5GSu0cDmsuI0g8yxKtLrdqgxzvQbGm
S4WdQ2SkCtGZmGbOfQNlMG6AtSIwIiQKbjnVgy82Z9IC++KX2ZBIJSM5O/YmcO/G
v5nAmuhuab/AiSZjHKzgsVHhoBnhsbRBkaxplX7morQhG3K/zAI08lYnRqr3haML
T+QmhGGAc368YiLNXu3+USDsuhWeKOoV17G+jAcvqnf6Dsq4MqpHhj4QLGgT7rd9
z5KegOTWt508Ckv8ADEBoQ7omC1OylmkaQTVQBcmsKnArYfBBAvyvN7gS/F1ifI=
=3OrN
-----END PGP SIGNATURE-----

--cUzoOeFTT7puyy6E--
