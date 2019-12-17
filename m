From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.5
Date: Tue, 17 Dec 2019 12:19:32 +0000
Message-ID: <20191217121932.GD4755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ffa119f7c42d29be2dd759bb18cc4d1f45804c6b:

  dt-bindings: spi: Convert stm32 QSPI bindings to json-schema (2019-11-22 19:54:02 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.5-rc2

for you to fetch changes up to 63aa6a692595d47a0785297b481072086b9272d2:

  spi: fsl: use platform_get_irq() instead of of_irq_to_resource() (2019-12-16 11:54:55 +0000)

----------------------------------------------------------------
spi: Fixes for v5.5

A relatively large set of fixes here, the biggest part of it is for
fallout from the GPIO descriptor rework that affected several of the
devices with usable native chip select support.  There's also some new
PCI IDs for Intel Jasper Lake devices.

The conversion to platform_get_irq() in the fsl driver is an incremental
fix for build errors introduced on SPARC by the earlier fix for error
handling in probe in that driver.

----------------------------------------------------------------
Charles Keepax (2):
      spi: cadence: Correct handling of native chipselect
      spi: dw: Correct handling of native chipselect

Christophe Leroy (2):
      spi: fsl: don't map irq during probe
      spi: fsl: use platform_get_irq() instead of of_irq_to_resource()

Chuhong Yuan (1):
      spi: spi-cavium-thunderx: Add missing pci_release_regions()

Huanpeng Xin (1):
      spi: sprd: Fix the incorrect SPI register

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Jasper Lake

Linus Walleij (3):
      spi: fsl: Fix GPIO descriptor support
      gpio: Handle counting of Freescale chipselects
      spi: fsl: Handle the single hardwired chipselect case

Michael Walle (1):
      spi: nxp-fspi: Ensure width is respected in spi-mem operations

Vignesh Raghavendra (1):
      spi: spi-ti-qspi: Fix a bug when accessing non default CS

YueHaibing (1):
      gpiolib: of: Make of_gpio_spi_cs_get_count static

 drivers/gpio/gpiolib-of.c         | 27 +++++++++++++++++++++++++++
 drivers/spi/spi-cadence.c         |  6 +++---
 drivers/spi/spi-cavium-thunderx.c |  2 ++
 drivers/spi/spi-dw.c              |  5 +++--
 drivers/spi/spi-fsl-spi.c         | 22 ++++++++++++++++------
 drivers/spi/spi-nxp-fspi.c        |  2 +-
 drivers/spi/spi-pxa2xx.c          |  4 ++++
 drivers/spi/spi-sprd.c            |  2 +-
 drivers/spi/spi-ti-qspi.c         |  6 +++++-
 9 files changed, 62 insertions(+), 14 deletions(-)

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl34x9QACgkQJNaLcl1U
h9B+JAf/Ylidg086Rnwni1iceLJZ1OWaI4OZ3tuEECH8MqA1zJFkJjTRxDjwPX3O
oXrB0N3TpyABKLf3qFwugTK3Yta3Kl9q4bfzuLkTkUYX0/RB7XhQc6p6TeyBCrel
yxcjfiuuC3Vd0EPL5DU+8plmH+o+1XmlY8C2gwVSxppUhRt86rwhLEmP3nuMGZPq
chbA85wExtGWuU1sCQHNbyeyQSUl4oZb/jeaF8j7H9SL1bpD1NPZ7rmH7TqsiX//
XyWOcd2kdHFWxZ/VFrSha/UuOBJrKbZ/1kcnPnQbDYuSolhUIJ8hywAnS7Ab7boY
YlgyZ3d6LIAc9FoL5c8G0z1l6FIcrg==
=4C1I
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
