From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] spi updates for v4.2
Date: Tue, 23 Jun 2015 11:41:02 +0100
Message-ID: <20150623104102.GB14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KnDXMCVtq+otksxP"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--KnDXMCVtq+otksxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0f57d86787d8b1076ea8f9cbdddda2a46d534a27:

  Linux 4.1-rc8 (2015-06-14 15:51:10 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.2

for you to fetch changes up to fda052b0a52261ecad8c8beb6bcfa1663a35975f:

  Merge remote-tracking branches 'spi/topic/sirf', 'spi/topic/spidev' and 'spi/topic/zynq' into spi-next (2015-06-18 00:19:56 +0100)

----------------------------------------------------------------
spi: Updates for v4.2

No framework updates for the SPI API this time around aside from one
small fix, just driver improvments.  Some highlights include:

 - New driver support for CSR USP, Mikrotik RB4xx and Zynq GQSPI
   controllers.
 - Modernisation of the OMAP McSPI controller driver, moving it to
   current APIs to enable support for a wider range of client drivers.
 - DMA support for the bcm2835 controller.

----------------------------------------------------------------
Alban Bedel (4):
      spi: spi-ath79: add binding documentation for the AR7100 SPI controller
      spi: spi-ath79: Add device tree support
      spi: spi-ath79: Use clk_prepare_enable and clk_disable_unprepare
      spi: spi-ath79: Set the initial state of CS0

Axel Lin (1):
      spi: rb4xx: Fix checking return value of devm_ioremap_resource()

Bert Vermeulen (2):
      spi: Add SPI driver for Mikrotik RB4xx series boards
      spi: rb4xx: Fix set_cs logic.

Cyrille Pitchen (3):
      spi: atmel: add support for the internal chip-select of the spi controller
      spi: atmel: update DT bindings documentation
      spi: atmel: add support to FIFOs

Daniel Mack (1):
      spi: spi-pxa2xx: remove legacy PXA DMA bits

Ezequiel Garcia (1):
      spi: pl022: Specify 'num-cs' property as required in devicetree binding

Fabio Estevam (1):
      spi: spidev: Remove unneeded variable

Geert Uytterhoeven (1):
      spi: Allow compile test of GPIO consumers if !GPIOLIB

Gregory CLEMENT (2):
      spi: orion: Fix maximum baud rates for Armada 370/XP
      spi: orion: Fix extended baud rates for each Armada SoCs

Haikun Wang (5):
      spi: spi-fsl-dspi: remove clk reference when regmap_mmio initialize
      spi: spi-fsl-dspi: Bug fix incorrect CS de-assert
      spi: spi-fsl-dspi: Enable TCF interrupt mode support
      spi: spi-fsl-dspi: Change the way of increasing spi_message->actual_length
      spi: spi-fsl-dspi: Update DT binding documentation

Hiep Cao Minh (3):
      spi: rspi: Re-do the returning value of rspi_dma_check_then_transfer
      spi: rspi: modify the name of "qspi_trigger_transfer_out_int" function
      spi: rspi: Re-do the returning value of qspi_transfer_out_in

Jane Wan (1):
      spi: fsl-espi: Fix an error that can cause fsl espi task blocked

Jarkko Nikula (3):
      spi: pxa2xx: Differentiate Intel LPSS types
      spi: pxa2xx: Prepare for new Intel LPSS SPI type
      spi: pxa2xx: Make LPSS SPI general register optional

Krzysztof Kozlowski (4):
      spi: imx: Constify platform_device_id
      spi: rspi: Constify platform_device_id
      spi: s3c64xx: Constify platform_device_id
      spi: sh-msiof: Constify platform_device_id

Mark Brown (12):
      Merge branch 'fix/bcm2835-code' of git://git.kernel.org/.../broonie/spi into spi-bcm2835
      Merge remote-tracking branch 'spi/fix/omap2-mcspi' into spi-omap2-mcspi
      Merge branch 'fix/fsl-dspi' of git://git.kernel.org/.../broonie/spi into spi-fsl-dspi
      spi: zynq: Remove execute bit
      Merge remote-tracking branch 'spi/fix/core' into spi-linus
      Merge remote-tracking branches 'spi/fix/fsl-dspi', 'spi/fix/fsl-espi', 'spi/fix/orion' and 'spi/fix/pl022' into spi-linus
      Merge remote-tracking branch 'spi/topic/bcm2835' into spi-next
      Merge remote-tracking branch 'spi/topic/omap2-mcspi' into spi-next
      Merge remote-tracking branches 'spi/topic/ath79', 'spi/topic/atmel' and 'spi/topic/davinci' into spi-next
      Merge remote-tracking branches 'spi/topic/fsl-dspi', 'spi/topic/gpio', 'spi/topic/imx' and 'spi/topic/orion' into spi-next
      Merge remote-tracking branches 'spi/topic/pxa', 'spi/topic/rb4xx', 'spi/topic/rspi', 'spi/topic/s3c64xx' and 'spi/topic/sh-msiof' into spi-next
      Merge remote-tracking branches 'spi/topic/sirf', 'spi/topic/spidev' and 'spi/topic/zynq' into spi-next

Martin Sperl (7):
      spi: spidev: use spi_sync instead of spi_async
      spi: bcm2835: change timeout of polling driver to 1s
      spi: bcm2835: fallback to interrupt for polling timeouts exceeding 2 jiffies
      spi: fix race freeing dummy_tx/rx before it is unmapped
      spi: bcm2835: enable dma modes for transfers meeting certain conditions
      spi: bcm2835: fix kbuild compile warnings/errors and a typo
      spi: restore rx/tx_buf in case of unset CONFIG_HAS_DMA

Mathias Krause (1):
      spi: pxa2xx: Constify ACPI device ids

Michael Welling (7):
      spi: omap2-mcspi: Switch driver to use transfer_one
      spi: omap2-mcspi: Add gpio_request and init CS
      spi: omap2-mcspi: Fix native cs with new set_cs
      spi: omap2-mcspi: Remove unnecessary delay
      spi: omap2-mcspi: Fix set_cs function for active high
      spi: omap2-mcspi: Fix GPIO chip select support
      spi: omap2-mcspi: Handle error on gpio_request

Mirza Krak (1):
      spi: fsl-dspi: Use pinctrl PM helpers

Murali Karicheri (1):
      spi: davinci: change the lower limit of pre-scale divider to 1

Qipan Li (6):
      spi: sirf: replace BUG condition by error code for unsupported transfer
      spi: sirf: request and free cs gpio in setup and cleanup callbacks
      spi: sirf: replace kmalloc by devm_kzalloc
      spi: sirf: add support for USP-based SPI
      spi: sirf: remove the allocation of dummypage
      spi: sirf: add the reset for USP-based SPI

Ranjit Waghmode (2):
      spi: zynq: Add DT bindings documentation for Zynq Ultrascale+ MPSoC GQSPI controller
      spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller

Yoshinori Sato (1):
      spi: bcm2835: depends GPIOLIB

kbuild test robot (1):
      spi: bcm2835: bcm2835_dma_release() can be static

 .../devicetree/bindings/spi/spi-ath79.txt          |   24 +
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |    2 +-
 .../devicetree/bindings/spi/spi-orion.txt          |    8 +-
 Documentation/devicetree/bindings/spi/spi-sirf.txt |    3 +-
 .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    |   26 +
 .../devicetree/bindings/spi/spi_atmel.txt          |    8 +-
 .../devicetree/bindings/spi/spi_pl022.txt          |    2 +-
 .../include/asm/mach-ath79/ath79_spi_platform.h    |    4 -
 drivers/spi/Kconfig                                |   26 +-
 drivers/spi/Makefile                               |    3 +-
 drivers/spi/spi-ath79.c                            |   34 +-
 drivers/spi/spi-atmel.c                            |  292 ++++-
 drivers/spi/spi-bcm2835.c                          |  392 ++++++-
 drivers/spi/spi-davinci.c                          |    2 +-
 drivers/spi/spi-fsl-dspi.c                         |  307 ++++--
 drivers/spi/spi-fsl-espi.c                         |    6 +-
 drivers/spi/spi-imx.c                              |    2 +-
 drivers/spi/spi-omap2-mcspi.c                      |  280 +++--
 drivers/spi/spi-orion.c                            |   70 +-
 drivers/spi/spi-pxa2xx-pci.c                       |    8 +-
 drivers/spi/spi-pxa2xx-pxadma.c                    |  487 ---------
 drivers/spi/spi-pxa2xx.c                           |  159 +--
 drivers/spi/spi-pxa2xx.h                           |    6 +-
 drivers/spi/spi-rb4xx.c                            |  210 ++++
 drivers/spi/spi-rspi.c                             |   23 +-
 drivers/spi/spi-s3c64xx.c                          |    2 +-
 drivers/spi/spi-sh-msiof.c                         |    2 +-
 drivers/spi/spi-sirf.c                             |  877 ++++++++++-----
 drivers/spi/spi-zynqmp-gqspi.c                     | 1122 ++++++++++++++++++++
 drivers/spi/spi.c                                  |   45 +-
 drivers/spi/spidev.c                               |   33 +-
 include/linux/pxa2xx_ssp.h                         |    3 +-
 32 files changed, 3281 insertions(+), 1187 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-ath79.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
 delete mode 100644 drivers/spi/spi-pxa2xx-pxadma.c
 create mode 100644 drivers/spi/spi-rb4xx.c
 create mode 100644 drivers/spi/spi-zynqmp-gqspi.c

--KnDXMCVtq+otksxP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJViTe+AAoJECTWi3JdVIfQkoIH/A1Am7/DX6ISfYdikUvklMyB
BKoaHC2fsW5bSPlo4nyqSovD5bEAyYRqCCSKG0RF5FXLLeKEM1V7swJF012UwMfh
v3iLaWiBY2MyxWPgZFeEPYiJ5uo5HY08X91r6uJ5vDVOEYvfwwO365aXLAQWy8J7
uyI5v9CXDrgHL3yd/1Ig8GqaGD4cJaehfJ1YIbVxhzhEsL/zffutQxqAkBtJST4I
ZbUxAB19CiSeR4+guihLiqcvd2elYBOW5QNrTXhuQ2+MLZ7KERGLDUvZ4tt04PSU
TyoGleaJNl2VTKbLqP4uCBFMWO33Zqtkwue7D3lMStxA339CPG2n0ESy9ndWiXc=
=/7rz
-----END PGP SIGNATURE-----

--KnDXMCVtq+otksxP--
