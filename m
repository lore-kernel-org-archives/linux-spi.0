From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI updates for v4.13
Date: Tue, 4 Jul 2017 16:20:52 +0100
Message-ID: <20170704152052.nsain5p2oel6keab@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pjnybb7dp62awnlt"
Cc: linux-spi-p8RBGIrYaKw76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pjnybb7dp62awnlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c:

  Linux 4.12 (2017-07-02 16:07:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.13

for you to fetch changes up to 082f6968bb204d1a3d8b2da3c53d6b7a59bbd985:

  Merge remote-tracking branches 'spi/topic/spidev', 'spi/topic/st-ssc4' and 'spi/topic/stm32' into spi-next (2017-07-03 16:21:12 +0100)

----------------------------------------------------------------
spi: Updates for v4.13

There's only one big change in this release but it's a very big change,
Geert Uytterhoeven has implemented support for SPI slave mode.  This
feature has been on the cards since the subsystem was originally merged
back in the mists of time so it's great that Geert stepped up and
finally implemented it.

 - SPI slave support, together with wholesale renaming of SPI
   controllers from master to controller which went surprisingly
   smoothly.  This is already used with Renesas SoCs and support is in
   the works for i.MX too.
 - New drivers for Meson SPICC and ST STM32

----------------------------------------------------------------
Amelie Delaunay (10):
      spi: Document the STM32 SPI bindings
      spi: add driver for STM32 SPI controller
      spi: stm32: use SoC specific compatible
      spi: stm32: fix compatible to fit with new bindings
      spi: stm32: fix example with st, spi-midi-ns property
      spi: stm32: replace st, spi-midi with st, spi-midi-ns to fit bindings
      spi: stm32: use normal conditional statements instead of ternary operator
      spi: stm32: add runtime PM support
      spi: stm32: enhance DMA error management
      spi: stm32: fix potential dereference null return value

Andres Galacho (1):
      spi: bcm63xx-hsspi: Export OF device ID table as module aliases

Aravind Thokala (1):
      spi/bcm63xx: Fix checkpatch warnings

Arvind Yadav (3):
      spi: davinci: Fix compilation warning.
      spi: davinci: Handle return value of clk_prepare_enable
      spi: loopback-test: Fix kfree() NULL pointer error.

Baruch Siach (1):
      spi: atmel: print version only after successful registration

Chris Packham (2):
      spi: orion: Handle GPIO chip-selects
      spi: st-ssc4: whitespace cleanup

Colin Ian King (4):
      spi: omap2-mcspi: remove redundant check for error status
      spi: stm32: fix error check on mbr being -ve
      spi: sirf: fix spelling mistake: "registerred" -> "registered"
      spi: loopback-test: fix spelling mistake: "reruning" -> "rerunning"

Cyrille Pitchen (1):
      spi: atmel: fix corrupted data issue on SAM9 family SoCs

Fabio Estevam (1):
      spi: imx: Check for allocation failure earlier

Geert Uytterhoeven (9):
      spi: core: Fix devm_spi_register_master() function name in kerneldoc
      spi: core: Replace S_IRUGO permissions by 0444
      spi: SPI_TI_QSPI should depend on HAS_DMA
      spi: Document DT bindings for SPI controllers in slave mode
      spi: core: Add support for registering SPI slave controllers
      spi: Document SPI slave controller support
      spi: slave: Add SPI slave handler reporting uptime at previous message
      spi: slave: Add SPI slave handler controlling system state
      spi: Generalize SPI "master" to "controller"

Geliang Tang (1):
      spi: spidev: use memdup_user

Hisashi Nakamura (1):
      spi: sh-msiof: Add slave mode support

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Cannonlake

Jeffy Chen (3):
      spi: rockchip: fix error handling when probe
      spi: rockchip: Set GPIO_SS flag to enable Slave Select with GPIO CS
      spi: rockchip: Disable Runtime PM when chip select is asserted

Jiada Wang (2):
      spi: imx: dynamic burst length adjust for PIO mode
      spi: imx: fix issue when tx_buf or rx_buf is NULL

Leilk Liu (3):
      spi: mediatek: Add bindings for mediatek MT7622 soc platform
      spi: mediatek: adjust register to enhance time accuracy
      spi: mediatek: add spi support for mt7622 IC

Mark Brown (8):
      Merge branches 'topic/core', 'topic/slave' and 'fix/doc' of git://git.kernel.org/.../broonie/spi into spi-master
      Merge remote-tracking branches 'spi/fix/atmel', 'spi/fix/bcm63xx', 'spi/fix/doc', 'spi/fix/fsl-dspi' and 'spi/fix/ti-qspi' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branch 'spi/topic/master' into spi-next
      Merge remote-tracking branches 'spi/topic/atmel', 'spi/topic/bcm63xx', 'spi/topic/davinci' and 'spi/topic/imx' into spi-next
      Merge remote-tracking branches 'spi/topic/loopback', 'spi/topic/meson-spicc', 'spi/topic/mtk' and 'spi/topic/omap2-mcspi' into spi-next
      Merge remote-tracking branches 'spi/topic/orion', 'spi/topic/pxa2xx', 'spi/topic/rockchip', 'spi/topic/sh-msiof' and 'spi/topic/sirf' into spi-next
      Merge remote-tracking branches 'spi/topic/spidev', 'spi/topic/st-ssc4' and 'spi/topic/stm32' into spi-next

Neil Armstrong (2):
      spi: meson: Add SPICC bindings
      spi: Add Meson SPICC driver

Nikita Yushchenko (1):
      spi: spi-fsl-dspi: ensure non-zero return on error path

Sascha Hauer (7):
      spi: imx: Revert "spi: imx: dynamic burst length adjust for PIO mode"
      spi: imx: Nothing to do in setupxfer when transfer is NULL
      spi: imx: Drop unnecessary check
      spi: imx: put struct spi_imx_config members into driver private struct
      spi: imx: drop bogus unnecessary dma config
      spi: imx: remove bytes_per_word from private driver struct
      spi: imx: rename 'bpw' variables

Seraphime Kirkovski (1):
      spi: spidev: remove unused completion

leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org (2):
      spi: mediatek: Add bindings for mediatek MT2712 soc platform
      spi: mediatek: add spi support for mt2712 IC

 Documentation/devicetree/bindings/spi/sh-msiof.txt |    2 +
 Documentation/devicetree/bindings/spi/spi-bus.txt  |   76 +-
 .../devicetree/bindings/spi/spi-meson.txt          |   31 +
 .../devicetree/bindings/spi/spi-mt65xx.txt         |    2 +
 .../devicetree/bindings/spi/spi-stm32.txt          |   59 +
 Documentation/spi/spi-summary                      |   27 +-
 drivers/spi/Kconfig                                |   44 +-
 drivers/spi/Makefile                               |    6 +
 drivers/spi/spi-atmel.c                            |   30 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |    1 +
 drivers/spi/spi-bcm63xx.c                          |    4 +-
 drivers/spi/spi-davinci.c                          |    9 +-
 drivers/spi/spi-fsl-dspi.c                         |    3 +-
 drivers/spi/spi-imx.c                              |   92 +-
 drivers/spi/spi-loopback-test.c                    |   14 +-
 drivers/spi/spi-meson-spicc.c                      |  619 +++++++++
 drivers/spi/spi-mt65xx.c                           |   61 +-
 drivers/spi/spi-omap2-mcspi.c                      |    3 -
 drivers/spi/spi-orion.c                            |   10 +-
 drivers/spi/spi-pxa2xx.c                           |   22 +
 drivers/spi/spi-rockchip.c                         |   79 +-
 drivers/spi/spi-sh-msiof.c                         |  111 +-
 drivers/spi/spi-sirf.c                             |    2 +-
 drivers/spi/spi-slave-system-control.c             |  154 +++
 drivers/spi/spi-slave-time.c                       |  129 ++
 drivers/spi/spi-st-ssc4.c                          |   38 +-
 drivers/spi/spi-stm32.c                            | 1322 ++++++++++++++++++++
 drivers/spi/spi.c                                  | 1220 ++++++++++--------
 drivers/spi/spidev.c                               |   11 +-
 include/linux/platform_data/spi-mt65xx.h           |    2 +
 include/linux/pxa2xx_ssp.h                         |    1 +
 include/linux/spi/sh_msiof.h                       |    6 +
 include/linux/spi/spi.h                            |  217 ++--
 include/trace/events/spi.h                         |   26 +-
 34 files changed, 3573 insertions(+), 860 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt
 create mode 100644 drivers/spi/spi-meson-spicc.c
 create mode 100644 drivers/spi/spi-slave-system-control.c
 create mode 100644 drivers/spi/spi-slave-time.c
 create mode 100644 drivers/spi/spi-stm32.c

--pjnybb7dp62awnlt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllbslMACgkQJNaLcl1U
h9BIaAf/c4gDQb/Y0Jl6r+tphMENLL/HHa7sl/Ls8lIqiMqamgTm9Q2HsRG7sevA
4c7Grfn/TgWQYIIvhCPAS6xFTm5tSM+WdS7N6hud0KlNh4lFcBYsTQzu/+hikuOL
9Z9mNc6/CYrhYUUB0dc8ovxHCm4eZRk/SLn8wFQb6g21m5lj2Adi62mA9VSUoUfy
pmeI+Szt2g78DEhro+DlOrLjSfI4sF0O4DLpBlSegGADB4jM7UURj92DonSoASob
Z59ooacUsZBsD1c4OrpqfYi2DM3L690ks7RfE4phuPeDXmqYOzUP26LCO4iWYAPQ
kgeg4FvJIZ+eSZl+7BhXd4n6tFhAaw==
=sxmq
-----END PGP SIGNATURE-----

--pjnybb7dp62awnlt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
