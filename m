From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 3/7] spi: tegra: remove redundant "depends on
 RESET_CONTROLLER"
Date: Thu, 5 Nov 2015 11:50:30 +0000
Message-ID: <20151105115030.GB18409@sirena.org.uk>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
 <1446722128-11961-4-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Cc: linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-spi@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446722128-11961-4-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 08:15:24PM +0900, Masahiro Yamada wrote:
> ARCH_TEGRA selects RESET_CONTROLLER.
> The dependency "depends on RESET_CONTROLLER" is already met.

>  	tristate "NVIDIA Tegra114 SPI Controller"
>  	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
> -	depends on RESET_CONTROLLER && HAS_DMA
> +	depends on HAS_DMA

Again, this driver doesn't depend on ARCH_TEGRA.

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO0KCAAoJECTWi3JdVIfQf8MH/Rl/BgtaeVMgYG2wOTDTP+Wm
dyZmYDGwm4qfXGicMY9jYbZzSKETtLT2oWR6KZdqCGicD2noXzuuw+KjBAPoZ2ZW
iE73Gpkh6wkmDfwnsQ9DtATu8BAs7TtrZTPOkhgabRhHRnkUXTlJmaPnMt0+HtRy
v/Cb4Tb4YcBjD1UPp44hgXLYVpacet7b5kFvpiKvLKDcR5AH6sNAoPXjhdvuDDO9
RPfQLjWbWifx2zg/NvKKv+KIk+9Sp1Xgx76pb4UIOeh4rmaXNv9ry6NX9hAT4Q4x
WwRLx98K+45Lu08Cca9TFu+zBvEdOZ12g7bR/h4tmR16zu5LvrkjfGzdqyKWf0c=
=EvZM
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
