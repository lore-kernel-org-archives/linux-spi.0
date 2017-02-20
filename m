From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI updates for v4.11
Date: Mon, 20 Feb 2017 11:23:11 -0800
Message-ID: <20170220192311.pktmf6sn57p4ym7a@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="swidjugzjo3ujvrk"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--swidjugzjo3ujvrk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4=
=2E11

for you to fetch changes up to 57f22cd29cf1b4ff2aea8505eae2d3ed71ca5de4:

  Merge remote-tracking branches 'spi/topic/ti-qspi' and 'spi/topic/topclif=
f-pch' into spi-next (2017-02-19 16:41:17 +0000)

----------------------------------------------------------------
spi: Updates for v4.11

This release is mainly a collection of driver specific updates,
including a few nice cleanups to make drivers use more core features.
There

 - Automatically use the parent device to allocate DMA buffers if there
   wasn't an explicitly configured device.
 - Fixes for leaks on allocation.
 - A small piece of the start of SPI slave support, a feature that's
   been on the cards for over a decade!

----------------------------------------------------------------
Andi Shyti (1):
      spi: s3c64xx: fix inconsistency between binding and driver

Andy Shevchenko (4):
      spi: dw-mid: switch to new dmaengine_terminate_* API (part 2)
      spi: pxa2xx: add missed break
      spi: pxa2xx: fix indentation of the comments in header
      spi: pxa2xx-pci: Enable DMA for Intel Merrifield

Brian Norris (1):
      spi: rockchip: support "sleep" pin configuration

Christophe JAILLET (3):
      spi: spi-axi: Free resources on error path
      spi: spi-ti-qspi: Fix error handling
      spi: spi-ti-qspi: Fix error handling

Colin Ian King (1):
      spi: armada-3700: fix unsigned compare than zero on irq

Dan Carpenter (3):
      spi: armada-3700: Remove unnecessary condition
      spi: armada-3700: Set mode bits correctly
      spi: s3c64xx: potential oops on probe error

Daniel Kurtz (2):
      spi: When no dma_chan map buffers with spi_master's parent
      spi: mediatek: Only do dma for 4-byte aligned buffers

David E. Box (1):
      spi: pxa2xx: Add support for Intel Gemini Lake

DongCV (2):
      spi: rspi: Fixes bogus received byte in qspi_transfer_in()
      spi: rspi: Replaces "n" by "len" in qspi_transfer_*()

Felix Fietkau (2):
      spi: spi-ath79: support multiple internal chip select lines
      spi: spi-ath79: use gpio_set_value_cansleep for GPIO chip select

Gao Pan (1):
      spi: fsl-lpspi: fix indentation error

Geert Uytterhoeven (5):
      spi: fsl-lpspi: Pre-initialize ret in fsl_lpspi_transfer_one_msg()
      spi: SPI_FSL_DSPI should depend on HAS_DMA
      spi: core: Extract of_spi_parse_dt()
      spi: rspi: Remove useless memory allocation failure message
      spi: sh-msiof: Remove useless memory allocation failure message

H Hartley Sweeten (1):
      spi: spi-ep93xx: simplify GPIO chip selects

Hauke Mehrtens (3):
      spi: make falcon-spi bool
      spi: lantiq-ssc: add support for Lantiq SSC SPI controller
      spi: lantiq-ssc: activate under COMPILE_TEST

Jaedon Shin (1):
      spi: bcm-qspi: Enable the driver on BMIPS_GENERIC

Jan Kiszka (3):
      spi: pxa2xx: Factor out handle_bad_msg
      spi: pxa2xx: Prepare for edge-triggered interrupts
      spi: pca2xx-pci: Allow MSI

Jiada Wang (1):
      spi: imx: adjust watermark level according to transfer length

Johan Hovold (1):
      spi: fix device-node leaks

Kamal Dasu (2):
      spi: bcm-qspi: Added mspi read fallback in bcm_qspi_flash_read()
      spi: bcm-qspi: Fix bcm_qspi_bspi_read() performance

Kevin Hilman (1):
      spi: davinci: use dma_mapping_error()

Marek Szyprowski (1):
      spi: s3c64xx: Don't request/release DMA channels for each SPI transfer

Mark Brown (12):
      Merge tag 'v4.10-rc1' into spi-s3c64xx
      Merge remote-tracking branches 'spi/fix/armada', 'spi/fix/axi', 'spi/=
fix/davinci', 'spi/fix/dw', 'spi/fix/fsl-dspi' and 'spi/fix/pxa2xx' into sp=
i-linus
      Merge remote-tracking branch 'spi/fix/sh-msiof' into spi-linus
      Merge tag 'spi-fix-v4.10-rc4' into spi-linus
      Merge remote-tracking branches 'spi/fix/pxa2xx', 'spi/fix/rspi' and '=
spi/fix/s3c64xx' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branch 'spi/topic/dma' into spi-next
      Merge remote-tracking branches 'spi/topic/armada', 'spi/topic/ath79',=
 'spi/topic/bcm-qspi' and 'spi/topic/bcm53xx' into spi-next
      Merge remote-tracking branches 'spi/topic/dw', 'spi/topic/ep93xx', 's=
pi/topic/falcon' and 'spi/topic/fsl-lpspi' into spi-next
      Merge remote-tracking branches 'spi/topic/imx', 'spi/topic/lantiq-ssc=
', 'spi/topic/mpc52xx', 'spi/topic/ppc4xx' and 'spi/topic/pxa2xx' into spi-=
next
      Merge remote-tracking branches 'spi/topic/rockchip', 'spi/topic/rspi'=
, 'spi/topic/s3c64xx', 'spi/topic/sh-msiof' and 'spi/topic/slave' into spi-=
next
      Merge remote-tracking branches 'spi/topic/ti-qspi' and 'spi/topic/top=
cliff-pch' into spi-next

Markus Elfring (13):
      spi: Use kcalloc() in spi_register_board_info()
      spi: fsl: Use kmalloc_array() in of_fsl_spi_get_chipselects()
      spi: fsl: Use kcalloc() in of_fsl_spi_get_chipselects()
      spi: fsl: Combine substrings for two messages
      spi/mpc52xx: Use kmalloc_array() in mpc52xx_spi_probe()
      spi/mpc52xx: Combine substrings for two messages
      spi/ppc4xx: Combine substrings for a message in spi_ppc4xx_of_probe()
      spi/ppc4xx: Use kcalloc() in spi_ppc4xx_of_probe()
      spi/topcliff-pch: Delete an unnecessary return statement in two funct=
ions
      spi/topcliff-pch: Use kcalloc() in pch_spi_handle_dma()
      spi/topcliff-pch: Improve size determinations in pch_spi_probe()
      spi/topcliff-pch: Combine substrings for four messages
      spi/topcliff-pch: Delete an error message for a failed memory allocat=
ion in pch_spi_set_tx()

Phil Reid (2):
      spi: dw: Make debugfs name unique between instances
      spi: dw: Make debugfs use bus num and make irq name unique

Prahlad V (1):
      spi: ti-qspi: revise ti_qspi_probe() failure flow

Rafa=C5=82 Mi=C5=82ecki (2):
      spi: bcm53xx: set of_node to let DT specify device(s)
      spi: bcm53xx: (re)license code to the GPL v2

Romain Perier (2):
      spi: armada-3700: Replaced raw values for nbits by the SPI macros
      spi: armada-3700: Coding style fixes

Simon Horman (2):
      spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings
      spi: sh-msiof: Do not use C++ style comment

Wei Yongjun (3):
      spi: armada-3700: Remove .owner field for driver
      spi: bcm-qspi: Remove unnecessary platform_set_drvdata()
      spi: armada-3700: Remove spi_master_put in a3700_spi_remove()

 Documentation/devicetree/bindings/spi/sh-msiof.txt |  19 +-
 .../devicetree/bindings/spi/spi-lantiq-ssc.txt     |  29 +
 .../devicetree/bindings/spi/spi-rockchip.txt       |   7 +
 Documentation/spi/ep93xx_spi                       | 105 ---
 arch/arm/mach-ep93xx/edb93xx.c                     |  31 +-
 arch/arm/mach-ep93xx/simone.c                      |  63 +-
 arch/arm/mach-ep93xx/vision_ep9307.c               |  88 +-
 drivers/spi/Kconfig                                |  14 +-
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-armada-3700.c                      |  25 +-
 drivers/spi/spi-ath79.c                            |  23 +-
 drivers/spi/spi-axi-spi-engine.c                   |   3 +-
 drivers/spi/spi-bcm-qspi.c                         | 194 ++--
 drivers/spi/spi-bcm53xx.c                          |  18 +-
 drivers/spi/spi-davinci.c                          |   4 +-
 drivers/spi/spi-dw-mid.c                           |   4 +-
 drivers/spi/spi-dw.c                               |   9 +-
 drivers/spi/spi-dw.h                               |   1 -
 drivers/spi/spi-ep93xx.c                           | 139 +--
 drivers/spi/spi-fsl-lpspi.c                        |   8 +-
 drivers/spi/spi-fsl-spi.c                          |  17 +-
 drivers/spi/spi-imx.c                              |  16 +-
 drivers/spi/spi-lantiq-ssc.c                       | 983 +++++++++++++++++=
++++
 drivers/spi/spi-mpc52xx.c                          |  12 +-
 drivers/spi/spi-mt65xx.c                           |  37 +-
 drivers/spi/spi-ppc4xx.c                           |   7 +-
 drivers/spi/spi-pxa2xx-pci.c                       |  32 +-
 drivers/spi/spi-pxa2xx.c                           |  37 +-
 drivers/spi/spi-rockchip.c                         |   5 +
 drivers/spi/spi-rspi.c                             |   9 +-
 drivers/spi/spi-s3c64xx.c                          |  59 +-
 drivers/spi/spi-sh-msiof.c                         |   8 +-
 drivers/spi/spi-ti-qspi.c                          |  18 +-
 drivers/spi/spi-topcliff-pch.c                     |  31 +-
 drivers/spi/spi.c                                  |  78 +-
 include/linux/platform_data/spi-ep93xx.h           |  17 +-
 include/linux/pxa2xx_ssp.h                         |  14 +-
 37 files changed, 1534 insertions(+), 631 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt
 delete mode 100644 Documentation/spi/ep93xx_spi
 create mode 100644 drivers/spi/spi-lantiq-ssc.c

--swidjugzjo3ujvrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlirQh8ACgkQJNaLcl1U
h9CyYwf+JVufUi/l9Pzjlq2uFdPesiVsLQrv1U1WCcSjGEYIhi4AwKCS1dQkazdv
DyIRtOlEBsXklFayEQgKHYjx/bm91iUDcwlkSCn0cpFxYUHmZi10WpBhWuMlpOz8
x0kybShuIV4oOcYyx/VBZibgfWp5zSOlLK4OXzfWhV6bBWXrbFx+oR28aJQIaC67
rdT7vs/0inV2MAZ/TUhH3saCiTAlsEvC9GSpYp62JEYhp0PuyVzVlyizLolKGomO
hYbU5tZPqJHCoGYkk/IcPx4NOI0iczNLF+VpSxc4eB7pAvZ7hdH8OtpQbS5Jv3eZ
2VrhDeyprVUySZkcuAb0kc5D16Lcag==
=pwdJ
-----END PGP SIGNATURE-----

--swidjugzjo3ujvrk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
