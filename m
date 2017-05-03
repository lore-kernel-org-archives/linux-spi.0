From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI updates for v4.12
Date: Thu, 4 May 2017 00:15:37 +0900
Message-ID: <20170503151537.cc4miclxpvprea4q@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xueyme4alkuvhy3o"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xueyme4alkuvhy3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5a7ad1146caa895ad718a534399e38bd2ba721b7:

  Linux 4.11-rc8 (2017-04-23 16:53:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.12

for you to fetch changes up to 282ec0ea65dab88fda51b5b9b649958ae42f4ac0:

  Merge remote-tracking branches 'spi/topic/ti-qspi' and 'spi/topic/xlp' into spi-next (2017-04-26 15:58:22 +0100)

----------------------------------------------------------------
spi: Updates for v4.12

There's quite a lot of small driver specific fixes and enhancements in
this release but the main activity has been around the loopback and
spidev test drivers which is good to see as it should hopefully help
improve the quality of all the drivers as people start to make use of
the new code:

 - Additional tests in the loopback test driver for vmalloc()
   compatibility and around delays together with fixes for existing
   tests.
 - Support for testing continuous data transfer for use in soak testing.
 - Device property support for board info platforms.
 - Support for registering empty sets of devices via board info (useful
   when writing code to enumerate hardware automatically).

----------------------------------------------------------------
Akinobu Mita (7):
      spi: loopback-test: correct mismatched test description and configuration
      spi: loopback-test: don't skip comparing the first byte of rx_buf
      spi: loopback-test: add ability to test zero-length transfer
      spi: loopback-test: test zero-length transfer
      spi: loopback-test: add elapsed time check
      spi: loopback-test: add test spi_message with delay after transfers
      spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer

Antonio Borneo (2):
      spi: pl022: remove nonexistent properties from DT binding example
      spi: pl022: Document property values

Bastian Stender (1):
      spi: orion: add LSB support

Ben Whitten (1):
      spi: spidev: Add sx1301 to device tree compatibility list

Christophe JAILLET (1):
      spi: spi-fsl-dspi: Fix error handling

Colin Ian King (3):
      spi: loopback-test: fix potential integer overflow on multiple
      spi: loopback-test: fix spelling mistake: "minimam" -> "minimum"
      spi: tegra: fix spelling mistake: "trasfer" -> "transfer"

Dmitry Torokhov (2):
      spi: allow attaching device properties to SPI board info
      spi: allow registering empty spi_board_info lists

Emiliano Ingrassia (1):
      spi: dynamycally allocated message initialization

Fabien Parent (2):
      spi: davinci: Use SPI framework to handle DMA mapping
      spi: davinci: enable DMA when channels are defined in DT

Frode Isaksen (7):
      spi: davinci: use rx buffer as dummy tx buffer
      spi: davinci: do not use DMA if transfer length is less than 16
      spi: davinci: do not use DMA for vmalloc'ed buffers
      spi: loopback-test: add option to use vmalloc'ed buffers
      spi: loopback-test: fix compile error on x86
      spi: davinci: add comment about dummy tx buffer usage
      spi: spidev_test: add option to continuously transfer data

Hauke Mehrtens (2):
      spi: lantiq-ssc: add LTQ_ prefix to defines
      spi: double time out tolerance

Icenowy Zheng (2):
      spi: sun6i: Allow transfers larger than FIFO size
      spi: sun6i: update max transfer size reported

Javier Martinez Canillas (1):
      spi: sc18is602: Add OF device ID table

Jayachandran C (1):
      spi: xlp: update for ARCH_VULCAN2

Jonas Gorski (7):
      spi/bcm63xx: make spi subsystem aware of message size limits
      spi/bcm63xx: allow for probing through devicetree
      spi/bcm63xx: document bcm63xx SPI devicetree bindings
      spi/bcm63xx: fix typo in bcm63xx_spi_max_length breaking compilation
      spi/bcm63xx-hsspi: allow providing clock rate through a second clock
      spi/bcm63xx-hsspi: document bcm63xx HS SPI devicetree bindings
      spi/bcm63xx-hsspi: allow for probing through devicetree

Leif Middelschulte (1):
      spi-imx: Implements handling of the SPI_READY mode flag.

Liu Xiang (1):
      spi: fsl: Call irq_dispose_mapping in err path

Marek Vasut (1):
      spi: dw: Disable clock after unregistering the host

Mark Brown (7):
      Merge remote-tracking branches 'spi/fix/dw', 'spi/fix/lantiq' and 'spi/fix/pl022' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branches 'spi/topic/atmel', 'spi/topic/bcm63xx', 'spi/topic/cadence' and 'spi/topic/davinci' into spi-next
      Merge remote-tracking branches 'spi/topic/devprop', 'spi/topic/fsl', 'spi/topic/fsl-dspi', 'spi/topic/imx' and 'spi/topic/lantiq' into spi-next
      Merge remote-tracking branches 'spi/topic/loopback', 'spi/topic/omap2-mcspi', 'spi/topic/orion', 'spi/topic/pl022' and 'spi/topic/sc18is602' into spi-next
      Merge remote-tracking branches 'spi/topic/spidev', 'spi/topic/spidev-test', 'spi/topic/sunxi', 'spi/topic/tegra' and 'spi/topic/test' into spi-next
      Merge remote-tracking branches 'spi/topic/ti-qspi' and 'spi/topic/xlp' into spi-next

Moritz Fischer (1):
      spi: cadence: Allow for GPIO pins to be used as chipselects

Quentin Schulz (2):
      spi: atmel: factorize reusable code for SPI controller init
      spi: atmel: add deepest PM support to SAMA5D2

Rabin Vincent (1):
      spi: pl022: don't use uninitialized variable

Vignesh R (4):
      spi: spi-ti-qspi: Use dma_engine wrapper for dma memcpy call
      spi: spi-ti-qspi: Remove unused dma_dev variable
      spi: Add can_dma like interface for spi_flash_read
      spi: spi-ti-qspi: Use bounce buffer if read buffer is not DMA'ble

kbuild test robot (1):
      spi: lantiq-ssc: fix platform_no_drv_owner.cocci warnings

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   7 +
 .../devicetree/bindings/spi/spi-bcm63xx-hsspi.txt  |  33 ++
 .../devicetree/bindings/spi/spi-bcm63xx.txt        |  33 ++
 .../devicetree/bindings/spi/spi_pl022.txt          |   8 +-
 drivers/acpi/acpi_apd.c                            |   1 +
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-atmel.c                            |  44 ++-
 drivers/spi/spi-bcm63xx-hsspi.c                    |  35 +-
 drivers/spi/spi-bcm63xx.c                          |  51 ++-
 drivers/spi/spi-cadence.c                          |  65 +++
 drivers/spi/spi-davinci.c                          |  95 ++---
 drivers/spi/spi-dw-mmio.c                          |   2 +-
 drivers/spi/spi-fsl-dspi.c                         |   3 +-
 drivers/spi/spi-fsl-spi.c                          |   3 +-
 drivers/spi/spi-imx.c                              |  20 +-
 drivers/spi/spi-lantiq-ssc.c                       | 438 +++++++++++----------
 drivers/spi/spi-loopback-test.c                    | 154 +++++---
 drivers/spi/spi-omap2-mcspi.c                      |   9 +-
 drivers/spi/spi-orion.c                            |  11 +-
 drivers/spi/spi-pl022.c                            |   2 +-
 drivers/spi/spi-sc18is602.c                        |  24 +-
 drivers/spi/spi-sun6i.c                            |  94 ++++-
 drivers/spi/spi-tegra114.c                         |   2 +-
 drivers/spi/spi-tegra20-sflash.c                   |   2 +-
 drivers/spi/spi-tegra20-slink.c                    |   2 +-
 drivers/spi/spi-test.h                             |  21 +-
 drivers/spi/spi-ti-qspi.c                          |  70 +++-
 drivers/spi/spi-xlp.c                              |   1 +
 drivers/spi/spi.c                                  |  38 +-
 drivers/spi/spidev.c                               |   1 +
 include/linux/spi/spi.h                            |  10 +-
 tools/spi/spidev_test.c                            |  93 ++++-
 32 files changed, 964 insertions(+), 410 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx.txt

--xueyme4alkuvhy3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkJ9BgACgkQJNaLcl1U
h9A89Af+O+TQxFhOIhunnDnyGhsrin1byeej76dzzY3ttpXSzh9hruZohxdbL1Ud
h5qbjkMUOXFOxjeqxi+xqSzivrlPHPaINhoLZswPsMxZSkfpLcJMSoTXczETOmB8
3jUBPSyqF72ksN8JTkEboFm0r5IbfafuGnl9vS9EyUZ7YvWiRyw91RAlGipsVEzl
4e2e09NReZOlfoVkR6mJxQSiyEr7e5zdM8A+DTDMgHVEJ8Lz1y6i++VoL1/BBk2S
ojxQWyURmeddYJC4X2d28rONo9gBmGC7ADNtNGSRU88q4QI7e6B8J3wxvTGm1Xhm
jDCDv0Fx0mSWEOAdcAKqHTrp9ZnQzQ==
=CL1F
-----END PGP SIGNATURE-----

--xueyme4alkuvhy3o--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
