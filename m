From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v4.1
Date: Mon, 13 Apr 2015 15:03:38 +0100
Message-ID: <20150413140338.GJ6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UHEShv6lhVX0YhSa"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--UHEShv6lhVX0YhSa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f22e6e847115abc3a0e2ad7bb18d243d42275af1:

  Linux 4.0-rc7 (2015-04-06 15:39:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.1

for you to fetch changes up to 56afdb70ca9140cdcbdcf01870f3e4e2e8be17f5:

  Merge remote-tracking branches 'spi/topic/spidev' and 'spi/topic/spidev-test' into spi-next (2015-04-11 23:09:31 +0100)

----------------------------------------------------------------
spi: Updates for v4.1

Only one framework update this time around, a change from Lars-Peter to
move full to pm_ops and remove the legacy bus PM ops.  Otherwise it's
all driver updates:

 - Make the spidev driver complain loudly if registered as spidev with
   DT rather than with a compatible string, hopefully helping people
   avoid making that mistake.
 - Error handling and robustness fixes for the Designware and Intel MID
   drivers from Andy Shevchenko.
 - Substantial performance improvements for the Raspberry Pi driver from
   Martin Sperl.
 - Several new features for spidev_test from Adrian Remonda and Ian
   Abbott.

----------------------------------------------------------------
Aaron Brice (4):
      spi: fsl-dspi: Fix clock rate scale values
      spi: fsl-dspi: Fix clock rate scale values
      spi: fsl-dspi: Add cs-sck delays
      spi: fsl-dspi: Add ~50ns delay between cs and sck

Adrian Remonda (3):
      spi: spidev_test: Cleaned hexadecimal dump
      spi: spidev_test: Added verbose output
      spi: spidev_test: Added input buffer from the terminal

Alexander Sverdlin (3):
      spi: pl022: Remove incorrect TxFIFO full reporting
      spi: pl022: Don't touch unspecified bits in interrupt mask
      spi: pl022: Remove dead code

Andre Przywara (1):
      spi: s3c64xx: fix compiler warning in spi-s3c64xx

Andrew Bresticker (2):
      spi: img-spfi: Limit bit clock to 1/4th of input clock
      spi: img-spfi: Reset controller after each message

Andy Gross (1):
      spi: qup: Add DMA capabilities

Andy Shevchenko (19):
      spi: dw: move piece of code out of condition
      spi: dw: get TX level without an additional variable
      spi: dw: refactor code that handles clk_div
      spi: dw: always reprogram CTRL0
      spi: introduce master->handle_err() callback
      spi/rockchip: do an error handling in proper time
      spi: dw: make sure SPI controller is enabled
      spi: dw: program registers as soon as possible
      spi: dw: move to SPI core message handling
      spi: dw-mid: convert value of dma_width to enum dma_slave_buswidth
      spi: dw-mid: split dma_setup() from dma_transfer()
      spi: dw-mid: take care of FIFO overrun/underrun when do DMA
      spi: dw-mid: clear ongoing DMA transfers on timeout
      spi: dw-mid: move to use core SPI DMA mappings
      spi: dw-mid: convert to use dw_dmac instead of intel_mid_dma
      dmaengine: intel-mid-dma: remove the driver
      spi: pxa2xx: shift clk_div in one place
      spi: pxa2xx: replace ugly table by approximation
      spi: dw: fix crash on setup stage

Ben Dooks (1):
      spi: atmel: use endian agnostic IO

Chen Gang (1):
      spi: spi-bfin5xx: Initialize cr_width in bfin_spi_pump_transfers()

Dan Carpenter (2):
      spi: pxa2xx: missing break in pxa2xx_ssp_get_clk_div()
      spi: signedness bug in qspi_trigger_transfer_out_int()

Dmitry Torokhov (1):
      spi: of: do explicitly request modules for of-registered devices

Ezequiel Garcia (3):
      spi: img-spfi: Implement a prepare_message() callback
      spi: img-spfi: Implement a handle_err() callback
      spi: img-spfi: Control CS lines with GPIO

Fabian Frederick (1):
      spi: constify of_device_id array

Geert Uytterhoeven (1):
      spi: Make master->handle_err() callback optional to avoid crashes

Guenter Roeck (1):
      spi: sc18is602: Support multiple devices on a single I2C bus if DT is configured

Hiep Cao Minh (1):
      spi: Using Trigger number to transmit/receive data

Ian Abbott (2):
      spi: spidev: only use up TX/RX bounce buffer space when needed
      spi: spidev: fix possible arithmetic overflow for multi-transfer message

Ivan T. Ivanov (1):
      spi: Ensure that CS line is in non-active state after spi_setup()

Jarkko Nikula (2):
      spi: pxa2xx: Remove needless includes
      spi: omap-uwire: Remove needless include asm/irq.h

Julius Werner (2):
      spi/rockchip: Round up clock rate divisor to err on the safe side
      spi/rockchip: Add device tree property to configure Rx Sample Delay

Lars-Peter Clausen (2):
      spi: Use PM ops instead of legacy suspend/resume
      spi: Remove support for legacy PM

Lucas Stach (1):
      spi: imx: read back the RX/TX watermark levels earlier

Mark Brown (18):
      Merge branch 'topic/err' of git://git.kernel.org/.../broonie/spi into spi-dw
      Merge branch 'fix/dw' of git://git.kernel.org/.../broonie/spi into spi-dw
      spi/omap100k: Convert to runtime PM
      Merge tag 'v4.0-rc5' into spi-bcm2835
      spi: spidev: Warn loudly if instantiated from DT as "spidev"
      Merge branch 'fix/fsl-dspi' of git://git.kernel.org/.../broonie/spi into spi-fsl-dspi
      Merge tag 'v4.0-rc7' into spi-img-spfi
      Merge branch 'fix/img-spfi' of git://git.kernel.org/.../broonie/spi into spi-img-spfi
      Merge remote-tracking branch 'spi/fix/img-spfi' into spi-linus
      Merge remote-tracking branches 'spi/fix/fsl-dspi', 'spi/fix/imx' and 'spi/fix/rockchip' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branch 'spi/topic/img-spfi' into spi-next
      Merge remote-tracking branches 'spi/topic/atmel', 'spi/topic/bcm2385', 'spi/topic/bcm2835', 'spi/topic/bcm53xx' and 'spi/topic/bitbang' into spi-next
      Merge remote-tracking branches 'spi/topic/blackfin', 'spi/topic/cadence', 'spi/topic/dw' and 'spi/topic/err' into spi-next
      Merge remote-tracking branches 'spi/topic/fsl-cspi', 'spi/topic/fsl-dspi', 'spi/topic/imx' and 'spi/topic/of-id' into spi-next
      Merge remote-tracking branches 'spi/topic/omap-100k', 'spi/topic/omap-uwire', 'spi/topic/pl022', 'spi/topic/pm' and 'spi/topic/pxa2xx' into spi-next
      Merge remote-tracking branches 'spi/topic/qup', 'spi/topic/rockchip', 'spi/topic/rspi', 'spi/topic/s3c64xx' and 'spi/topic/sc18is602' into spi-next
      Merge remote-tracking branches 'spi/topic/spidev' and 'spi/topic/spidev-test' into spi-next

Martin Sperl (9):
      spi: bcm2835: fix all checkpath --strict messages
      spi: bcm2835: fill/drain SPI-fifo as much as possible during interrupt
      spi: bcm2835: clock divider can be a multiple of 2
      spi: bcm2835: enable support of 3-wire mode
      spi: bcm2835: move to the transfer_one driver model
      spi: bcm2835: fix code formatting issue
      spi: bcm2835: fill FIFO before enabling interrupts to reduce interrupts/message
      spi: bcm2835: transform native-cs to gpio-cs on first spi_setup
      spi: bcm2835: enabling polling mode for transfers shorter than 30us

Matt Porter (1):
      spi: fsl-imx-cspi: add explicit compatible strings and required clock properties

Michael Grzeschik (1):
      spi: bitbang: only toggle bitchanges

Michal Simek (1):
      spi: cadence: Remove Kconfig dependency

Nicholas Mc Guire (1):
      spi: bcm53xx: use msecs_to_jiffies for conversion

Sifan Naeem (2):
      spi: img-spfi: Remove udelay in soft reset
      spi: img-spfi: Setup TRANSACTION register before CONTROL register

Stefan Agner (1):
      spi: spi-imx: use correct enumeration type

Thor Thayer (2):
      spi: dw-spi: Single Register read to clear IRQs
      spi: dw-spi: Convert 16bit accesses to 32bit accesses

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   12 +-
 .../devicetree/bindings/spi/qcom,spi-qup.txt       |    8 +
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |    8 +
 .../devicetree/bindings/spi/spi-img-spfi.txt       |    1 +
 .../devicetree/bindings/spi/spi-rockchip.txt       |    4 +
 Documentation/spi/spi-summary                      |    3 +-
 Documentation/spi/spidev_test.c                    |  115 +-
 drivers/dma/Kconfig                                |   13 -
 drivers/dma/Makefile                               |    1 -
 drivers/dma/intel_mid_dma.c                        | 1447 --------------------
 drivers/dma/intel_mid_dma_regs.h                   |  299 ----
 drivers/spi/Kconfig                                |    5 +-
 drivers/spi/spi-atmel.c                            |    8 +-
 drivers/spi/spi-bcm2835.c                          |  391 ++++--
 drivers/spi/spi-bcm53xx.c                          |    4 +-
 drivers/spi/spi-bfin5xx.c                          |    3 +-
 drivers/spi/spi-bitbang-txrx.h                     |   18 +-
 drivers/spi/spi-dw-mid.c                           |  167 ++-
 drivers/spi/spi-dw.c                               |  306 ++---
 drivers/spi/spi-dw.h                               |   70 +-
 drivers/spi/spi-fsl-dspi.c                         |   97 +-
 drivers/spi/spi-img-spfi.c                         |  193 +--
 drivers/spi/spi-imx.c                              |    8 +-
 drivers/spi/spi-mpc512x-psc.c                      |    2 +-
 drivers/spi/spi-octeon.c                           |    2 +-
 drivers/spi/spi-omap-100k.c                        |  101 +-
 drivers/spi/spi-omap-uwire.c                       |    1 -
 drivers/spi/spi-pl022.c                            |   14 +-
 drivers/spi/spi-pxa2xx.c                           |  192 ++-
 drivers/spi/spi-qup.c                              |  336 ++++-
 drivers/spi/spi-rockchip.c                         |   38 +-
 drivers/spi/spi-rspi.c                             |  124 +-
 drivers/spi/spi-s3c64xx.c                          |    4 +-
 drivers/spi/spi-sc18is602.c                        |    2 +-
 drivers/spi/spi-st-ssc4.c                          |    2 +-
 drivers/spi/spi.c                                  |  121 +-
 drivers/spi/spidev.c                               |   55 +-
 include/linux/intel_mid_dma.h                      |   76 -
 include/linux/spi/spi.h                            |    8 +-
 39 files changed, 1530 insertions(+), 2729 deletions(-)
 delete mode 100644 drivers/dma/intel_mid_dma.c
 delete mode 100644 drivers/dma/intel_mid_dma_regs.h
 delete mode 100644 include/linux/intel_mid_dma.h

--UHEShv6lhVX0YhSa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVK8y5AAoJECTWi3JdVIfQ1X0H/3urn4RSYkEriT/ZtQPInMdj
CuMdsOtz2Gbd+/mFWkzZBGTKN1uFpVR8ggvb8s/vVRErAD3pJsCmOeeL/kOKXsaW
ziwDN4qGhlD1P7pI05UXQjEWbzggNHLkzHwmWuUiuwrdeBSj8q+cmHzk82XyPQs/
rPsMRPmWXmn8RNphUtqECQ0dsDfFEnRkahaADjXiblfjC7Lxms54VcNCPG/Bn9yI
skD6sAqxhV1rg5oOfqciAt4qhIO+yoWSye9G+1GR/DlNa1z1KoW5OqX3ZPYTG2RJ
gnLtaGTgnYJw1IMV0IGiG0uFHPOL2Q4KOk2GRJQEz/J/S+rv38qeoUjriM7Qps4=
=xvaN
-----END PGP SIGNATURE-----

--UHEShv6lhVX0YhSa--
