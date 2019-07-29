From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] spi: tle620x: remove stale driver
Date: Mon, 29 Jul 2019 11:51:25 +0100
Message-ID: <20190729105125.GA4787@sirena.org.uk>
References: <20190728161304.32022-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Cc: linux-spi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190728161304.32022-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2019 at 01:13:04AM +0900, Masahiro Yamada wrote:
> This driver seems obsolte because this driver needs platform data
> but no one in upstream passes it.

I've not noticed this driver getting in the way of anything?

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0+z6wACgkQJNaLcl1U
h9A8iQf/WUaWbus2/y56hSB5wgIdbmnLdlQKFIbOiLlLCvTHg1+B16u4ggqtmNNy
i/LxhIXJHljhPSB5UqNvqGbUUfJPqlC6EjP/VH9Se25srhYgCzNetng4TSJgUhf6
mPx38/UCRMss9iggUIlCcZlwum4olpdkChGQCKbRpJYiJEmAT4/iiNdRbOhNVGor
w75RTowSMbKKwzSw/vcrpZiyH+XV2xoRGiDRAR2yltKK84yEEvRd8LsiZnYtKm/f
oEVeTbr2aM5P0EmyoTUN6waKMEHyUKDfiYI8fPqh+YIqEUM1cGor0tRyQUFah9G/
+M/W7SX1YG7bE4+hsWQjfNpfkAxf4Q==
=+NF+
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
