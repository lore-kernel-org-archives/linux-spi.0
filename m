From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v5.4
Date: Mon, 16 Sep 2019 00:18:11 +0100
Message-ID: <20190915231811.GQ4352@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SvyA5ywaG/v2A5dH"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--SvyA5ywaG/v2A5dH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v5.4

for you to fetch changes up to b769c5ba8aedc395ed04abe6db84a556d28beec1:

  Merge branch 'spi-5.4' into spi-next (2019-09-15 10:32:06 +0100)

----------------------------------------------------------------
spi: Updates for v5.4

The big theme for this release has been performance, we've had a series
of unrelated overhauls of a few drivers all with a big peformance
component.  Otherwise it's been relatively quiet, highlights include:

 - A big overhaul of the spi-fsl-dspi driver improving the code quality,
   performance and stability from Vladimir Oltean.
 - A big performance enhancement for the bc2835 (Raspberry Pi) driver
   for unidirectional transfers from Lukas Wunner.
 - Improved performance on small transfers for the uniphier driver from
   Keiji Hayashibara.
 - Lots of coccinelle generated cleanups from Yue Haibing.
 - New device support for Freescale ls2080a and Nuvoton NPCM FIU.

----------------------------------------------------------------
Alexander Sverdlin (1):
      spi: ep93xx: Repair SPI CS lookup tables

Andy Shevchenko (2):
      spi: dw-mmio: Use devm_platform_ioremap_resource()
      spi: dw-mmio: Clock should be shut when error occurs

Ashish Kumar (2):
      spi: fsl-qspi: Enhance binding to extend example for flash entry
      spi: spi-fsl-qspi: Add ls2080a compatibility string to bindings

Axel Lin (1):
      spi: zynq-qspi: Fix missing spi_unregister_controller when unload mod=
ule

Baolin Wang (3):
      spi: sprd: adi: Remove redundant address bits setting
      spi: sprd: adi: Change hwlock to be optional
      spi: sprd: Change the hwlock support to be optional

Chenxu Wei (1):
      spi: sprd: adi: Add a reset reason for TOS panic

Chuhong Yuan (1):
      spi: dw-pci: Use dev_get_drvdata

Colin Ian King (1):
      spi: npcm-fiu: fix spelling mistake "frequancy" -> "frequency"

Geert Uytterhoeven (2):
      spi: core: Use DEVICE_ATTR_RW() for SPI slave control sysfs attribute
      spi: sh-msiof: Use devm_platform_ioremap_resource() helper

Jarkko Nikula (2):
      spi: dw-pci: Add support for Intel Elkhart Lake PSE SPI
      spi: dw-pci: Add MODULE_DEVICE_TABLE

Keiji Hayashibara (3):
      spi: uniphier: fix wrong register overwrite
      spi: uniphier: remove unnecessary code
      spi: uniphier: introduce polling mode

Linus Walleij (3):
      spi: Rename of_spi_register_master() function
      spi: fsl: Convert to use CS GPIO descriptors
      spi: bcm2835: Convert to use CS GPIO descriptors

Lukas Wunner (10):
      spi: bcm2835: Work around DONE bit erratum
      spi: bcm2835: Drop dma_pending flag
      dmaengine: bcm2835: Allow cyclic transactions without interrupt
      dmaengine: bcm2835: Allow reusable descriptors
      spi: Guarantee cacheline alignment of driver-private data
      dmaengine: bcm2835: Document struct bcm2835_dmadev
      spi: bcm2835: Cache CS register value for ->prepare_message()
      dmaengine: bcm2835: Avoid accessing memory when copying zeroes
      spi: bcm2835: Speed up TX-only DMA transfers by clearing RX FIFO
      spi: bcm2835: Speed up RX-only DMA transfers by zero-filling TX FIFO

Manivannan Sadhasivam (1):
      spi: Fix the number of CS lines documented as an example

Mark Brown (3):
      Merge branch 'spi-5.3' into spi-5.4
      Merge branch 'spi-5.3' into spi-linus
      Merge branch 'spi-5.4' into spi-next

Markus Elfring (1):
      spi-gpio: Use PTR_ERR_OR_ZERO() in spi_gpio_request()

Peter Zijlstra (1):
      spi: Reduce kthread priority

Rayagonda Kokatanur (2):
      spi: bcm-qspi: Fix BSPI QUAD and DUAL mode support when using flex mo=
de
      spi: bcm-qspi: Make BSPI default mode

Sherry Zong (2):
      spi: sprd: adi: Add a reset reason for factory test mode
      spi: sprd: adi: Add a reset reason for watchdog mode

Stephen Boyd (1):
      spi: Remove dev_err() usage after platform_get_irq()

Tomer Maimon (2):
      dt-binding: spi: add NPCM FIU controller
      spi: npcm-fiu: add NPCM FIU controller driver

Uwe Kleine-K=F6nig (1):
      spi: atmel: add tracing to custom .transfer_one_message callback

Vladimir Oltean (19):
      spi: spi-fsl-dspi: Fix code alignment
      spi: spi-fsl-dspi: Remove unused defines and includes
      spi: spi-fsl-dspi: Use BIT() and GENMASK() macros
      spi: spi-fsl-dspi: Demistify magic value in SPI_SR_CLEAR
      spi: spi-fsl-dspi: Change usage pattern of SPI_MCR_* and SPI_CTAR_* m=
acros
      spi: spi-fsl-dspi: Reduce indentation in dspi_release_dma()
      spi: spi-fsl-dspi: Remove unused initialization of 'ret' in dspi_probe
      spi: spi-fsl-dspi: Remove pointless assignment of master->transfer to=
 NULL
      spi: spi-fsl-dspi: Replace legacy spi_master names with spi_controller
      spi: spi-fsl-dspi: Use reverse Christmas tree declaration order
      spi: spi-fsl-dspi: Fix typos
      spi: spi-fsl-dspi: Move dspi_interrupt above dspi_transfer_one_message
      spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not ours
      spi: spi-fsl-dspi: Reduce indentation level in dspi_interrupt
      spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not ours
      spi: spi-fsl-dspi: Remove impossible to reach error check
      spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing
      spi: spi-fsl-dspi: Fix race condition in TCFQ/EOQ interrupt
      spi: Use an abbreviated pointer to ctlr->cur_msg in __spi_pump_messag=
es

YueHaibing (37):
      spi: altera: use devm_platform_ioremap_resource() to simplify code
      spi: a3700: use devm_platform_ioremap_resource() to simplify code
      spi: ath79: use devm_platform_ioremap_resource() to simplify code
      spi: spi-axi: use devm_platform_ioremap_resource() to simplify code
      spi: bcm2835aux: use devm_platform_ioremap_resource() to simplify code
      spi: bcm2835: use devm_platform_ioremap_resource() to simplify code
      spi: bcm63xx-hsspi: use devm_platform_ioremap_resource() to simplify =
code
      spi: cadence: use devm_platform_ioremap_resource() to simplify code
      spi: octeon: use devm_platform_ioremap_resource() to simplify code
      spi: clps711x: use devm_platform_ioremap_resource() to simplify code
      spi: coldfire-qspi: use devm_platform_ioremap_resource() to simplify =
code
      spi: dw-mmio: use devm_platform_ioremap_resource() to simplify code
      spi: spi-geni-qcom: use devm_platform_ioremap_resource() to simplify =
code
      spi: lp-8841: use devm_platform_ioremap_resource() to simplify code
      spi: meson-spicc: use devm_platform_ioremap_resource() to simplify co=
de
      spi: spi-meson-spifc: use devm_platform_ioremap_resource() to simplif=
y code
      spi: mt7621: use devm_platform_ioremap_resource() to simplify code
      spi: mxs: use devm_platform_ioremap_resource() to simplify code
      spi: npcm: use devm_platform_ioremap_resource() to simplify code
      spi: nuc900: use devm_platform_ioremap_resource() to simplify code
      spi: oc-tiny: use devm_platform_ioremap_resource() to simplify code
      spi: pic32-sqi: use devm_platform_ioremap_resource() to simplify code
      spi: spi-qcom-qspi: use devm_platform_ioremap_resource() to simplify =
code
      spi: rb4xx: use devm_platform_ioremap_resource() to simplify code
      spi: s3c24xx: use devm_platform_ioremap_resource() to simplify code
      spi: sifive: use devm_platform_ioremap_resource() to simplify code
      spi: sirf: use devm_platform_ioremap_resource() to simplify code
      spi: st-ssc4: use devm_platform_ioremap_resource() to simplify code
      spi: sun4i: use devm_platform_ioremap_resource() to simplify code
      spi: sun6i: use devm_platform_ioremap_resource() to simplify code
      spi: tegra: use devm_platform_ioremap_resource() to simplify code
      spi: uniphier: use devm_platform_ioremap_resource() to simplify code
      spi: xlp: use devm_platform_ioremap_resource() to simplify code
      spi: zynqmp: use devm_platform_ioremap_resource() to simplify code
      spi: zynq-qspi: use devm_platform_ioremap_resource() to simplify code
      spi: fsl-spi: use devm_platform_ioremap_resource() to simplify code
      spi: npcm-fiu: remove set but not used variable 'retlen'

luhua.xu (3):
      dt-bindings: spi: update bindings for MT6765 SoC
      spi: mediatek: add spi support for mt6765 IC
      spi: mediatek: support large PA

 .../devicetree/bindings/spi/nuvoton,npcm-fiu.txt   |  47 ++
 .../devicetree/bindings/spi/spi-controller.yaml    |   2 +-
 .../devicetree/bindings/spi/spi-fsl-qspi.txt       |   9 +-
 .../devicetree/bindings/spi/spi-mt65xx.txt         |   1 +
 .../devicetree/bindings/spi/spi-sprd-adi.txt       |  11 +-
 arch/arm/mach-ep93xx/edb93xx.c                     |   2 +-
 arch/arm/mach-ep93xx/simone.c                      |   2 +-
 arch/arm/mach-ep93xx/ts72xx.c                      |   4 +-
 arch/arm/mach-ep93xx/vision_ep9307.c               |   2 +-
 drivers/dma/bcm2835-dma.c                          |  38 +-
 drivers/platform/chrome/cros_ec_spi.c              |   2 +-
 drivers/spi/Kconfig                                |  10 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/atmel-quadspi.c                        |   1 -
 drivers/spi/spi-altera.c                           |   4 +-
 drivers/spi/spi-armada-3700.c                      |   5 +-
 drivers/spi/spi-ath79.c                            |   4 +-
 drivers/spi/spi-atmel.c                            |   5 +
 drivers/spi/spi-axi-spi-engine.c                   |   4 +-
 drivers/spi/spi-bcm-qspi.c                         |   5 +-
 drivers/spi/spi-bcm2835.c                          | 470 ++++++++++---
 drivers/spi/spi-bcm2835aux.c                       |   5 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |   8 +-
 drivers/spi/spi-bcm63xx.c                          |   4 +-
 drivers/spi/spi-cadence.c                          |   5 +-
 drivers/spi/spi-cavium-octeon.c                    |   4 +-
 drivers/spi/spi-clps711x.c                         |   4 +-
 drivers/spi/spi-coldfire-qspi.c                    |   4 +-
 drivers/spi/spi-dw-mmio.c                          |  18 +-
 drivers/spi/spi-dw-pci.c                           |  20 +-
 drivers/spi/spi-efm32.c                            |   4 +-
 drivers/spi/spi-ep93xx.c                           |   4 +-
 drivers/spi/spi-fsl-cpm.c                          |   6 +-
 drivers/spi/spi-fsl-dspi.c                         | 718 +++++++++--------=
--
 drivers/spi/spi-fsl-lib.h                          |   3 -
 drivers/spi/spi-fsl-qspi.c                         |   4 +-
 drivers/spi/spi-fsl-spi.c                          | 193 +-----
 drivers/spi/spi-geni-qcom.c                        |   8 +-
 drivers/spi/spi-gpio.c                             |   5 +-
 drivers/spi/spi-lantiq-ssc.c                       |  12 +-
 drivers/spi/spi-lp8841-rtc.c                       |   4 +-
 drivers/spi/spi-meson-spicc.c                      |   4 +-
 drivers/spi/spi-meson-spifc.c                      |   4 +-
 drivers/spi/spi-mt65xx.c                           |  54 +-
 drivers/spi/spi-mt7621.c                           |   4 +-
 drivers/spi/spi-mxs.c                              |   4 +-
 drivers/spi/spi-npcm-fiu.c                         | 769 +++++++++++++++++=
++++
 drivers/spi/spi-npcm-pspi.c                        |   5 +-
 drivers/spi/spi-nuc900.c                           |   5 +-
 drivers/spi/spi-nxp-fspi.c                         |   4 +-
 drivers/spi/spi-oc-tiny.c                          |   4 +-
 drivers/spi/spi-pic32-sqi.c                        |   5 +-
 drivers/spi/spi-pic32.c                            |  12 +-
 drivers/spi/spi-qcom-qspi.c                        |   8 +-
 drivers/spi/spi-rb4xx.c                            |   4 +-
 drivers/spi/spi-s3c24xx.c                          |   5 +-
 drivers/spi/spi-sh-msiof.c                         |   5 +-
 drivers/spi/spi-sh.c                               |   4 +-
 drivers/spi/spi-sifive.c                           |   5 +-
 drivers/spi/spi-sirf.c                             |   4 +-
 drivers/spi/spi-slave-mt27xx.c                     |   1 -
 drivers/spi/spi-sprd-adi.c                         |  92 ++-
 drivers/spi/spi-sprd.c                             |   4 +-
 drivers/spi/spi-st-ssc4.c                          |   4 +-
 drivers/spi/spi-stm32-qspi.c                       |   5 +-
 drivers/spi/spi-sun4i.c                            |   5 +-
 drivers/spi/spi-sun6i.c                            |   5 +-
 drivers/spi/spi-synquacer.c                        |   2 -
 drivers/spi/spi-tegra20-sflash.c                   |   4 +-
 drivers/spi/spi-ti-qspi.c                          |   1 -
 drivers/spi/spi-uniphier.c                         |  90 ++-
 drivers/spi/spi-xlp.c                              |   8 +-
 drivers/spi/spi-zynq-qspi.c                        |   7 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |   5 +-
 drivers/spi/spi.c                                  |  53 +-
 75 files changed, 1952 insertions(+), 905 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.=
txt
 create mode 100644 drivers/spi/spi-npcm-fiu.c

--SvyA5ywaG/v2A5dH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1+xrIACgkQJNaLcl1U
h9DfFgf+KX9ERmJapngphdT7CpMsWEzio4wXBqJNVGiQdBE2qU79i4FOPTNo5i1K
czM3Aj/GHmnArvAt+8+s/H0bhq1ruh0YbUnKs16OnoG+Cg9AsxZ67ZyVPiprgpAx
sIlAu1X/9CUQ8Txac6SU7mm/Q10nETS1YvYRoHu0h5ga3X10BGqlQ8knEJeH8dyw
IIrJaHvUhuFmkm8all8NYRyNwfw1UeWoE53xC7iOQ9Eo6rGUI8G/wH0ckseujonY
6QSLWtPHFQKy0nD8iTne+PDE9YcEvCQVqCuN+iDN9d+xU/NI+s1fms7YdwRa542n
exz2SpqaHOgWdD9fH8La70Wf/O0JTA==
=Sgni
-----END PGP SIGNATURE-----

--SvyA5ywaG/v2A5dH--
