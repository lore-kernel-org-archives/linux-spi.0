From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v4.8
Date: Wed, 27 Jul 2016 18:58:07 +0100
Message-ID: <20160727175807.GO11806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 523d939ef98fd712632d93a5a2b588e477a7565e:

  Linux 4.7 (2016-07-24 12:23:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.8

for you to fetch changes up to dec34e8b676e14d4df041e3335d6082b247b834e:

  Merge remote-tracking branch 'spi/fix/locking' into spi-next (2016-07-25 11:48:51 +0100)

----------------------------------------------------------------
spi: Updates for v4.8

Quite a lot of cleanup and maintainence work going on this release in
various drivers, and also a fix for a nasty locking issue in the core:

 - A fix for locking issues when external drivers explicitly locked the
   bus with spi_bus_lock() - we were using the same lock to both control
   access to the physical bus in multi-threaded I/O operations and
   exclude multiple callers.  Confusion between these two caused us to
   have scenarios where we were dropping locks.  These are fixed by
   splitting into two separate locks like should have been done
   originally, making everything much clearer and correct.
 - Support for DMA in spi_flash_read().
 - Support for instantiating spidev on ACPI systems, including some test
   devices used in Windows validation.
 - Use of the core DMA mapping functionality in the McSPI driver.
 - Start of support for ThunderX SPI controllers, involving a very big
   set of changes to the Cavium driver.
 - Support for Braswell, Exynos 5433, Kaby Lake, Merrifield, RK3036,
   RK3228, RK3368 controllers.

----------------------------------------------------------------
Alexander Shiyan (5):
      spi: imx: Using existing properties for chipselects
      spi: imx: Remove unnecessary field "mode" from struct spi_imx_config
      spi: imx: Remove "maybe_unused" attributes
      spi: imx: Update DT binding documentation
      spi: clps711x: Driver refactor

Andi Shyti (11):
      spi: s3c64xx: group the CS signalling writes in a single function
      spi: s3c64xx: consider the case when the CS line is not connected
      spi: s3c64xx: do not configure the device twice
      spi: s3c64xx: simplify if statement in prepare_transfer function
      spi: s3c64xx: do not disable the clock while configuring the spi
      spi: s3c64xx: add exynos5433 spi compatible
      spi: s3c64xx: document the clocks and the clock-name property
      spi: s3c64xx: rename goto labels to meaningful names
      spi: s3c64xx: use error code from clk_prepare_enable()
      spi: s3c64xx: add Exynos5433 compatible for ioclk handling
      spi: s3c64xx: restore removed comments

Andy Shevchenko (6):
      spi: pxa2xx-pci: Do a specific setup in a separate function
      spi: pxa2xx-pci: Enable SPI on Intel Merrifield
      spi: pxa2xx-pci: Remove unused code
      spi: pxa2xx-pci: Sort header block alphabetically
      spi: pxa2xx: Clear all RFT bits in reset_sccr1() on Intel Quark
      spi: pxa2xx-pci: Support both chipselects on Braswell

Arnd Bergmann (1):
      spi: add binding for clps711x SPI

Bhaktipriya Shridhar (6):
      spi: spi-bfin5xx: Remove deprecated create_singlethread_workqueue
      spi: spi-txx9: Remove deprecated create_singlethread_workqueue
      spi: spi-mpc52xx-psc: Remove deprecated create_singlethread_workqueue
      spi: spi-bfin-sport: Remove deprecated create_singlethread_workqueue
      spi: spi-topcliff-pch: Remove deprecated create_singlethread_workqueue
      spi: spi-sh: Remove deprecated create_singlethread_workqueue

Brian Norris (1):
      spi: rockchip: limit transfers to (64K - 1) bytes

Caesar Wang (2):
      spi/rockchip: add rk3036/rk3228/rk3368 SoCs for spi document
      spi/rockchip: add the rk3036/rk3228/rk3368 to match for driver

Christian Gmeiner (1):
      spi: imx: wait_for_completion_timeout(..) for PIO transfers

Colin Ian King (2):
      spi: ti-qspi: spelling mistake: "trasnfers" -> "transfers"
      spi: loopback-test: fix spelling mistake: "missmatch" -> "mismatch"

Dan Carpenter (1):
      spi: s3c64xx: indent an if statement

Dan O'Donovan (1):
      spi: pxa2xx: use DMA by default if supported

Franklin S Cooper Jr (3):
      spi: omap2-mcspi: Add comments for RX only DMA buffer workaround
      spi: omap2-mcspi: Select SPI_SPLIT
      spi: omap2-mcspi: Use the SPI framework to handle DMA mapping

Geert Uytterhoeven (3):
      spi: Add file patterns for spi device tree bindings
      spi: Improve DT binding documentation
      spi: sh-msiof: Remove sh_msiof_spi_priv.chipdata

Jan Glauber (4):
      spi: octeon: Store system clock freqency in struct octeon_spi
      spi: octeon: Put register offsets into a struct
      spi: octeon: Move include file from arch/mips to drivers/spi
      spi: octeon: Split driver into Octeon specific and common parts

Jarkko Nikula (2):
      spi: pxa2xx: Use local struct spi_master pointer in pump_transfers()
      spi: pxa2xx: Switch to SPI core DMA mapping functionality

Lars-Peter Clausen (2):
      spi: xilinx: Handle errors from platform_get_irq()
      spi: xilinx: Return IRQ_NONE if no interrupts were detected

Mark Brown (9):
      Merge remote-tracking branches 'spi/fix/pax2xx' and 'spi/fix/rockchip' into spi-linus
      Merge remote-tracking branches 'spi/topic/bfin-sport', 'spi/topic/bfin5xx', 'spi/topic/clps711x', 'spi/topic/doc' and 'spi/topic/dt' into spi-next
      Merge remote-tracking branches 'spi/topic/flash-dma', 'spi/topic/imx', 'spi/topic/loopback', 'spi/topic/maintainers' and 'spi/topic/mpc52xx-psc' into spi-next
      Merge remote-tracking branches 'spi/topic/octeon', 'spi/topic/omap2-mcspi', 'spi/topic/orion', 'spi/topic/pic32' and 'spi/topic/pic32-sqi' into spi-next
      Merge remote-tracking branches 'spi/topic/pxa2xx', 'spi/topic/rockchip', 'spi/topic/s3c64xx', 'spi/topic/sh' and 'spi/topic/sh-msiof' into spi-next
      Merge remote-tracking branches 'spi/topic/spidev', 'spi/topic/sunxi', 'spi/topic/ti-qspi', 'spi/topic/topcliff-pch' and 'spi/topic/txx9' into spi-next
      Merge remote-tracking branch 'spi/topic/xilinx' into spi-next
      spi: Split bus and I/O locking
      Merge remote-tracking branch 'spi/fix/locking' into spi-next

Masanari Iida (1):
      spi: Fix typo in devicetree/bindings/spi

Michal Suchanek (2):
      spi: sunxi: expose maximum transfer size limit
      spi: sunxi: set maximum and minimum speed of SPI master

Mika Westerberg (2):
      spi: pxa2xx: Add support for Intel Kaby Lake PCH-H
      spi: spidev: Add ACPI probing support

Nicholas Mc Guire (2):
      spi: pic32: fixup wait_for_completion_timeout return handling
      spi: pic32-sqi: fixup wait_for_completion_timeout return handling

Stefan Roese (1):
      spi: orion: Add direct access mode

Steven J. Hill (1):
      spi: octeon: Convert driver to use readq()/writeq() functions

Vignesh R (1):
      spi: Add DMA support for spi_flash_read()

Wei Yongjun (2):
      spi: orion: Fix return value check in orion_spi_probe()
      spi: s3c64xx: fix reference leak to master in s3c64xx_spi_remove()

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   5 +-
 Documentation/devicetree/bindings/spi/spi-bus.txt  |  35 +--
 .../devicetree/bindings/spi/spi-clps711x.txt       |  33 +++
 .../devicetree/bindings/spi/spi-davinci.txt        |   2 +-
 .../devicetree/bindings/spi/spi-orion.txt          |  49 +++-
 .../devicetree/bindings/spi/spi-rockchip.txt       |  11 +-
 .../devicetree/bindings/spi/spi-samsung.txt        |  15 +-
 Documentation/devicetree/bindings/spi/ti_qspi.txt  |   2 +-
 MAINTAINERS                                        |   1 +
 drivers/spi/Kconfig                                |   1 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-bfin-sport.c                       |  15 +-
 drivers/spi/spi-bfin5xx.c                          |  15 +-
 drivers/spi/spi-cavium-octeon.c                    | 104 +++++++++
 drivers/spi/spi-cavium.c                           | 151 ++++++++++++
 .../cvmx-mpi-defs.h => drivers/spi/spi-cavium.h    |  59 ++---
 drivers/spi/spi-clps711x.c                         |  69 +++---
 drivers/spi/spi-imx.c                              | 191 ++++++++-------
 drivers/spi/spi-loopback-test.c                    |   2 +-
 drivers/spi/spi-mpc52xx-psc.c                      |  17 +-
 drivers/spi/spi-octeon.c                           | 255 ---------------------
 drivers/spi/spi-omap2-mcspi.c                      | 145 ++++++------
 drivers/spi/spi-orion.c                            |  88 +++++++
 drivers/spi/spi-pic32-sqi.c                        |   7 +-
 drivers/spi/spi-pic32.c                            |   5 +-
 drivers/spi/spi-pxa2xx-dma.c                       | 170 +++-----------
 drivers/spi/spi-pxa2xx-pci.c                       | 128 +++++++----
 drivers/spi/spi-pxa2xx.c                           |  55 +++--
 drivers/spi/spi-pxa2xx.h                           |   9 -
 drivers/spi/spi-rockchip.c                         |  20 ++
 drivers/spi/spi-s3c64xx.c                          | 206 ++++++++++-------
 drivers/spi/spi-sh-msiof.c                         |  18 +-
 drivers/spi/spi-sh.c                               |  16 +-
 drivers/spi/spi-sun4i.c                            |   8 +
 drivers/spi/spi-sun6i.c                            |   7 +
 drivers/spi/spi-ti-qspi.c                          |   2 +-
 drivers/spi/spi-topcliff-pch.c                     |  26 +--
 drivers/spi/spi-txx9.c                             |  11 +-
 drivers/spi/spi-xilinx.c                           |   8 +-
 drivers/spi/spi.c                                  |  66 ++++--
 drivers/spi/spidev.c                               |  41 ++++
 include/linux/platform_data/spi-s3c64xx.h          |   1 +
 include/linux/spi/spi.h                            |  10 +-
 43 files changed, 1140 insertions(+), 940 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-clps711x.txt
 create mode 100644 drivers/spi/spi-cavium-octeon.c
 create mode 100644 drivers/spi/spi-cavium.c
 rename arch/mips/include/asm/octeon/cvmx-mpi-defs.h => drivers/spi/spi-cavium.h (84%)
 delete mode 100644 drivers/spi/spi-octeon.c

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmPYuAAoJECTWi3JdVIfQOawH/A73ED8l3GVnRRYDQWcb/yEu
7fjD9yHnICXYnZr5uDcQz5j/5l824SWkP+FDoWw9jLQoCV2w0O+bl2sBlOKQFJNi
KqT/2Ui55q5CBkzXfZsXfp9aM7Vk/IZwpDAYMfka/hoL1nPb3noXpM6TjkNSox3n
/EqagfHIoqV/XbUgs3JtLW2+LeSWxc0TSRljngcAUAzOTxwb7A38ZKYnLz8aiAWi
WZniRuC7ddvPRz7jvndCDxeYs8+BbXZ2A0RvHRhnkVZ2zhYFBv7C9mQGWs0jFrVn
Mh8tTnVXlcnbR53cVMY/CDft05+iW2stcBag0Y78MVGRB8tYbBin737epFSCQ1E=
=C2j3
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--
