From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: zynqmp: Fix build break
Date: Tue, 21 May 2019 22:08:43 +0100
Message-ID: <20190521210843.GC1580@sirena.org.uk>
References: <2bb66114-c976-9c44-6db3-33a5dd12edde@monstr.eu>
 <20190429162246.6061-1-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
To: Olof Johansson <olof@lixom.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190429162246.6061-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 09:22:46AM -0700, Olof Johansson wrote:
> Missing include:
> drivers/spi/spi-zynqmp-gqspi.c:1025:13: error: implicit declaration of
>   function 'zynqmp_pm_get_eemi_ops'; did you mean
>   'zynqmp_process_dma_irq'? [-Werror=3Dimplicit-function-declaration]
>=20
> Fixes: 3d0313786470a ('drivers: Defer probe if firmware is not ready')

Please copy maintainers on patches so they aren't surprised when they
get mails saying they accepted patches they never heard of before!

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzkaNoACgkQJNaLcl1U
h9CBfwgAgbLrAnQDkYTUpP7MdSDSiv8ppwZ4R/EN9OCgQb6Cjms4xG6hrxkbloPA
+oUebvqpcjb2wzduZU8tdCKx2CSU/uGlqTxG55BLy+pyrGHmFDY3MBpWr0aAj8hi
XZGbyLoZWQYWTWorcXeC50RTLzX+fRTPx0A5KJzjXU8pjUmjnA+hjDeruCcW2JNN
Suy2LE8ivUVCFUAOHVhM0bVXIbteUPRu08p3XGd3aTsfzJRn35GWepyfhnzAKX1g
OwIBgEZFHVzQ0AZh4jm4c4YdkrF/vpawZdC+48BCVtfsdreTlVzBZ8OvKfC9j4jX
q0QdP42x5IWG+4mrek1zsa3JoYmsJA==
=tUfm
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
