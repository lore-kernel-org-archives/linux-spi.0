From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] spi updates for v4.10
Date: Tue, 13 Dec 2016 17:41:15 +0000
Message-ID: <20161213174115.zckzjtybwvtvzwpc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5uzijtsrwzhwafr"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--r5uzijtsrwzhwafr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 69973b830859bc6529a7a0468ba0d80ee5117826:

  Linux 4.9 (2016-12-11 11:17:54 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4=
=2E10

for you to fetch changes up to fafd67940774733fa97f4b09412aea6981b82e0a:

  Merge remote-tracking branches 'spi/topic/spidev', 'spi/topic/sunxi', 'sp=
i/topic/ti-qspi', 'spi/topic/topcliff-pch' and 'spi/topic/xlp' into spi-nex=
t (2016-12-12 15:54:20 +0000)

----------------------------------------------------------------
spi: Updates for v4.10

The nicest things about this release for me is seeing some older drivers
getting some cleanups and modernization, it's really good to see things
moving forwards even for older drivers.  In content terms it's a fairly
humdrum release but where the work has been happening is great.

 - Support for simultaneous use of internal and GPIO chip selects for
   devices that require the use of the internal select even if it's not
   connected and a GPIO is actually routed to the slave device.
 - A major rework and cleanup of the fsl-espi driver from Heiner
   Kallweit which should make it work substantially better.
 - DMA support for Freescale DSPI IPs.
 - New drivers for Freescale LPSPI IPs and Marvell Armada 3700.
 - Support for Allwinner H3.

----------------------------------------------------------------
Alexandru Gagniuc (1):
      spi: sun4i: Allow transfers larger than FIFO size

Arnd Bergmann (1):
      spi: rspi: avoid uninitialized variable access

Ben Whitten (1):
      spi: atmel: Fix scheduling while atomic

Christophe JAILLET (1):
      spi: spi-topcliff-pch: Remove some dead code

Cyrille Pitchen (1):
      spi: atmel: Use SPI core DMA mapping framework

Dan Carpenter (1):
      spi: atmel: fix indenting in atmel_spi_gpio_cs()

Daniel Kurtz (1):
      spi: change post transfer udelay() to usleep_range() for long delays

Fabien Lahoudere (1):
      spi: spidev: Add device to spidev device tree compatibility list

Gao Pan (9):
      spi: imx: add lpspi bus driver
      spi: imx: add devicetree binding for lpspi
      spi: imx: use prepare_transfer_hardware() for lpspi
      spi: imx: fix potential shift truncation
      spi: imx: replace schedule() with cond_resched()
      spi: fsl-lpspi: use wait_for_completion_timeout() while waiting trans=
fer done
      spi: fsl-lpspi: read lpspi tx/rx fifo size in probe()
      spi: fsl-lpspi: use GPL as module license
      spi: fsl-lpspi: quit reading rx fifo under error condition

Geert Uytterhoeven (1):
      spi: sh-msiof: Add support for R-Car M3-W

Heiner Kallweit (33):
      spi: fsl-espi: replace of_get_property with of_property_read_u32
      spi: fsl-espi: reject MSB-first transfers with word sizes other than =
8 or 16
      spi: fsl-espi: fix handling of word sizes other than 8 bit
      spi: fsl-espi: fix merge conflict for commit "avoid processing uninit=
alized data on error"
      spi: fsl-espi: improve check for SPI_QE_CPU_MODE
      spi: fsl-espi: fix and improve writing to TX FIFO
      spi: fsl-espi: Rename len in struct mpc8xxx_spi to rx_len and make it=
 unsigned
      spi: fsl-espi: simplify and inline function fsl_espi_change_mode
      spi: fsl-espi: extend and improve transfer error handling
      spi: fsl-espi: make better use of the RX FIFO
      spi: fsl-espi: fix and improve reading from RX FIFO
      spi: fsl-espi: small fix to error path in fsl_espi_irq
      spi: fsl-espi: remove unneeded call to fsl_espi_setup_transfer
      spi: fsl-espi: don't write ESPI_SPMODE register if the mode doesn't c=
hange
      spi: fsl-espi: add support for ESPI RXSKIP mode
      spi: fsl-espi: add support for dual output read mode
      spi: fsl-espi: remove usage of pdata->initial_spmode
      spi: fsl-espi: don't set pdata->cs_control
      spi: fsl-espi: remove remaining usage of struct fsl_spi_platform_data
      spi: fsl-espi: remove usage of mpc8xxx_spi->flags
      spi: fsl-espi: remove usage of mpc8xxx_spi->irq
      spi: fsl-espi: migrate relevant parts of mpc8xxx_spi_probe and of_mpc=
8xxx_spi_probe
      spi: fsl-espi: introduce struct fsl_espi_cs
      spi: fsl-espi: factor out fsl_espi_init_regs
      spi: fsl-espi: introduce struct fsl_espi
      spi: fsl-espi: separate fsl-espi from fsl-lib completely
      spi: fsl-espi: simplify of_fsl_espi_suspend
      spi: fsl-espi: set spi_master members min_speed_hz and max_speed_hz
      spi: fsl-espi: determine need for byte swap only once
      spi: fsl-espi: eliminate need for linearization when writing to hardw=
are
      spi: fsl-espi: eliminate need for linearization when reading from har=
dware
      spi: fsl-espi: remove unused linearization code
      spi: fsl-espi: fix ioread16/iowrite16 endianness

Hiep Cao Minh (1):
      spi: rspi: supports 32bytes buffer for DUAL and QUAD

Jarkko Nikula (1):
      spi: spi-pxa2xx: Remove unused macro

Javier Martinez Canillas (5):
      spi: s3c64xx: Allow driver to build if COMPILE_TEST is enabled
      spi: spi-axi: Fix module autoload
      spi: jcore: Fix module autoload for OF registration
      spi: xlp: Fix module autoload for OF registration
      spi: ath79: Fix module autoload for OF registration

Juan Gutierrez (1):
      spi: use sg_next for walking through the allocated scatterlist table

Mark Brown (10):
      Merge branch 'fix/fsl-espi' of git://git.kernel.org/.../broonie/spi i=
nto spi-fsl-espi
      Merge remote-tracking branches 'spi/fix/atmel', 'spi/fix/mvbeu' and '=
spi/fix/spidev' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branch 'spi/topic/dma' into spi-next
      Merge remote-tracking branch 'spi/topic/rcar' into spi-next
      Merge remote-tracking branches 'spi/topic/armada', 'spi/topic/ath79',=
 'spi/topic/atmel' and 'spi/topic/axi' into spi-next
      Merge remote-tracking branches 'spi/topic/delay', 'spi/topic/dw', 'sp=
i/topic/fsl-dspi' and 'spi/topic/fsl-espi' into spi-next
      Merge remote-tracking branches 'spi/topic/fsl-lpspi', 'spi/topic/imx'=
, 'spi/topic/jcore' and 'spi/topic/omap' into spi-next
      Merge remote-tracking branches 'spi/topic/orion', 'spi/topic/pxa2xx',=
 'spi/topic/rspi' and 'spi/topic/s3c64xx' into spi-next
      Merge remote-tracking branches 'spi/topic/spidev', 'spi/topic/sunxi',=
 'spi/topic/ti-qspi', 'spi/topic/topcliff-pch' and 'spi/topic/xlp' into spi=
-next

Martin Kaiser (1):
      spi: imx: support DMA for imx35

Michal Vok=C3=A1=C4=8D (1):
      spi: spidev_test: Fix input file check when transferring file

Milo Kim (2):
      spi: sun6i: Add binding for Allwinner H3 SPI controller
      spi: sun6i: Support Allwinner H3 SPI controller

Nicolas Ferre (5):
      spi: atmel: use managed resource for gpio chip select
      spi: atmel: trivial: move info banner to latest probe action
      spi: atmel: Use core SPI_MASTER_MUST_[RT]X handling
      spi: atmel: trivial: remove unused fields in DMA structure
      spi: atmel: remove the use of private channel fields

Paulo Zaneti (1):
      spi: fsl-espi: fix support for all available clock rates

Prahlad V (1):
      spi: spi-ti-qspi: reinit of completion variable

Robert Baldyga (1):
      spi: imx: set spi_bus_clk for mx21 and mx27

Romain Perier (2):
      spi: armada-3700: Add documentation for the Armada 3700 SPI Controller
      spi: Add support for Armada 3700 SPI Controller

Sanchayan Maity (5):
      spi: spi-fsl-dspi: Add DMA support for Vybrid
      spi: spi-fsl-dspi: Fix SPI transfer issue when using multiple SPI_IOC=
_MESSAGE
      spi: spi-fsl-dspi: Fix incorrect freeing of DMA allocated buffers
      spi: spi-fsl-dspi: Fix incorrect DMA setup
      spi: spi-fsl-dspi: Fix continuous selection format

Thor Thayer (3):
      spi: Add Flag to Enable Slave Select with GPIO Chip Select.
      spi: dw: Set GPIO_SS flag to toggle Slave Select on GPIO CS
      spi: Add Flag to Enable Slave Select with GPIO Chip Select.

Uwe Kleine-K=C3=B6nig (2):
      spi: orion: fix comment to mention MVEBU
      spi: mvebu: fix baudrate calculation for armada variant

Vikram N (1):
      spi: omap2-mcspi: Fix modifying platform resource data

Wei Yongjun (1):
      spi: omap2-mcspi: Remove redundant return value check of platform_get=
_resource()

 Documentation/devicetree/bindings/spi/sh-msiof.txt |   1 +
 .../devicetree/bindings/spi/spi-armada-3700.txt    |  25 +
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt      |  19 +
 .../devicetree/bindings/spi/spi-sun6i.txt          |  25 +-
 drivers/spi/Kconfig                                |  19 +-
 drivers/spi/Makefile                               |   2 +
 drivers/spi/spi-armada-3700.c                      | 923 +++++++++++++++++=
++++
 drivers/spi/spi-ath79.c                            |   1 +
 drivers/spi/spi-atmel.c                            | 324 ++++----
 drivers/spi/spi-axi-spi-engine.c                   |   1 +
 drivers/spi/spi-dw.c                               |   1 +
 drivers/spi/spi-fsl-dspi.c                         | 306 ++++++-
 drivers/spi/spi-fsl-espi.c                         | 728 ++++++++--------
 drivers/spi/spi-fsl-lib.h                          |   4 -
 drivers/spi/spi-fsl-lpspi.c                        | 525 ++++++++++++
 drivers/spi/spi-imx.c                              |  35 +-
 drivers/spi/spi-jcore.c                            |   1 +
 drivers/spi/spi-omap2-mcspi.c                      |  11 +-
 drivers/spi/spi-orion.c                            |  83 +-
 drivers/spi/spi-pxa2xx.h                           |   1 -
 drivers/spi/spi-rspi.c                             |  52 +-
 drivers/spi/spi-sh-msiof.c                         |   1 +
 drivers/spi/spi-sun4i.c                            |  75 +-
 drivers/spi/spi-sun6i.c                            |  18 +-
 drivers/spi/spi-ti-qspi.c                          |   1 +
 drivers/spi/spi-topcliff-pch.c                     |  13 +-
 drivers/spi/spi-xlp.c                              |   1 +
 drivers/spi/spi.c                                  |  26 +-
 drivers/spi/spidev.c                               |   1 +
 include/linux/spi/spi.h                            |   1 +
 tools/spi/spidev_test.c                            |   2 +-
 31 files changed, 2611 insertions(+), 615 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.t=
xt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
 create mode 100644 drivers/spi/spi-armada-3700.c
 create mode 100644 drivers/spi/spi-fsl-lpspi.c

--r5uzijtsrwzhwafr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhQMrsACgkQJNaLcl1U
h9BTiAf/acAcCXgXr9/WAtdkeZ4jPAEXU0kmVSDr64g9JKBSbwCYi9Gks3fDVnQB
dSqAt2iJCjU3O9/8SaZZ+D1TvsN3tu7fwPs6U3UfhAFUDGOKrPa2QdDnkDsHRvJe
7KmxbuzQ4ntHYJ96xhmEMjrJ9NAsbYdjhJaOPDD9LUmEnagQ6qF6bKqIMeVka4Oc
qZ8Rahz8gkpakoYi6F1g26A/qxuAy/PW80JRLV85VE6Fn2IF51s04X9o5mL0Vie0
KnbHcjyq14lmRcvfbosuqeoTZEw9UCBmUdzu03aVYJjFtXRwevPKFLNQKD7/nYf6
RWK1PRh+reRj0a/03XOVrwZsQwp9Cg==
=YlPx
-----END PGP SIGNATURE-----

--r5uzijtsrwzhwafr--
