From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v4.5
Date: Tue, 12 Jan 2016 10:54:38 +0000
Message-ID: <20160112105438.GZ6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Se7r6+WGlSF2mKVG"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Se7r6+WGlSF2mKVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 168309855a7d1e16db751e9c647119fe2d2dc878:

  Linux 4.4-rc8 (2016-01-03 15:15:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.5

for you to fetch changes up to cabeea980879c2c701b0bd03f145c9f7dae17a63:

  Merge remote-tracking branches 'spi/topic/sun4i', 'spi/topic/topcliff-pch' and 'spi/topic/zynq' into spi-next (2016-01-11 16:48:38 +0000)

----------------------------------------------------------------
spi: Updates for v4.5

A quiet release for SPI, not even many driver updates:

 - Add a dummy loopback driver for use in exercising framework features
   during development.
 - Move the test utilities to tools/ and add support for transferring
   data to and from a file instead of stdin and stdout to spidev_test.
 - Support for Mediatek MT2701 and Renesas AG5 deices.

----------------------------------------------------------------
Anton Bondarenko (8):
      spi: imx: terminate RX DMA transaction in case of TX DMA timeout
      spi: imx: reorder HW operations enable order to avoid possible RX data loss
      spi: imx: replace multiple watermarks with single for RX, TX and RXT
      spi: imx: add function to check for IMX51 family controller
      spi: imx: fix loopback mode setup after controller reset
      spi: imx: enable loopback only for ECSPI controller family
      spi: imx: return error from dma channel request
      spi: imx: defer spi initialization, if DMA engine is

Arnd Bergmann (1):
      spi: s3c64xx: pass DMA arguments in platform data

Dan Carpenter (1):
      spi: loopback: fix typo in MODULE_PARM_DESC

Fabio Estevam (2):
      spi: imx: Add loopback mode support
      spi: spidev_test: Fix typo in error message

Geert Uytterhoeven (5):
      spi/bcm63xx: Move default clock configuration to kill compiler warning
      spi: sh-msiof: Add support for SH-Mobile AG5
      spi: spidev: Use "%u" to format __u32
      spi: Uninline spi_unregister_device()
      spi: Mark instantiated device nodes with OF_POPULATE

Geliang Tang (3):
      spi: use to_spi_device
      spi: cadence: use to_platform_device()
      spi: zynq: use to_platform_device()

Jisheng Zhang (1):
      spi: dw: Use SPI_TMOD_TR rather than magic const 0 to set tmode

Joshua Clayton (7):
      spi: Move spi code from Documentation to tools
      spi: spidev_test: transfer_escaped_string function
      spi: spidev_test: accept input from a file
      spi: spidev_test: output to a file
      spi: spidev_test: check error
      spi: spidev_test: fix whitespace
      spi: tools: move spidev_test metadata

Julia Lawall (1):
      spi: dw-mid: constify dw_spi_dma_ops structure

Leilk Liu (4):
      spi: mediatek: revise mtk_spi_probe() failure flow
      spi: mtk: Add bindings for mediatek MT2701 soc platform
      spi: mediatek: merge all identical compat to mtk_common_compat
      spi: mediatek: Add spi support for mt2701 IC

Marcus Weseloh (2):
      spi: sun4i: allow transfers to set transmission speed
      spi: sun4i: Prevent chip-select from being activated twice before a transfer

Mark Brown (9):
      Merge branch 'fix/mediatek' of git://git.kernel.org/.../broonie/spi into spi-mtk
      Merge remote-tracking branch 'spi/fix/mtk' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branch 'spi/topic/sunxi' into spi-next
      Merge remote-tracking branches 'spi/topic/bcm63xx', 'spi/topic/butterfly', 'spi/topic/cadence' and 'spi/topic/davinci' into spi-next
      Merge remote-tracking branches 'spi/topic/dw', 'spi/topic/dw-mid', 'spi/topic/fsl-espi' and 'spi/topic/imx' into spi-next
      Merge remote-tracking branches 'spi/topic/lm70llp', 'spi/topic/loopback', 'spi/topic/mtk' and 'spi/topic/omap2-mcspi' into spi-next
      Merge remote-tracking branches 'spi/topic/overlay', 'spi/topic/pxa2xx', 'spi/topic/s3c64xx', 'spi/topic/sh-msiof' and 'spi/topic/spidev' into spi-next
      Merge remote-tracking branches 'spi/topic/sun4i', 'spi/topic/topcliff-pch' and 'spi/topic/zynq' into spi-next

Martin Sperl (9):
      spi: add spi_message_init_no_memset to avoid zeroing the spi_message
      spi: add loopback test driver to allow for spi_master regression tests
      spi: add spi-loopback-test to build framework
      spi: loopback: fix printk format issues with size_t
      spi: loopback: match configuration of test to description
      spi: loopback: added additional non-power of 2 transfer lengthes
      spi: loopback-test: write rx pattern also when running without tx_buf
      spi: loopback-test: rename method spi_test_fill_tx to spi_test_fill_pattern
      spi: loopback-test: spi_check_rx_ranges can get always done

Michael Welling (1):
      spi: omap2-mcspi: Prevent duplicate gpio_request

Michal Suchanek (2):
      spi: expose master transfer size limitation.
      spi: fsl-espi: expose maximum transfer size limit

Mika Westerberg (1):
      spi: pxa2xx: Remove redundant call to lpss_ssp_setup() in probe

Nicolas Boichat (1):
      spi: mediatek: Prevent overflows in FIFO transfers

Pascal Huerst (1):
      spi: omap2-mcspi: Add calls for pinctrl state select

Paul Burton (1):
      spi: topcliff-pch: allow build for MIPS platforms

Sekhar Nori (2):
      spi: davinci: fix spurious i/o error
      spi: davinci: use dev_err() for error reporting

Sudip Mukherjee (12):
      spi: butterfly: remove multiple blank lines
      spi: butterfly: remove cast to void
      spi: butterfly: correct alignment
      spi: butterfly: use new parport device model
      spi: lm70llp: remove multiple blank lines
      spi: lm70llp: add blank line after declaration
      spi: lm70llp: remove cast to void
      spi: lm70llp: correct alignment
      spi: lm70llp: remove space
      spi: lm70llp: use new parport device model
      spi: lm70llp: use dev_warn
      spi: lm70llp: remove printk

Sylwester Nawrocki (1):
      spi: s3c64xx: Remove unused platform_device_id entries

leilk.liu@mediatek.com (3):
      spi: mediatek: update document devicetree bindings to fix syntax error
      spi: mediatek: remove unrequired description
      spi: mediatek: remove needless pair of writel()/readl()

 Documentation/Makefile                             |    2 +-
 Documentation/devicetree/bindings/spi/sh-msiof.txt |    1 +
 .../devicetree/bindings/spi/spi-mt65xx.txt         |    9 +-
 Documentation/spi/00-INDEX                         |    4 -
 Documentation/spi/Makefile                         |    8 -
 arch/arm/plat-samsung/devs.c                       |   19 +-
 drivers/spi/Kconfig                                |   11 +-
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-bcm63xx.c                          |    7 +-
 drivers/spi/spi-butterfly.c                        |   30 +-
 drivers/spi/spi-cadence.c                          |    6 +-
 drivers/spi/spi-davinci.c                          |   17 +-
 drivers/spi/spi-dw-mid.c                           |    2 +-
 drivers/spi/spi-dw.c                               |    2 +-
 drivers/spi/spi-dw.h                               |    2 +-
 drivers/spi/spi-fsl-espi.c                         |    6 +
 drivers/spi/spi-imx.c                              |  101 +-
 drivers/spi/spi-lm70llp.c                          |   43 +-
 drivers/spi/spi-loopback-test.c                    | 1005 ++++++++++++++++++++
 drivers/spi/spi-mt65xx.c                           |   64 +-
 drivers/spi/spi-omap2-mcspi.c                      |   31 +-
 drivers/spi/spi-pxa2xx.c                           |    3 -
 drivers/spi/spi-s3c64xx.c                          |   33 +-
 drivers/spi/spi-sun4i.c                            |   14 +-
 drivers/spi/spi-sun6i.c                            |    8 +-
 drivers/spi/spi-test.h                             |  136 +++
 drivers/spi/spi-zynqmp-gqspi.c                     |    8 +-
 drivers/spi/spi.c                                  |   32 +-
 drivers/spi/spidev.c                               |    2 +-
 include/linux/platform_data/spi-s3c64xx.h          |    2 +
 include/linux/spi/spi.h                            |   29 +-
 tools/Makefile                                     |    7 +-
 {Documentation => tools}/spi/.gitignore            |    0
 tools/spi/Makefile                                 |    4 +
 {Documentation => tools}/spi/spidev_fdx.c          |    0
 {Documentation => tools}/spi/spidev_test.c         |  119 ++-
 36 files changed, 1536 insertions(+), 232 deletions(-)
 delete mode 100644 Documentation/spi/Makefile
 create mode 100644 drivers/spi/spi-loopback-test.c
 create mode 100644 drivers/spi/spi-test.h
 rename {Documentation => tools}/spi/.gitignore (100%)
 create mode 100644 tools/spi/Makefile
 rename {Documentation => tools}/spi/spidev_fdx.c (100%)
 rename {Documentation => tools}/spi/spidev_test.c (75%)

--Se7r6+WGlSF2mKVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWlNtuAAoJECTWi3JdVIfQzN8H/0SGikCB4IXEPgPRCkusZEF1
uQmLbiv5kYdpAnjutlRcZKFt4BYwIRs+tCaRVMrwhVr3cEz9a7Ay4IDz+1217bnE
74qUSbXHnBslK3OZ7lEkvavf2fqTCKcWypFa57utaqfKq2Oh0kpCQrTfJmbIqfQ2
0IvrvoOqy9+XQXVxPi8y2UxlUom34E63b7uwskNzDrhe/T6ehw1m1IW70jIAK9p0
U6Uhn+OddHjGNtZqDIuXKAvvF3tD4adscXI+lit0HXq5tJd0u85/LRCBrEQvRrOA
Vri1Ln446pBBGsAHOdp9cbJURzpBlZNwfnEU35/ZGug0Ntf2IRno2TGhi5Mqf20=
=EngZ
-----END PGP SIGNATURE-----

--Se7r6+WGlSF2mKVG--
