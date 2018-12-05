From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 002/123] spi: uniphier: fix incorrect
 property items
Date: Wed, 5 Dec 2018 11:38:20 +0000
Message-ID: <20181205113820.GB6205@sirena.org.uk>
References: <20181205093555.5386-1-sashal@kernel.org>
 <20181205093555.5386-2-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205093555.5386-2-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 04:33:54AM -0500, Sasha Levin wrote:
> From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
>=20
> [ Upstream commit 3511ba7d4ca6f39e2d060bb94e42a41ad1fee7bf ]
>=20
> This commit fixes incorrect property because it was different
> from the actual.
> The parameters of '#address-cells' and '#size-cells' were removed,
> and 'interrupts', 'pinctrl-names' and 'pinctrl-0' were added.

Not sure we should be backporting documentation changes like this to
stable, especially not without accompanying code changes...

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwHuKsACgkQJNaLcl1U
h9BdGQf/cVEzlCz8LauxdMkpmxd0zk92aQB/jLXrj3Pj09j/PoB86dqeUI1VB7Q3
yGMxw6fC9Zir4cVF/r3J5I3js+BkF8F+5qCBsw2oa2v6oM8Laqat8l0U36zUulyR
Qr53SzOSGC64SH8tiXju/jRVAFAeTF07eNlSHg2Q4+cNdOqrdnn/tIDWvpC8Fqvf
9HlSLMnT19FHWm3U9f/nkzqm+UmxirUKyg2sJl1CSApMgoRqNDiMn7vkTArYXISs
V97WQ+CUSCJIca6/Etko7By+ky8wTpodYSi40uZTomzM8HoHunoxRaVGRa9vAXto
2j1FDIiwmilt8t6WBNlGI9GZ5i8p7Q==
=/7CJ
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
