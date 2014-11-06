From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
Date: Thu, 6 Nov 2014 10:26:36 +0000
Message-ID: <20141106102636.GT8509@sirena.org.uk>
References: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4AfY4lbNVy6SI0IG"
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
To: Padmavathi Venna <padma.kvr@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4AfY4lbNVy6SI0IG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 03:21:49PM +0530, Padmavathi Venna wrote:
> Exynos7 SPI controller supports only the auto Selection of
> CS toggle mode and Exynos7 SoC includes six SPI controllers.
> Add support for these changes in Exynos7 SPI controller driver.

Could you give a bit more detail on what the "auto selection of CS
toggle mode" is - in the diff it looks like it's not an existing mode.
I'm a bit worried that it's not going to function well with devices that
send more than one transfer per message.

> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

It's better if your signoff is using the same e-maill address as=20

--4AfY4lbNVy6SI0IG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW0zXAAoJECTWi3JdVIfQr/AH/R+QLj3eZH9EE6l3EetEEPO+
x9GGn7iRKAidcq6tXoy6EKtCC5BGPm0kc2desYgGpVrcBi6ro8OMOjfxy3irtJlq
yiosuUP9M0pP2DfMeNARPNHyz499AaLSz+/Gr4YZciT0o6/tnqcEpsY0ONILKSnp
8fex7bA2JuFQObppUzzqHszNuGh4Bl8pkcyFlqeV4vHEEhpWdBc32S9K4cYxWpxp
B+D4J4OXHaCVIHv286zO8tYADDIy/EvPK8UGdZxa/7cEeVqBDHqXFQiu8n6QamHl
LXjV7L3GXMdvvPDZf9MmAP/xVdOBHfOTRseR7mjNjs14EYpBj+ezy/f+KwcTTOU=
=IaZv
-----END PGP SIGNATURE-----

--4AfY4lbNVy6SI0IG--
