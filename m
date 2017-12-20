From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v4.15
Date: Wed, 20 Dec 2017 17:14:38 +0000
Message-ID: <20171220171438.GI17890@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.15-rc4

for you to fetch changes up to 4d029763724b6365c83c98f86f0958882efa8796:

  Merge remote-tracking branches 'spi/fix/armada', 'spi/fix/atmel', 'spi/fix/doc', 'spi/fix/imx', 'spi/fix/rspi', 'spi/fix/sun4i' and 'spi/fix/xilinx' into spi-linus (2017-12-19 11:07:00 +0000)

Hopefully I've managed to appease GMail, we shall see.

----------------------------------------------------------------
spi: Fixes for v4.15-rc4

A bunch of really small fixes here, all driver specific and mostly in
error handling and remove paths.  The most important fixes are for the
a3700 clock configuration and a fix for a nasty stall which could
potentially cause data corruption with the xilinx driver.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      spi: Fix double "when"
      spi: rspi: Do not set SPCR_SPE in qspi_set_config_register()

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/armada', 'spi/fix/atmel', 'spi/fix/doc', 'spi/fix/imx', 'spi/fix/rspi', 'spi/fix/sun4i' and 'spi/fix/xilinx' into spi-linus

Maxime Chevallier (1):
      spi: a3700: Fix clk prescaling for coefficient over 15

Radu Pirea (1):
      spi: atmel: fixed spin_lock usage inside atmel_spi_remove

Ricardo Ribalda Delgado (1):
      spi: xilinx: Detect stall with Unknown commands

Takuo Koguchi (1):
      spi: sun4i: disable clocks in the remove function

Trent Piepho (1):
      spi: imx: Update device tree binding documentation

 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 18 ++++++++++++------
 drivers/spi/spi-armada-3700.c                          |  8 ++++++++
 drivers/spi/spi-atmel.c                                |  2 +-
 drivers/spi/spi-rspi.c                                 |  4 ++--
 drivers/spi/spi-sun4i.c                                |  2 +-
 drivers/spi/spi-xilinx.c                               | 11 +++++++++++
 include/linux/spi/spi.h                                |  2 +-
 7 files changed, 36 insertions(+), 11 deletions(-)

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlo6mn0ACgkQJNaLcl1U
h9Du9Qf/UjGfoMu/SgkyH15iAyghcpYekgviWzLtKguq6sFROw5setpqlw+3G/Fz
0yQMbjuSl5WCQOFohNeL11zLfUIeW88Jn6fVioGC2WHS0VQRdkA+lgzu2To07mW9
K/mT3p2YLwGs1SMaAsk6f9kY3LfX77pTguYS6Xr3Bx5JRXs8NHfVcxCR+Utx/+ab
daLf4t4sJirTo8uyJ/bYohjYC+xtYbqQaDVFakgbqE471xGnvA9Utir4mKygS2Az
JSBaxSYkuUZHYIvPcdLcW5gKHGu0XZP4FH1AALHNLPg3TCnDa0zbrEXCCShMt7qk
bU8gAQoy6tdmvcGTGGhPZGZ9jIxHvQ==
=skcL
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
