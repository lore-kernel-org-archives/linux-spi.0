From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI updates for v4.15
Date: Mon, 13 Nov 2017 12:10:26 +0000
Message-ID: <20171113121026.bezsamxv3wudcbvn@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7yh7sui6sqfnyq2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--p7yh7sui6sqfnyq2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 39dae59d66acd86d1de24294bd2f343fd5e7a625:

  Linux 4.14-rc8 (2017-11-05 13:05:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v4.15

for you to fetch changes up to abbdb5ce31c21a4b3c3922c56030f3d487497933:

  Merge remote-tracking branches 'spi/topic/sh-msiof', 'spi/topic/slave', '=
spi/topic/spreadtrum' and 'spi/topic/tegra114' into spi-next (2017-11-10 21=
:33:51 +0000)

----------------------------------------------------------------
spi: Updates for v4.15

This release is almost entirely driver changes, there's a couple of
fixes in the core but otherwise it's all drivers:

 - Fix for mixed dynamic and static bus number assignment.
 - Fixes for some leaks arising from confusing lifetime rules during
   device unregistration and improved documentation to try to help avoid
   this in the future.
 - Fixes to make the native chip select support for i.MX usable.
 - Slave mode support for i.MX.
 - Support for Coldfire MCF5441x DSPI, Renesas R8A7443/5 and Spreadtrum
   ADI.

----------------------------------------------------------------
Angelo Dureghello (1):
      spi: spi-fsl-dspi: enabling Coldfire mcf5441x dspi

Arnd Bergmann (1):
      spi: spreadtrum adi: add hwspinlock dependency

Baolin Wang (3):
      spi: Add Spreadtrum ADI controller documentation
      spi: Add ADI driver for Spreadtrum platform
      spi: sprd: Fix the possible negative value of BIT()

Colin Ian King (3):
      spi: orion: remove redundant assignment of status to zero
      spi: s3c64xx: remove redundant pointer sci
      spi: sh-msiof: remove redundant pointer dev

Dan Carpenter (2):
      spi: sprd-adi: checking for NULL instead of IS_ERR()
      spi: sprd-adi: silence an uninitialized variable warning

Fabio Estevam (1):
      spi: Kconfig: Remove old comments now that SPI slave is supported

Fabrizio Castro (3):
      spi: rspi: Add r8a7743/5 to the compatible list
      spi: sh-msiof: Add compatible strings for r8a774[35]
      spi: sh-msiof: Add r8a774[35] to the compatible list

Franklin Cooper (1):
      spi: spi-davinci: Update binding for 66AK2Gx pwr dm property

Geert Uytterhoeven (2):
      spi: rspi: Use of_device_get_match_data() helper
      spi: sh-msiof: Use of_device_get_match_data() helper

Hiromitsu Yamasaki (1):
      spi: sh-msiof: Fix DMA transfer size check

Johan Hovold (3):
      spi: fix use-after-free at controller deregistration
      spi: document odd controller reference handling
      spi: spi-axi: fix potential use-after-free after deregistration

Lucas Stach (1):
      spi: fix IDR collision on systems with both fixed and dynamic SPI bus=
 numbers

Mark Brown (5):
      Merge remote-tracking branches 'spi/fix/idr' and 'spi/fix/sh-msiof' i=
nto spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branches 'spi/topic/armada', 'spi/topic/axi', '=
spi/topic/davinci' and 'spi/topic/fsl-dspi' into spi-next
      Merge remote-tracking branches 'spi/topic/imx', 'spi/topic/mxs', 'spi=
/topic/orion', 'spi/topic/rspi' and 'spi/topic/s3c64xx' into spi-next
      Merge remote-tracking branches 'spi/topic/sh-msiof', 'spi/topic/slave=
', 'spi/topic/spreadtrum' and 'spi/topic/tegra114' into spi-next

Maxime Chevallier (1):
      spi: a3700: Change SPI mode before asserting chip-select

Ralf Ramsauer (1):
      spi: tegra114: correct register name in definition

Trent Piepho (4):
      spi: imx: Fix failure path leak on GPIO request error
      spi: imx: GPIO based chip selects should not be required
      spi: imx: Fix failure path leak on GPIO request error
      spi: imx: Don't require platform data chipselect array

Uwe Kleine-K=F6nig (1):
      spi: mxs: implement runtime pm

Wu Fengguang (1):
      spi: sprd-adi: fix platform_no_drv_owner.cocci warnings

jiada wang (1):
      spi: imx: Add support for SPI Slave mode

 Documentation/devicetree/bindings/spi/sh-msiof.txt |   6 +-
 .../devicetree/bindings/spi/spi-davinci.txt        |  10 +
 Documentation/devicetree/bindings/spi/spi-rspi.txt |   5 +-
 .../devicetree/bindings/spi/spi-sprd-adi.txt       |  58 +++
 drivers/spi/Kconfig                                |  13 +-
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-armada-3700.c                      |  17 +-
 drivers/spi/spi-axi-spi-engine.c                   |   4 +-
 drivers/spi/spi-fsl-dspi.c                         |  66 ++--
 drivers/spi/spi-imx.c                              | 256 ++++++++++---
 drivers/spi/spi-mxs.c                              | 120 +++++-
 drivers/spi/spi-orion.c                            |   1 -
 drivers/spi/spi-rspi.c                             |   6 +-
 drivers/spi/spi-s3c64xx.c                          |   3 -
 drivers/spi/spi-sh-msiof.c                         |  12 +-
 drivers/spi/spi-sprd-adi.c                         | 418 +++++++++++++++++=
++++
 drivers/spi/spi-tegra114.c                         |   6 +-
 drivers/spi/spi.c                                  |   9 +-
 include/linux/spi/spi-fsl-dspi.h                   |  31 ++
 19 files changed, 926 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
 create mode 100644 drivers/spi/spi-sprd-adi.c
 create mode 100644 include/linux/spi/spi-fsl-dspi.h

--p7yh7sui6sqfnyq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloJi7EACgkQJNaLcl1U
h9CwPAf/f72sy7fD6T9HMg++II11OSKDLLGvzYmQ1Y2QXcqdvIRofoUyCnfFibCe
N8K95oyjkA7koO0qUgiT7Zxu0iQ2T+eSuiNuhqoO86c8jVk8JbNzzuhfBIZD2VLy
XInx2fdK3B3PGpPToq17jcgy4GZsc+/5UuMxqnDlEI+2a+T+t8V2RmJfWs6dqcK0
rfZYrmJq0e842NWVi2DYIJyrwaqemjumUckNLc9vQGNU9bYGLeNyonY35LcxvV+L
nPuCSAa73E6kKEwzH5cvfxlBDzdz+LizArX77vAZ671qrDzXgQk3eXASwE8uBkdf
DRvUBALc5IHW6X/PrST98SbxKzKfng==
=Z02d
-----END PGP SIGNATURE-----

--p7yh7sui6sqfnyq2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
