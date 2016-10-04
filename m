From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi updates for v4.9
Date: Tue, 4 Oct 2016 12:25:11 +0200
Message-ID: <20161004102511.m3js4b7uafedqfx6@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pj3lsnw6zm3uyg5q"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pj3lsnw6zm3uyg5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 08895a8b6b06ed2323cd97a36ee40a116b3db8ed:

  Linux 4.8-rc8 (2016-09-25 18:47:13 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.9

for you to fetch changes up to 2ce04684335f886fb5adb9ecbd2a85affca549d1:

  Merge remote-tracking branches 'spi/topic/ti-qspi', 'spi/topic/tools', 'spi/topic/txx9' and 'spi/topic/xlp' into spi-next (2016-09-30 09:14:22 -0700)

----------------------------------------------------------------
spi: Updates for v4.9

The SPI subsystem has also had quite a quiet release, though with a
fairly large set of per-driver changes and several new drivers.  The
bulk of the changes are:

 - Lots and lots of cleanups and improvements for the fsl-espi driver.
 - New drivers for Broadcom MSPI/iProc/STB, Cavium ThunderX and J-Core.

----------------------------------------------------------------
Andy Shevchenko (1):
      spi: pxa2xx: Default thresholds to PXA configuration

Arnd Bergmann (2):
      spi: bcm-qspi: don't include linux/mtd/cfi.h
      spi: bcm-qspi: fix suspend/resume #ifdef

Axel Lin (1):
      spi: st-ssc4: Fix misuse of devm_gpio_request/devm_gpio_free APIs

Baoyou Xie (1):
      spi: loopback-test: mark rx_ranges_cmp() static

Baruch Siach (2):
      MAINTAINERS: add tools/spi/ to the SPI entry
      spi: spidev_test: fix build with musl libc

Chris Brandt (1):
      spi: rspi: Increase accuracy of bit rate for RZ

Fabio Estevam (1):
      spi: spi-fsl-dspi: Check clk_prepare_enable() error

Geert Uytterhoeven (4):
      spi: spi-txx9: Add missing clock (un)prepare calls for CCF
      spi: sh-msiof: Use ARCH_SHMOBILE instead of SUPERH
      spi: spidev_test: Fix buffer overflow in unescape()
      spi: core: Use spi_sync_transfer() in spi_write()/spi_read()

Heiner Kallweit (31):
      spi: introduce max_message_size hook in spi_master
      spi: fsl-espi: eliminate spi nor flash read loop
      spi: fsl-espi: dont include irq.h
      spi: fsl-espi: change return type of fsl_espi_setup_transfer to void
      spi: fsl-espi: change return type of fsl_espi_cpu_bufs to void
      spi: fsl-espi: add missing static declaration to fsl_espi_cpu_irq
      spi: fsl-espi: remove unneeded variable in fsl_espi_do_trans
      spi: fsl-espi: remove unused elements n_rx and n_tx in struct fsl_espi_transfer
      spi: fsl-espi: simplify fsl_espi_setup_transfer
      spi: fsl-espi: remove unneeded check in fsl_espi_do_trans
      spi: fsl-espi: pre-allocate message buffer
      spi: fsl-espi: factor out filling the local buffer
      spi: fsl-espi: remove element status from struct fsl_espi_transfer
      spi: fsl-espi: fix status handling in fsl_espi_do_one_msg
      spi: fsl-espi: remove element actual_length from struct fsl_espi_trans
      spi: fsl-espi: eliminate struct fsl_espi_transfer
      spi: fsl-espi: merge fsl_espi_cmd_trans and fsl_espi_rw_trans
      spi: fsl-espi: improve return value handling in fsl_espi_bufs
      spi: fsl-espi: merge fsl_espi_bufs and fsl_espi_cpu_bufs
      spi: fsl-espi: factor out initial message checking
      spi: fsl-espi: centralize populating struct spi_transfer
      spi: fsl-espi: factor out handling of read data
      spi: fsl-espi: improve message length handling
      spi: fsl-espi: merge fsl_espi_trans and fsl_espi_do_trans
      spi: fsl-espi: simplify fsl_espi_setup_transfer
      spi: fsl-espi: improve and simplify interrupt handler
      spi: fsl-espi: align register access with other drivers
      spi: fsl-espi: improve and extend register bit definitions
      spi: fsl-espi: remove unused variable in fsl_espi_setup
      spi: fsl-espi: simplify of_fsl_espi_probe
      spi: fsl-espi: improve return value handling in fsl_espi_probe

Jan Glauber (1):
      spi: octeon: Add ThunderX driver

Jarkko Nikula (3):
      spi: pxa2xx: Do not needlessly initialize stack variables
      spi: pxa2xx: Remove pointer to current SPI message from driver data
      spi: pxa2xx: Remove pointer to chip data from driver data

Jorge Ramirez-Ortiz (1):
      spi: tools: enable CROSS_COMPILE in Makefile

Kamal Dasu (5):
      spi: Broadcom BRCMSTB, NSP, NS2 SoC bindings
      spi: bcm-qspi: Add Broadcom MSPI driver
      spi: brcmstb-qspi: Broadcom settop platform driver
      spi: bcm-qspi: Add BSPI spi-nor flash controller driver
      spi: iproc-qspi: Add Broadcom iProc SoCs support

Kamlakant Patel (1):
      spi: xlp: Add ACPI support for Vulcan SPI controller

LABBE Corentin (2):
      spi: spi-fsl-dspi: constify devtype_data
      spi: spi-fsl-dspi: fix a possible NULL dereference

Marek Vasut (1):
      spi: imx: Gracefully handle NULL master->cs_gpios

Mark Brown (8):
      Merge remote-tracking branch 'spi/fix/spidev' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branch 'spi/topic/dma' into spi-next
      Merge remote-tracking branches 'spi/topic/bcm', 'spi/topic/dw' and 'spi/topic/fsl-dspi' into spi-next
      Merge remote-tracking branches 'spi/topic/fsl-espi', 'spi/topic/imx', 'spi/topic/jcore', 'spi/topic/loopback' and 'spi/topic/meson' into spi-next
      Merge remote-tracking branches 'spi/topic/octeon', 'spi/topic/pic32-sqi', 'spi/topic/pxa2xx' and 'spi/topic/qup' into spi-next
      Merge remote-tracking branches 'spi/topic/rspi', 'spi/topic/sc18is602', 'spi/topic/sh-msiof', 'spi/topic/spidev-test' and 'spi/topic/st-ssc4' into spi-next
      Merge remote-tracking branches 'spi/topic/ti-qspi', 'spi/topic/tools', 'spi/topic/txx9' and 'spi/topic/xlp' into spi-next

Martin Kaiser (2):
      spi: imx: set spi_bus_clk for mx1, mx31 and mx35
      spi: imx: support loopback mode on imx35

Matthias Seidel (2):
      spi: dw: fix multiple slaves with different baudrates
      spi: dw: round up result of calculation for clock divider

Mika Westerberg (2):
      spi: pxa2xx: Add support for GPIO descriptor chip selects
      spi: pxa2xx: Fix build error because of missing header

Neil Armstrong (2):
      spi: meson: Add GXBB Compatible string
      spi: meson: Add GXBB compatible

Phil Reid (2):
      spi: sc18is602: Add reset control via gpio pin.
      spi: sc18is602: Change gpiod_set_value to gpiod_set_value_cansleep

Rich Felker (2):
      spi: jcore: add J-Core SPI master bindings
      spi: add driver for J-Core SPI controller

Sudeep Holla (1):
      spi: qup: skip clk_disable_unprepare if the device is already runtime suspended

Vignesh R (2):
      spi: Add support to handle kmap'd buffers in spi_map_buf()
      spi: spi-ti-qspi: Add DMA support for QSPI mmap read

Wei Yongjun (7):
      spi: pic32-sqi: use list_move_tail and list_move
      spi: jcore: remove unnecessary platform_set_drvdata()
      spi: spi-fsl-dspi: Drop extra spi_master_put in device remove function
      spi: spi-cavium-thunderx: Add missing clk_disable_unprepare()
      spi: bcm-qspi: Fix return value check in bcm_qspi_probe()
      spi: bcm-qspi: Fix error return code in bcm_qspi_probe()
      spi: imx: fix error return code in spi_imx_probe()

 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.txt  |  233 ++++
 .../devicetree/bindings/spi/jcore,spi.txt          |   34 +
 .../devicetree/bindings/spi/spi-meson.txt          |    2 +-
 MAINTAINERS                                        |    1 +
 drivers/spi/Kconfig                                |   26 +-
 drivers/spi/Makefile                               |    4 +
 drivers/spi/spi-bcm-qspi.c                         | 1397 ++++++++++++++++++++
 drivers/spi/spi-bcm-qspi.h                         |  115 ++
 drivers/spi/spi-brcmstb-qspi.c                     |   53 +
 drivers/spi/spi-cavium-thunderx.c                  |  120 ++
 drivers/spi/spi-cavium.h                           |    3 +
 drivers/spi/spi-dw.c                               |   15 +-
 drivers/spi/spi-dw.h                               |    1 +
 drivers/spi/spi-fsl-dspi.c                         |   16 +-
 drivers/spi/spi-fsl-espi.c                         |  607 ++++-----
 drivers/spi/spi-fsl-lib.h                          |    3 +-
 drivers/spi/spi-imx.c                              |   35 +-
 drivers/spi/spi-iproc-qspi.c                       |  163 +++
 drivers/spi/spi-jcore.c                            |  231 ++++
 drivers/spi/spi-loopback-test.c                    |    2 +-
 drivers/spi/spi-meson-spifc.c                      |    1 +
 drivers/spi/spi-pic32-sqi.c                        |    6 +-
 drivers/spi/spi-pxa2xx-dma.c                       |    7 +-
 drivers/spi/spi-pxa2xx.c                           |  172 ++-
 drivers/spi/spi-pxa2xx.h                           |    5 +-
 drivers/spi/spi-qup.c                              |    6 +-
 drivers/spi/spi-rspi.c                             |   14 +-
 drivers/spi/spi-sc18is602.c                        |    9 +
 drivers/spi/spi-st-ssc4.c                          |   19 +-
 drivers/spi/spi-ti-qspi.c                          |  139 +-
 drivers/spi/spi-txx9.c                             |    6 +-
 drivers/spi/spi-xlp.c                              |   13 +-
 drivers/spi/spi.c                                  |   17 +-
 include/linux/pxa2xx_ssp.h                         |   20 +-
 include/linux/spi/spi.h                            |   83 +-
 tools/spi/Makefile                                 |    2 +
 tools/spi/spidev_test.c                            |    3 +-
 37 files changed, 3046 insertions(+), 537 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt
 create mode 100644 drivers/spi/spi-bcm-qspi.c
 create mode 100644 drivers/spi/spi-bcm-qspi.h
 create mode 100644 drivers/spi/spi-brcmstb-qspi.c
 create mode 100644 drivers/spi/spi-cavium-thunderx.c
 create mode 100644 drivers/spi/spi-iproc-qspi.c
 create mode 100644 drivers/spi/spi-jcore.c

--pj3lsnw6zm3uyg5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX84OGAAoJECTWi3JdVIfQBF0H/iDyMDI0O5Fb1Vax01MuXMvA
LzwAnKM4pHLZsmftJ6+qVeToyYBMXmtcfkthSL8crVbSAnUCjpVkyzfXdc3lZyXs
jtMoVL7Bt+ClCo2G9dzBzjYR3tG3yYUdq1z+zQg6KAbA7BERmxXqzu2LPqViOyUz
vIhm/fgG2vM+Hha/qne3G8JPKphy3izoC8vuKreZe2NssTzuPOUQmFgfHX69H8yT
Pbu43r+/QZiM+knzYAFgek2AJENJ8ZOE7XbMPvp7LTuBqnWKS+4TPtKkBkrsge/J
+znVmibrDGTQJmh0cuOTx83L2GKV38ufUM4mYvc3hb5SEX9lP8VT/Pr71whMRWc=
=RYLw
-----END PGP SIGNATURE-----

--pj3lsnw6zm3uyg5q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
