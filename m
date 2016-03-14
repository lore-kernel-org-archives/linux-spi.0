From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi updates for v4.6
Date: Mon, 14 Mar 2016 18:11:28 +0000
Message-ID: <20160314181128.GD2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3ee20abb063acc57a45ccb2fdab2eb3ce29e85fa:

  Merge remote-tracking branch 'spi/fix/rockchip' into spi-linus (2016-03-10 10:42:24 +0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.6

for you to fetch changes up to c508709bcffb644afbf5e5016fc7c90bf80c30ff:

  Merge remote-tracking branches 'spi/topic/res', 'spi/topic/rockchip', 'spi/topic/sh', 'spi/topic/ti-qspi' and 'spi/topic/xilinx' into spi-next (2016-03-11 14:28:53 +0700)

----------------------------------------------------------------
spi: Updates for v4.6

Not the biggest set of changes for SPI but a bit of a pickup in activity
on the core:

 - Support for memory mapped read from flash devices via a SPI
   controller.
 - The beginnings of a message rewriting framework in the core which
   should in time allow us to support transforming messages to work
   around the limits of controllers or optimise the performance for
   controllers transparently to calling drivers.
 - Updates to the PXA2xx, the main functional change being to improve
   the ACPI support.
 - A new driver for the Analog Devices AXI SPI engine.

----------------------------------------------------------------

There's also a driver for the SPI controller used for the RTC on
LP8841 systems which I missed when writing the tag.

Alexander Kochetkov (1):
      spi/rockchip: fix endian mode for 16-bit transfers

Andy Shevchenko (3):
      spi: dw-mid: switch to new dmaengine_terminate_* API
      spi: dw-mmio: remove message which is handled by core
      spi: respect the maximum segment size of DMA device

Anton Bondarenko (2):
      spi: imx: replace fixed timeout with calculated
      spi: imx: add support for all SPI word width for DMA

Arnd Bergmann (1):
      spi: lp-8841: return correct error code from probe

Axel Lin (2):
      spi: bcm2835: Remove duplicate depend on GPIOLIB in Kconfig
      spi: bcm2835: Remove unnecessary workaround to call gpio_set_value

Dan Carpenter (1):
      spi: checking for NULL instead of IS_ERR

Fabio Estevam (3):
      spi: core: Staticize __spi_split_transfer_maxsize()
      spi: core: Use %zu for printing 'size_t' type
      spi: core: Use min_t(size_t,..)

Geert Uytterhoeven (1):
      spi: Allow compile test of bcm2835aux if !GPIOLIB

Huibin Hong (1):
      spi/rockchip: Make sure spi clk is on in rockchip_spi_set_cs

Jarkko Nikula (8):
      spi: pxa2xx: Remove CONFIG_SPI_PXA2XX_DMA
      spi: pxa2xx: Print actual DMA/PIO transfer mode in debug messages
      spi: pxa2xx: Update comment in int_transfer_complete()
      spi: pxa2xx: Fix too early chipselect deassert
      spi: pl022: Remove obsolete struct pl022 members from kerneldoc
      spi: pxa2xx: Remove unused DMA buffer mappings
      spi: pxa2xx: Add support for Intel Broxton B-Step
      spi: pxa2xx: Use newer more explicit DMAengine terminate API

Javier Martinez Canillas (2):
      spi: Fix htmldocs build error due struct spi_replaced_transfers
      spi: Add gfp parameter to kernel-doc to fix build warning

Jon Hunter (1):
      spi: core: Fix deadlock when sending messages

Lars-Peter Clausen (2):
      spi: axi: Add bindings documentation for Analog Devices axi-spi-engine
      spi: Add Analog Devices AXI SPI Engine controller support

Leif Liddy (1):
      spi: spi-pxa2xx-pci: Add ID and driver type for WildcatPoint PCH

Mark Brown (13):
      spi: Fix sorting in Kconfig
      Merge branch 'topic/acpi' of git://git.kernel.org/.../broonie/spi into spi-pxa2xx
      Merge tag 'spi-fix-v4.5-rc4' into spi-imx
      spi: Add cond_resched() in main message processing loop
      Merge remote-tracking branch 'spi/fix/imx' into spi-imx
      Merge tag 'spi-fix-v4.5-rc7' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branch 'spi/topic/dma' into spi-next
      Merge remote-tracking branch 'spi/topic/imx' into spi-next
      Merge remote-tracking branches 'spi/topic/acpi', 'spi/topic/axi-engine', 'spi/topic/bcm2835' and 'spi/topic/bcm2835aux' into spi-next
      Merge remote-tracking branches 'spi/topic/doc', 'spi/topic/dw' and 'spi/topic/flash' into spi-next
      Merge remote-tracking branches 'spi/topic/lp8841', 'spi/topic/msg', 'spi/topic/pl022' and 'spi/topic/pxa2xx' into spi-next
      Merge remote-tracking branches 'spi/topic/res', 'spi/topic/rockchip', 'spi/topic/sh', 'spi/topic/ti-qspi' and 'spi/topic/xilinx' into spi-next

Martin Sperl (5):
      spi: core: added spi_resource management
      spi: core: add spi_replace_transfers method
      spi: core: add spi_split_transfers_maxsize
      spi: docbook: fix parsing error
      spi: docbook: add missing parameter documentation

Masanari Iida (1):
      spi: make xmldocs warning caused by spi.c

Mika Westerberg (4):
      spi: Let drivers translate ACPI DeviceSelection to suitable Linux chip select
      spi: pxa2xx: Translate ACPI DeviceSelection to Linux chip select on Baytrail
      spi: pxa2xx: Move chip select control bits into lpss_config structure
      spi: pxa2xx: Add support for both chip selects on Intel Braswell

Randy Dunlap (1):
      spi: Document max_transfer_size

Sascha Hauer (9):
      spi: imx: use proper dev_* functions for driver messages
      spi: imx: drop fallback to PIO
      spi: imx: initialize usedma earlier
      spi: imx: drop unnecessary read/modify/write
      spi: imx: drop unncessary dma_is_inited variable
      spi: imx: remove unnecessary bit clearing in mx51_ecspi_config
      spi: imx: make some register defines simpler
      spi: imx: set MX51_ECSPI_CTRL_SMC bit in setup function
      spi: imx: drop bogus tests for rx/tx bufs in DMA transfer

Sergei Ianovich (1):
      spi: master driver to enable RTC on ICPDAS LP-8841

Shawn Lin (6):
      spi: rockchip: remove xfer_completion from rockchip_spi
      spi: rockchip: check return value of dmaengine_prep_slave_sg
      spi: rockchip: migrate to dmaengine_terminate_async
      spi: rockchip: check requesting dma channel with EPROBE_DEFER
      spi: rockchip: header file cleanup
      spi: rockchip: covert rsd_nsecs to u32 type

Shubhrajyoti Datta (1):
      spi: xilinx: Add devicetree binding for spi-xilinx

Simon Horman (1):
      spi: sh-spi, sh-msiof, rspi: Use ARCH_RENESAS

Stephan Olbrich (3):
      spi: bcm2835aux: disable tx fifo empty irq
      spi: bcm2835aux: set up spi-mode before asserting cs-gpio
      spi: bcm2835aux: fix CPOL/CPHA setting

Vignesh R (2):
      spi: introduce accelerated read support for spi flash devices
      spi: spi-ti-qspi: add mmap mode read support

Xu Jianqun (1):
      spi: rockchip: add bindings for rk3399 spi

 .../devicetree/bindings/spi/adi,axi-spi-engine.txt |  31 ++
 .../bindings/spi/icpdas-lp8841-spi-rtc.txt         |  54 ++
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 .../devicetree/bindings/spi/spi-xilinx.txt         |  22 +
 drivers/spi/Kconfig                                |  96 ++--
 drivers/spi/Makefile                               |   5 +-
 drivers/spi/spi-axi-spi-engine.c                   | 591 +++++++++++++++++++++
 drivers/spi/spi-bcm2835.c                          |   5 -
 drivers/spi/spi-bcm2835aux.c                       |  72 ++-
 drivers/spi/spi-dw-mid.c                           |   4 +-
 drivers/spi/spi-dw-mmio.c                          |   5 -
 drivers/spi/spi-imx.c                              | 341 ++++++------
 drivers/spi/spi-lp8841-rtc.c                       | 256 +++++++++
 drivers/spi/spi-pl022.c                            |   7 -
 drivers/spi/spi-pxa2xx-dma.c                       |   8 +-
 drivers/spi/spi-pxa2xx-pci.c                       |  13 +
 drivers/spi/spi-pxa2xx.c                           | 151 ++++--
 drivers/spi/spi-pxa2xx.h                           |  37 --
 drivers/spi/spi-rockchip.c                         |  56 +-
 drivers/spi/spi-ti-qspi.c                          | 139 ++++-
 drivers/spi/spi.c                                  | 426 ++++++++++++++-
 include/linux/pxa2xx_ssp.h                         |   1 +
 include/linux/spi/spi.h                            | 145 +++++
 23 files changed, 2080 insertions(+), 386 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt
 create mode 100644 Documentation/devicetree/bindings/spi/icpdas-lp8841-spi-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.txt
 create mode 100644 drivers/spi/spi-axi-spi-engine.c
 create mode 100644 drivers/spi/spi-lp8841-rtc.c

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW5v7OAAoJECTWi3JdVIfQc9UH/3piShP5y2fHfx6t7U2ackPK
7me5vuw/yVT/2O+jN7lqCfA27w2JvsPdw8QevH4OsqZg5DZSLdTZVZuW0JxWz8wu
z2gbH3/3Uf4KRpU/qj8ORkUqvnLWet1EOBJCBPH9h0EZKxdVSJm1YZWSqTezPnG+
EeK40NnmT+dnpiQTe/tFAj0RHtKcppnJdAHUerPyCOCsHdrWNyPE9kLGEiyyxcoP
WTBTwwAaGEf3TPDQQ6BSGLPV9EKZRBPULpWh43kplNIrs+y0LNFXbPVojaYpBhZr
qvgY6CAUpXzQgVvuEk7R8hHVrQMBISn4K4t202irxyMktkb3tkfDwuCOoKNoDxA=
=UFv4
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
