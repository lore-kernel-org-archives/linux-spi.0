From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi v3.20
Date: Mon, 9 Feb 2015 15:38:32 +0800
Message-ID: <20150209073832.GH23228@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kHRd/tpU31Zn62xO"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kHRd/tpU31Zn62xO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d426a842b0c203c182ec2658efc4282ef1eb80be:

  Merge remote-tracking branches 'spi/fix/fsl-dspi' and 'spi/fix/imx' into spi-linus (2015-02-04 20:57:31 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.20

for you to fetch changes up to 66886337bf2a523aef76cff84c846335db5f85f9:

  Merge remote-tracking branch 'spi/topic/xilinx' into spi-next (2015-02-08 11:17:01 +0800)

----------------------------------------------------------------
spi: Updates for v3.20

The major highlight this release is a refactoring of the core to allow
us to run synchronous transfers in the context of the caller when there
is no contention for the bus.  This improves performance in the very
common case by eliminating context switches and reducing the number of
hardware setup and teardown operations we need to perform.

Other changes:

 - New drivers for DLN-2 USB-SPI adapter and ST SPI controllers.
 - A big round of cleanups, performance and feature improvements
   for the xilinx driver from Ricardo Ribalda Delgado.
 - A wide range of smaller cleanups, fixes and feature improvements
   throughout the subsystem.

----------------------------------------------------------------
Andrew Bresticker (1):
      spi: img-spfi: Select FIFO based on transfer length

Andy Shevchenko (3):
      spi: dw: print debug message with FIFO size
      spi: dw-pci: describe Intel MID controllers better
      spi: dw-mid: get a proper clock frequency for SPI2

Arnd Bergmann (2):
      spi/rockchip: avoid uninitialized-use warning
      spi: pl08x: do not select S3C64XX_PL080

Axel Lin (1):
      spi: st-ssc4: Remove duplicate code to test unsupported mode bits

Barry Song (2):
      spi: sirf: drop redundant sirf,marco-spi compatible string
      spi: sirf: add missed devicetree binding document

Bhuvanchandra DV (1):
      spi: fsl-dspi: Remove possible memory leak of 'chip'

Chao Fu (1):
      spi: spi-fsl-dspi: Remove spi-bitbang

Esben Haabendal (1):
      spi: fsl-(e)spi: Support compile as module

Fabio Estevam (1):
      spi: spi-imx: Do not store the irq number in the private structure

Geert Uytterhoeven (1):
      spi: sh-msiof: Use async pm_runtime_put() in sh_msiof_spi_setup()

Ian Abbott (1):
      spi: spidev: Convert buf pointers for 32-bit compat SPI_IOC_MESSAGE(n)

Ivan T. Ivanov (1):
      spi: qup: Add SPI_CPOL configuration support

Jarkko Nikula (7):
      spi: Remove FSF mailing addresses
      spi: pxa2xx: Remove unused define
      spi: pxa2xx: Move is_lpss_ssp() tests to caller
      spi: pxa2xx: Add definition for Intel Quark DDS_RATE register
      spi: pxa2xx: Pass driver data instead of ioaddr to wait_ssp_rx_stall()
      spi: pxa2xx: Cleanup register access macros
      spi: pxa2xx: Fix unconditional call of lpss_ssp_setup in pxa2xx_spi_resume

Ken Wilson (2):
      spi: orion: Change spi-orion to use transfer_one() semantics for SPI transfers
      spi: orion: Add multiple chip select support to spi-orion

Krzysztof Kozlowski (1):
      spi: meson: Constify struct regmap_config

Laurentiu Palcu (2):
      spi: add support for DLN-2 USB-SPI adapter
      spi/dln2: simplify return flow for dln2_spi_transfer_setup and dln2_spi_enable

Lee Jones (2):
      spi: Add new driver for STMicroelectronics' SPI Controller
      spi: st: Provide Device Tree binding documentation

Mark Brown (18):
      spi: Move queue data structure initialisation to main master init
      spi: Check to see if the device is processing a message before we idle
      spi: Pump transfers inside calling context for spi_sync()
      spi: Only idle the message pump in the worker kthread
      spi/falcon: Remove hardware prepare and unprepare functions
      spi/dln2: Fix for PM_RUNTIME removal
      Merge remote-tracking branch 'spi/fix/msiof' into spi-sh-msiof
      Merge tag 'v3.19-rc3' into spi-sh-msiof
      spi: Revert "spi/xilinx: Remove iowrite/ioread wrappers"
      Merge tag 'spi-v3.19-rc7' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branch 'spi/topic/sh-msiof' into spi-next
      Merge remote-tracking branches 'spi/topic/atmel', 'spi/topic/config', 'spi/topic/dln2' and 'spi/topic/dw' into spi-next
      Merge remote-tracking branches 'spi/topic/falcon', 'spi/topic/fsf', 'spi/topic/fsl', 'spi/topic/fsl-dspi' and 'spi/topic/gpio' into spi-next
      Merge remote-tracking branches 'spi/topic/img-spfi', 'spi/topic/imx', 'spi/topic/inline', 'spi/topic/meson' and 'spi/topic/mxs' into spi-next
      Merge remote-tracking branches 'spi/topic/orion', 'spi/topic/pxa2xx', 'spi/topic/qup', 'spi/topic/rockchip' and 'spi/topic/samsung' into spi-next
      Merge remote-tracking branches 'spi/topic/sirf', 'spi/topic/spidev', 'spi/topic/st-ssc' and 'spi/topic/ti-qspi' into spi-next
      Merge remote-tracking branch 'spi/topic/xilinx' into spi-next

Michal Simek (1):
      spi: Kconfig: Remove additional newline

Nicholas Mc Guire (7):
      spi/fsl: unnecessary double init_completion removed
      spi: atmel: cleanup wait_for_completion return handling
      spi: match var type to return type of wait_for_completion
      spi: sh-msiof: cleanup wait_for_completion return handling
      spi: spi-imx: cleanup wait_for_completion handling
      spi: ti-qspi: cleanup wait_for_completion return handling
      spi: mxs: cleanup wait_for_completion return handling

Nizam Haider (1):
      spi/gpio: fixed space coding style issue

Nobuhiro Iwamatsu (1):
      spi: sh-msiof: Update calculation of frequency dividing

Ricardo Ribalda (1):
      spi/xilinx: Check number of slaves range

Ricardo Ribalda Delgado (18):
      spi/xilinx: Support for spi mode LSB_FIRST
      spi/xilinx: Support for spi mode LOOP
      spi/xilinx: Simplify data read from the Rx FIFO
      spi/xilinx: Simplify spi_fill_tx_fifo
      spi/xilinx: Leave the IRQ always enabled.
      spi/xilinx: Code cleanup
      spi/xilinx: Use cached value of register
      spi/xilinx: Support cores with no interrupt
      spi/xilinx: Do not inhibit transmission in polling mode
      spi/xilinx: Support for spi mode CS_HIGH
      spi/xilinx: Remove rx_fn and tx_fn pointer
      spi/xilinx: Make spi_tx and spi_rx simmetric
      spi/xilinx: Convert remainding_bytes in remaining words
      spi/xilinx: Convert bits_per_word in bytes_per_word
      spi/xilinx: Remove iowrite/ioread wrappers
      spi/xilinx: Remove remaining_words driver data variable
      spi/xilinx: Use polling mode on small transfers
      spi/xilinx: Fix access invalid memory on xilinx_spi_tx

Rob Herring (1):
      spi: spi-pxa2xx: only include mach/dma.h for legacy DMA

Yoshihiro Shimoda (1):
      spi: sh-msiof: Configure MSIOF sync signal timing in device tree

 Documentation/devicetree/bindings/spi/sh-msiof.txt |  16 +
 Documentation/devicetree/bindings/spi/spi-sirf.txt |  41 +
 .../devicetree/bindings/spi/spi-st-ssc.txt         |  40 +
 arch/x86/pci/intel_mid_pci.c                       |   1 -
 drivers/spi/Kconfig                                |  24 +-
 drivers/spi/Makefile                               |   2 +
 drivers/spi/spi-atmel.c                            |  12 +-
 drivers/spi/spi-au1550.c                           |   4 -
 drivers/spi/spi-bcm2835.c                          |   4 -
 drivers/spi/spi-bcm63xx.c                          |   4 -
 drivers/spi/spi-bitbang.c                          |   4 -
 drivers/spi/spi-butterfly.c                        |   4 -
 drivers/spi/spi-coldfire-qspi.c                    |   5 -
 drivers/spi/spi-davinci.c                          |   4 -
 drivers/spi/spi-dln2.c                             | 881 +++++++++++++++++++++
 drivers/spi/spi-dw-mid.c                           |  15 +-
 drivers/spi/spi-dw-pci.c                           |  38 +-
 drivers/spi/spi-dw.c                               |   9 +-
 drivers/spi/spi-falcon.c                           |  12 -
 drivers/spi/spi-fsl-cpm.c                          |   9 +
 drivers/spi/spi-fsl-dspi.c                         | 157 ++--
 drivers/spi/spi-fsl-lib.c                          |  16 +-
 drivers/spi/spi-fsl-lib.h                          |   4 +-
 drivers/spi/spi-gpio.c                             |   8 +-
 drivers/spi/spi-img-spfi.c                         |  49 +-
 drivers/spi/spi-imx.c                              |  28 +-
 drivers/spi/spi-lm70llp.c                          |   4 -
 drivers/spi/spi-meson-spifc.c                      |   2 +-
 drivers/spi/spi-mxs.c                              |   5 +-
 drivers/spi/spi-omap-100k.c                        |   5 -
 drivers/spi/spi-omap-uwire.c                       |   4 -
 drivers/spi/spi-omap2-mcspi.c                      |   5 -
 drivers/spi/spi-orion.c                            |  88 +-
 drivers/spi/spi-pxa2xx-dma.c                       |  17 +-
 drivers/spi/spi-pxa2xx-pxadma.c                    |  34 +-
 drivers/spi/spi-pxa2xx.c                           | 207 +++--
 drivers/spi/spi-pxa2xx.h                           |  34 +-
 drivers/spi/spi-qup.c                              |  11 +-
 drivers/spi/spi-rockchip.c                         |   6 +-
 drivers/spi/spi-rspi.c                             |   5 -
 drivers/spi/spi-s3c64xx.c                          |   4 -
 drivers/spi/spi-sc18is602.c                        |   4 -
 drivers/spi/spi-sh-hspi.c                          |   5 -
 drivers/spi/spi-sh-msiof.c                         |  91 ++-
 drivers/spi/spi-sh.c                               |   5 -
 drivers/spi/spi-sirf.c                             |   1 -
 drivers/spi/spi-st-ssc4.c                          | 504 ++++++++++++
 drivers/spi/spi-ti-qspi.c                          |  14 +-
 drivers/spi/spi-topcliff-pch.c                     |   4 -
 drivers/spi/spi-xilinx.c                           | 298 +++----
 drivers/spi/spi.c                                  | 120 ++-
 drivers/spi/spidev.c                               | 125 ++-
 include/linux/pxa2xx_ssp.h                         |   1 +
 include/linux/spi/at86rf230.h                      |   4 -
 include/linux/spi/l4f00242t03.h                    |   4 -
 include/linux/spi/lms283gf05.h                     |   4 -
 include/linux/spi/mxs-spi.h                        |   4 -
 include/linux/spi/pxa2xx_spi.h                     |   5 -
 include/linux/spi/rspi.h                           |   5 -
 include/linux/spi/sh_hspi.h                        |   4 -
 include/linux/spi/sh_msiof.h                       |   2 +
 include/linux/spi/spi.h                            |   6 +-
 include/linux/spi/tle62x0.h                        |   4 -
 include/linux/spi/tsc2005.h                        |   5 -
 64 files changed, 2300 insertions(+), 741 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sirf.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-st-ssc.txt
 create mode 100644 drivers/spi/spi-dln2.c
 create mode 100644 drivers/spi/spi-st-ssc4.c

--kHRd/tpU31Zn62xO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2GP3AAoJECTWi3JdVIfQOQsH/2f6+Fm7Wet3PJ85BkRENCIQ
cuUOqrZYyhXNtfvASbMK7TBg1YqjnHKkPt7Vna6syYb4MymYR706oDQdaJcJh0kA
2V6XG4s7mKSrc5USqAMeJm/sBWufsdzwVuKdCP2xD+WRNsvHJlrKnSVFyG84T/CA
eeB1kO4r9Qfx/sMZOkmOO6xem0/ZfxC9q+wPs+e+sMNoOcUH0wSZ60o1A7BG+NVl
ed5JvePX5ZYFMGWirkqqW2LtiIqyLdsivMpmlLHTBzzz3xSItjIXsfgnfdPEJD0O
tZbI53+2GPP/BqFGWSdLXI3JNMByiCDGzzoIwgmhM55DjbV64n8at2VHa1AVorE=
=IRCr
-----END PGP SIGNATURE-----

--kHRd/tpU31Zn62xO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
