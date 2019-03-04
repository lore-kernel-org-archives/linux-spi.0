From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: dw: Add support for an optional interface clock
Date: Mon, 4 Mar 2019 00:04:33 +0000
Message-ID: <20190304000433.GO23441@sirena.org.uk>
References: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
 <1551360342-23981-3-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551360342-23981-3-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 01:25:42PM +0000, Gareth Williams wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>=20
> The Synopsys SSI Controller has an interface clock, but most SoCs hide=20
> this away. However, on some SoCs you need to explicity enable the=20
> interface clock in order to access the registers. Therefore, add=20
> support for an optional interface clock.

This doesn't build for me:

  CC      drivers/spi/spi-dw-mmio.o
drivers/spi/spi-dw-mmio.c: In function =E2=80=98dw_spi_mmio_probe=E2=80=99:
drivers/spi/spi-dw-mmio.c:177:18: error: implicit declaration of function =
=E2=80=98devm_clk_get_optional=E2=80=99; did you mean =E2=80=98devm_gpiod_g=
et_optional=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  dwsmmio->pclk =3D devm_clk_get_optional(&pdev->dev, "pclk");
                  ^~~~~~~~~~~~~~~~~~~~~
                  devm_gpiod_get_optional
drivers/spi/spi-dw-mmio.c:177:16: warning: assignment to =E2=80=98struct cl=
k *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without =
a cast [-Wint-conversion]
  dwsmmio->pclk =3D devm_clk_get_optional(&pdev->dev, "pclk");
                ^

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx8a5EACgkQJNaLcl1U
h9AIWAf9HDmrXbTnxVnkqRuJ/D4ahaWL1j36TX2EFtbe2UpYA6akgolCZN+NhyaA
Txy2CXOSJge+9lX+Fv5ocJ13dAQmsE9QONkEZTWNLeLywRfyksIs5oy4ZFxnlMrL
RWyQWY8XJN2x3JhI0cVkI8FLTGaenAy53DV0ORU9Lr/yfkt3092135Wf5ZCCUWdK
J3lViFs8ipokb8YrGaJnXA3A8hCcIujOOFGmGgVxiG8N0r3VQ3xDh9VwJBTDeqN6
gg5RBhH5Mq9YxD+8/wZhGNXB/2LALr9VpchpiUzqwjyLci23o+0lXd/2UhuPg6Sf
gSmZIBPduryrQNxDAK0H3kvQle8rYA==
=emC2
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--
