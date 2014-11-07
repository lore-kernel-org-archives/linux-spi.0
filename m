From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
Date: Fri, 7 Nov 2014 10:13:10 +0000
Message-ID: <20141107101310.GA8509@sirena.org.uk>
References: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
 <20141106102636.GT8509@sirena.org.uk>
 <CAAgF-BfGwcNzMx0meFVkJqNMTbQ4_PP1PZ3i6edOm6U3bc26_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BqH9fKuTou9vMXa4"
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>
To: Padma Venkat <padma.kvr@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAgF-BfGwcNzMx0meFVkJqNMTbQ4_PP1PZ3i6edOm6U3bc26_Q@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--BqH9fKuTou9vMXa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 07, 2014 at 02:01:57PM +0530, Padma Venkat wrote:

> CS can also be controlled automatically by setting AUTO_N_MANUAL to 1
> in CS_CFG. When it is auto CS automatically toggles between packet to
> packet. NCS_TIME_COUNT in CS_CFG controls the inactive period. The
> driver by default uses manual mode. But on exynos7 the manual mode is
> removed.

OK, but what's a packet here?

> I tested the driver with wm5110 codec.

Did you try firmware downloads or something else that generates multiple
transfers in a message?  Normal register writes will use a single
transfer so I'd expect them to just work.

--BqH9fKuTou9vMXa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXJs2AAoJECTWi3JdVIfQZ8UH/jVxyhU2pvbWKIMBLcRa0BVE
upCzn9UOpe1r6NF6eC4FlRV9DkVjlWTBfC3ZfKT1LCD+ZfWysOT58G2U1sA69ObY
DTmTlQazFIFYGYzjSHLDs50OnVGRBlUA/kwJeMbcOiAtbG7YmdqWECLI1c/uF6FV
BhkUa6EXUzmgpasTfmGTKRJQzrBwGM6vjeCufr2ObAvEG1AWH3PGByPcHIXKqjbl
euEl9HsF+mXo60jU4zRbm2uaJNke3oMPNhYHV3DQJxoPX0meJ6jGdP9KgoVgatQY
QRaUSQjlEYmqSN1vTsj6rtx7qB007B7sBzHQqlKXOOFolz6IzKsCKCbzh8PbEDs=
=jv0k
-----END PGP SIGNATURE-----

--BqH9fKuTou9vMXa4--
