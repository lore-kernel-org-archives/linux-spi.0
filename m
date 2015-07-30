From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
Date: Thu, 30 Jul 2015 11:51:54 +0100
Message-ID: <20150730105154.GN11162@sirena.org.uk>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150730095051.06eff8b1@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GS4hgKuWjO35gvSO"
Cc: Michal Suchanek <hramrach@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Padmavathi Venna <padma.kvr@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150730095051.06eff8b1@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--GS4hgKuWjO35gvSO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2015 at 09:50:51AM +0200, Boris Brezillon wrote:

> Since you have to patch your DTs anyway, how about putting your
> partitions in a subnode and patch the ofpart code to parse this subnode
> if it is present (see the following patch).

This is the best idea, yes - if we're changing the DT for the system
anyway then making a sane binding and using that seems better than
trying to mitigate problems with the old bindings.

--GS4hgKuWjO35gvSO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVugHFAAoJECTWi3JdVIfQH9cH/1S6NbHQrmi/jf+A98rqZo3l
81E0I2rLeyM1yprSA9pKVHUga36sXGu6+/Dpwib19s8xr3O0qj8CLEtPguL5itz/
5X6lBKOPrXWDb6rWoRIaU9sR1iMSuwHCrfooX5Buxp+hiTiGYRWQ62/F+da1B/sm
MMFStwQdxwsDjEBuK2Lk2nAyQC0ROwn37p8zqjgbJVZ7jY6JDDKduWpnHfEU4hft
jacOBSj8kG3W4ADEyTt3fagD/HuM6HYpvvxE+HINgISrYgcmlGwkT33YxCPaB0z2
CrskLgl3DnG21WMB20O82Ru/5BpV/jp+6XjpmPJiv6klfRPEXcLaL7Z2aecRnCE=
=ynHd
-----END PGP SIGNATURE-----

--GS4hgKuWjO35gvSO--
