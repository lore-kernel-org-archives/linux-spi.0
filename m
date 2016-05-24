From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi updates for v4.7
Date: Tue, 24 May 2016 11:50:16 +0100
Message-ID: <20160524105016.GH8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PK5kSfjks5jzTD3m"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PK5kSfjks5jzTD3m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 2dcd0af568b0cf583645c8a317dd12e344b1c72a:

  Linux 4.6 (2016-05-15 15:43:13 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4=
=2E7

for you to fetch changes up to c4e85b7e6ff71a130710692fcb8daae5a638941f:

  Merge remote-tracking branch 'spi/topic/zynqmp' into spi-next (2016-05-23=
 12:16:58 +0100)

----------------------------------------------------------------
spi: Updates for v4.7

Another quiet release for SPI, almost entirely driver specific changes
with the diffstat dominated by two new drivers which are about two
thirds of it in terms of lines of code:

 - New drivers for PIC32 standard and SQI controllers.
 - The Cadence driver has had runtime PM support added and quite a few
   fixes and cleanups.
 - The flash-specific accelerated path support now has a feature query
   interface.
 - The pxa2xx driver has been moved to use the core DMA mapping support.

----------------------------------------------------------------
Andy Shevchenko (1):
      spi: pxa2xx: handle error of pxa2xx_spi_dma_prepare()

Arnd Bergmann (1):
      spi: cadence: mark pm functions __maybe_unused

Axel Lin (8):
      spi: octeon: Convert to use devm_ioremap_resource
      spi: pic32: Set proper bits_per_word_mask
      spi: Drop duplicate code to set master->dev.parent
      spi: pic32: Fix checking return value of devm_ioremap_resource
      spi: st-ssc4: Allow compile test build
      spi: st-ssc4: Fix missing spi_master_put in spi_st_probe error paths
      spi: Drop unnecessary dependencies on relaxed I/O accessors
      spi: pic32-sqi: Remove pic32_sqi_setup and pic32_sqi_cleanup

Bhuvanchandra DV (1):
      spi: fsl-dspi: Set max_speed_hz for master

Christophe Ricard (1):
      spi: pxa2xx: Fix cs_change management

Crestez Dan Leonard (1):
      spi: dln2: Pass of_node to spi master

Dan Carpenter (2):
      spi: pic32-sqi: silence array overflow warning
      spi: rockchip: potential NULL dereference on error

Geert Uytterhoeven (1):
      spi: dw-pci: Spelling s/paltforms/platforms/g

Heiner Kallweit (1):
      spi: core: add hook flash_read_supported to spi_master

Jarkko Nikula (2):
      spi: pxa2xx: Remove rx_/tx_map_len members from struct driver_data
      spi: pxa2xx: Use dummy buffers provided by SPI core

Kamlakant Patel (1):
      spi: xlp: Enable SPI driver for Broadcom Vulcan ARM64

Linus Walleij (1):
      spi: let SPI masters ignore their children for PM

Mark Brown (7):
      Merge tag 'v4.6-rc5' into spi-rockchip
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branches 'spi/topic/bcm53xx', 'spi/topic/cadenc=
e', 'spi/topic/davinci' and 'spi/topic/dln2' into spi-next
      Merge remote-tracking branches 'spi/topic/dw', 'spi/topic/flash-read'=
, 'spi/topic/fsl-dspi', 'spi/topic/fsl-espi' and 'spi/topic/kconfig' into s=
pi-next
      Merge remote-tracking branches 'spi/topic/octeon', 'spi/topic/omap2-m=
cspi', 'spi/topic/orion', 'spi/topic/pic32' and 'spi/topic/pic32-qspi' into=
 spi-next
      Merge remote-tracking branches 'spi/topic/pxa2xx', 'spi/topic/qup', '=
spi/topic/rockchip', 'spi/topic/st-ssc4' and 'spi/topic/xlp' into spi-next
      Merge remote-tracking branch 'spi/topic/zynqmp' into spi-next

Moritz Fischer (1):
      spi: Fix simple typo s/impelment/implement

Nobuteru Hayashi (3):
      spi/fsl-espi: Don't spin forever on SPIE_RXCNT
      spi/fsl-espi: Don't wait transaction completion forever
      spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()

Peter Ujfalusi (2):
      spi: davinci: Use dma_request_chan() for requesting DMA channel
      spi: omap2-mcspi: Use dma_request_chan() for requesting DMA channel

Pramod Gurav (2):
      spi: qup: Handle clocks in pm_runtime suspend and resume
      spi: qup: Add spi_master_put in remove function

Purna Chandra Mandal (5):
      spi: pic32: Add bindings for PIC32 SPI peripheral
      spi: spi-pic32: Add PIC32 SPI master driver
      spi: pic32-sqi: add binding document for PIC32 Quad-SPI driver.
      spi: pic32-sqi: add SPI driver for PIC32 SQI controller.
      spi: pic32-sqi: Fix linker error, undefined reference to `bad_dma_ops=
'.

Rafa=C5=82 Mi=C5=82ecki (1):
      spi: bcm53xx: add spi_flash_read callback for MMIO-based reads

Shubhrajyoti Datta (9):
      spi: cadence: Fix a check patch warning
      spi: cadence: Remove _MASK and _OFFSET suffix
      spi: cadence: Fix probe error handling
      spi: cadance: Fix the Documentation
      spi: cadence: Runtime pm adaptation
      spi: cadence: Remove the clock enable and disable from suspend and re=
sume
      spi: cadence: Return the error code for cdns_spi_suspend and cdns_spi=
_resume
      spi: cadence: Fix some checkpatch warnings
      spi: zynqmp: disable clocks in error paths

Stephen Boyd (1):
      spi: spi-pxa2xx: Remove CLK_IS_ROOT

Thomas Petazzoni (1):
      spi: spi-orion: enable the driver on ARCH_MVEBU platforms

Vignesh R (1):
      spi: return error if kmap'd buffers passed to spi_map_buf()

Yuan Yao (1):
      spi: spi-fsl-dspi: Update DT binding documentation

 .../bindings/spi/microchip,spi-pic32.txt           |  34 +
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |   3 +-
 .../devicetree/bindings/spi/sqi-pic32.txt          |  18 +
 drivers/spi/Kconfig                                |  21 +-
 drivers/spi/Makefile                               |   2 +
 drivers/spi/spi-axi-spi-engine.c                   |   1 -
 drivers/spi/spi-bcm53xx.c                          |  78 +-
 drivers/spi/spi-cadence.c                          | 244 +++---
 drivers/spi/spi-davinci.c                          |  76 +-
 drivers/spi/spi-dln2.c                             |   2 +
 drivers/spi/spi-dw-pci.c                           |   2 +-
 drivers/spi/spi-fsl-dspi.c                         |   7 +
 drivers/spi/spi-fsl-espi.c                         |  30 +-
 drivers/spi/spi-octeon.c                           |  17 +-
 drivers/spi/spi-omap2-mcspi.c                      |  83 +-
 drivers/spi/spi-pic32-sqi.c                        | 727 +++++++++++++++++
 drivers/spi/spi-pic32.c                            | 878 +++++++++++++++++=
++++
 drivers/spi/spi-pxa2xx-dma.c                       |  28 +-
 drivers/spi/spi-pxa2xx-pci.c                       |   4 +-
 drivers/spi/spi-pxa2xx.c                           |  15 +-
 drivers/spi/spi-pxa2xx.h                           |   3 -
 drivers/spi/spi-qup.c                              |  15 +
 drivers/spi/spi-rockchip.c                         |   9 +-
 drivers/spi/spi-st-ssc4.c                          |   8 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |   3 +-
 drivers/spi/spi.c                                  |   7 +-
 include/linux/spi/spi.h                            |   6 +-
 27 files changed, 2033 insertions(+), 288 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic=
32.txt
 create mode 100644 Documentation/devicetree/bindings/spi/sqi-pic32.txt
 create mode 100644 drivers/spi/spi-pic32-sqi.c
 create mode 100644 drivers/spi/spi-pic32.c

--PK5kSfjks5jzTD3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRDHnAAoJECTWi3JdVIfQKjIH/07NwIEyuCJN0NCUT8Mc/qBF
LmLVZsQTKFaMwT0BACO61JEd9HhWz9sCqE+XBEz5gvTSX0Lsyicc+Ju9t33Ueb84
ZVybe7AekDKAlCZ+hnbDUKXvumQhvMqORbgr0wOPJvvgkiAajN2kIWDKoaBdmm9X
tG+3IlRmmT9zTaabTkXElQGnYsNPMi7ICyq30vlbWPN0qd+t8KSFX8w0vdsxE/Sb
opK+Cgu80Kyq11A+RgzcDanNh9VZFauqxbU7Tz81aKxMSGf51NBUo6rt+OXBMOoP
Ko8O15W3nXZ476TsklTmEzOuMjQ4IRRV++utLD1w5b7tUWwEbgLqrOp/beJbcvk=
=xTuf
-----END PGP SIGNATURE-----

--PK5kSfjks5jzTD3m--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
