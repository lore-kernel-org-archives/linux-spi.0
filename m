From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v4.16
Date: Mon, 29 Jan 2018 13:00:45 +0000
Message-ID: <20180129130045.GD10969@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 0c5b9b5d9adbad4b60491f9ba0d2af38904bb4b9:

  Linux 4.15-rc9 (2018-01-21 13:51:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v4.16

for you to fetch changes up to 35a8f1a94d12631afcd55a2a518faa112324f8d1:

  Merge remote-tracking branch 'spi/topic/xilinx' into spi-next (2018-01-26=
 17:57:34 +0000)

----------------------------------------------------------------
spi: Updates for v4.16

Quite a quiet release for SPI, there are no changes at all to the core
and not that many changes to drivers.  Highlights of those driver
changes include:

 - SH MSIOF support for GPIO chip selects contributed by Geert
   Uytterhoeven.
 - Full duplex support for a3700 contributed by Maxime Chevallier.
 - Support for DMA transfers on Atmel devices that require a bounce
   buffer contributed by Radu Pirea.

----------------------------------------------------------------
Andi Shyti (1):
      spi: s3c64xx: add SPDX identifier

Christophe Jaillet (1):
      spi: orion: Fix a resource leak if the optional "axi" clk is deferred

Geert Uytterhoeven (6):
      spi: sh-msiof: Use dev_warn_once() instead of open-coding
      spi: sh-msiof: Avoid writing to registers from spi_master.setup()
      spi: sh-msiof: Extend support to 3 native chip selects
      spi: sh-msiof: Implement cs-gpios configuration
      spi: sh-msiof: Document hardware limitations related to chip selects
      spi: sh-msiof: Fix timeout failures for TX-only DMA transfers

Gregory CLEMENT (1):
      spi: orion: Fix clock resource by adding an optional bus clock

Jarkko Nikula (1):
      spi: dw: Remove unused members from struct chip_data

Julia Lawall (2):
      spi: sirf: account for const type of of_device_id.data
      spi: spi-fsl-dspi: account for const type of of_device_id.data

Kurt Kanzenbach (1):
      spi: spi-fsl-dspi: add SPI_LSB_FIRST to driver capabilities

Mark Brown (6):
      spi: pxa2xx: Use gpiod_put() not gpiod_free()
      Merge remote-tracking branches 'spi/fix/imx' and 'spi/fix/sh-msiof' i=
nto spi-linus
      Merge remote-tracking branches 'spi/topic/a3700', 'spi/topic/atmel', =
'spi/topic/bcm53xx', 'spi/topic/davinci' and 'spi/topic/dw' into spi-next
      Merge remote-tracking branches 'spi/topic/fsl-dspi', 'spi/topic/imx',=
 'spi/topic/jcore', 'spi/topic/meson' and 'spi/topic/orion' into spi-next
      Merge remote-tracking branches 'spi/topic/pxa2xx', 'spi/topic/s3c64xx=
', 'spi/topic/sh-msiof', 'spi/topic/sirf' and 'spi/topic/sun6i' into spi-ne=
xt
      Merge remote-tracking branch 'spi/topic/xilinx' into spi-next

Maxime Chevallier (6):
      spi: a3700: Clear DATA_OUT when performing a read
      spi: a3700: Set frequency limits at startup
      spi: a3700: Allow to enable or disable FIFO mode
      spi: a3700: Add full-duplex support
      spi: a3700: Remove endianness swapping functions when accessing FIFOs
      spi: a3700: Remove endianness swapping for full-duplex transfers

Michele Dionisio (1):
      spi: davinci: Initialize dspi->done before any possible use of it

Radu Pirea (1):
      spi: atmel: Implements transfers with bounce buffer

Rafa=C5=82 Mi=C5=82ecki (1):
      spi: bcm53xx: simplify reading SPI data

Rasmus Villemoes (1):
      spi: pxa2xx: avoid redundant gpio_to_desc(desc_to_gpio()) round-trip

Ricardo Ribalda Delgado (1):
      spi: xilinx: Add support for xlnx,axi-quad-spi-1.00.a

Stefan Agner (1):
      spi: imx: do not access registers while clocks disabled

Sunny Luo (2):
      spi: meson-axg: update compatible string for the Meson-AXG
      spi: meson-axg: add SPICC driver support

Takuo Koguchi (1):
      spi: jcore: disable clock when registering spi conroller failed

Tobias Jordan (1):
      spi: sun6i: disable/unprepare clocks on remove

Trent Piepho (1):
      spi: imx: Fix failure path leak on GPIO request error correctly

 Documentation/devicetree/bindings/spi/sh-msiof.txt |  16 ++-
 .../devicetree/bindings/spi/spi-meson.txt          |   4 +-
 .../devicetree/bindings/spi/spi-orion.txt          |   9 ++
 .../devicetree/bindings/spi/spi-xilinx.txt         |   2 +-
 drivers/spi/spi-armada-3700.c                      | 110 +++++++++++++++---
 drivers/spi/spi-atmel.c                            | 113 +++++++++++++-----
 drivers/spi/spi-bcm53xx.c                          |  26 ++---
 drivers/spi/spi-davinci.c                          |   4 +-
 drivers/spi/spi-dw.c                               |   2 -
 drivers/spi/spi-fsl-dspi.c                         |   9 +-
 drivers/spi/spi-imx.c                              |  26 +++--
 drivers/spi/spi-jcore.c                            |   4 +-
 drivers/spi/spi-meson-spicc.c                      |   1 +
 drivers/spi/spi-orion.c                            |  21 +++-
 drivers/spi/spi-pxa2xx.c                           |   4 +-
 drivers/spi/spi-s3c64xx.c                          |  18 +--
 drivers/spi/spi-sh-msiof.c                         | 128 +++++++++++++++++=
----
 drivers/spi/spi-sirf.c                             |   4 +-
 drivers/spi/spi-sun6i.c                            |   2 +-
 drivers/spi/spi-xilinx.c                           |   1 +
 include/linux/platform_data/spi-s3c64xx.h          |   6 +-
 21 files changed, 378 insertions(+), 132 deletions(-)

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpvGvwACgkQJNaLcl1U
h9AJ5Af8CzYOataWWwPpYAlNRrMblbeOdglDm20L+AYT4lF4ugi/d0Y+kxjc3+PC
BlfrYLFzwEBXVAXq9NLCseuCctNslFnI6ODyFxRT7aGpZn941eyWUK1o/43lkp+P
/D3q/ESoBnUkz10Yd9lkZz+NiVqISLp3cqsSVMyE/hYY27qhEw4+GrxIFmNIDKeL
8Hp+eX/nVqNmAq/I7H2rHPb8z5CXcyYq7hh1IlNMNIyHcgFWFliO3CalBhDSz6LE
fXKjjdrW/ZFx6t8chFJinNwvgQI0FVZMLONONCV1yfrecnPgFVUK9If1fkIUhN8b
WgZNCEvOGKIU0AgGE2klqVVWeQgbdA==
=BX+u
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
