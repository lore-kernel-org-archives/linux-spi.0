From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v4.19
Date: Mon, 13 Aug 2018 11:02:57 +0100
Message-ID: <20180813100257.GD6757@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v4.19

for you to fetch changes up to c1acb21b32a3bb601453764c9eac9fc8fbb3a81d:

  Merge branch 'spi-4.19' into spi-next (2018-08-10 17:51:52 +0100)

----------------------------------------------------------------
spi: Updates for v4.19

Quite an active release for the SPI subsystem, lots of small updates and
fixes scattered about with highlights including:

 - 3 wire support in the GPIO driver.
 - Support for setting a custom memory name in the memory mapped flash
   drivers.
 - Support for extended mode in the Freescale DSPI controller.
 - Support for the non-standard integration with the Microsemi Ocelot
   platform in the DesignWare driver.
 - New driver for the SocioNext UniPhier.

----------------------------------------------------------------
Alexandre Belloni (5):
      spi: dw: fix possible race condition
      spi: dw: allow providing own set_cs callback
      spi: dw: export dw_spi_set_cs
      spi: dw-mmio: add MSCC Ocelot support
      spi: dw: document Microsemi integration

Andrey Smirnov (1):
      spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer

Bartosz Golaszewski (1):
      spi: davinci: fix a NULL pointer dereference

Boris Brezillon (1):
      spi: spi-mem: Constify spi_mem->name

Colin Ian King (1):
      spi: omap2-mcspi: remove several redundant variables

Corentin Labbe (1):
      spi: remove unused adi_spi3.h header

David Lechner (1):
      spi: spi-bitbang: change flags from u8 to u16

Esben Haabendal (12):
      spi: spi-fsl-dspi: Drop unreachable else if statement
      spi: spi-fsl-dspi: Drop unneeded use of dataflags bits
      spi: spi-fsl-dspi: Fix per transfer cs_change handling
      spi: spi-fsl-dspi: Simplify transfer counter handling
      spi: spi-fsl-dspi: Support 4 to 16 bits per word transfers
      spi: spi-fsl-dspi: Fix MCR register handling
      spi: spi-fsl-dspi: Fixup regmap configuration
      spi: spi-fsl-dspi: Add support for XSPI mode registers
      spi: spi-fsl-dspi: Framesize control for XSPI mode
      spi: spi-fsl-dspi: XSPI FIFO handling (in TCFQ mode)
      spi: spi-fsl-dspi: Advertise 32 bit for XSPI mode
      spi: spi-fsl-dspi: Enable extended SPI mode

Fabio Estevam (1):
      spi: spi-fsl-dspi: Switch to SPDX identifier

Frieder Schrempf (3):
      spi: spi-mem: Fix a typo in the documentation of struct spi_mem
      spi: spi-mem: Extend the SPI mem interface to set a custom memory name
      mtd: m25p80: Call spi_mem_get_name() to let controller set a custom n=
ame

Geert Uytterhoeven (1):
      spi: sh-msiof: Make sure all DMA operations have completed

Gustavo A. R. Silva (1):
      spi: spi-fsl-dspi: Fix copy-paste error in dspi_probe

Ionela Voinescu (1):
      spi: img-spfi: Set device select bits for SPFI port state

Jan Kundr=E1t (1):
      spi: orion: fix CS GPIO handling again

Janek Kotas (1):
      spi: cadence: Change usleep_range() to udelay(), for atomic context

Keiji Hayashibara (2):
      spi: add SPI controller driver for UniPhier SoC
      spi: uniphier: remove unnecessary include headers

Krzysztof Kozlowski (1):
      spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe

Kunihiko Hayashi (1):
      spi: add DT bindings for UniPhier SPI controller

Liang Chen (1):
      spi: rockchip: add description for px30

Lorenzo Bianconi (2):
      spi: add flags parameter to txrx_word function pointers
      spi: spi-gpio: add SPI_3WIRE support

Mark Brown (4):
      Merge branch 'spi-4.18' into spi-4.19 for DSPI dep
      Merge tag 'spi-dw-set-cs' of https://git.kernel.org/.../broonie/spi i=
nto spi-4.19
      Merge branch 'spi-4.18' into spi-linus
      Merge branch 'spi-4.19' into spi-next

Maxime Chevallier (5):
      spi: imx: Remove duplicate variable assignments
      spi: imx: Use dynamic bursts only when bits_per_word is 8, 16 or 32
      spi: imx: Use correct number of bytes per words
      spi: imx: remove unnecessary check in spi_imx_can_dma
      spi: imx: Use the longuest possible burst size when in dynamic_burst

Mika Westerberg (1):
      spi: pxa2xx: Add support for Intel Ice Lake

Tiago Brusamarello (1):
      spi: spi-fsl-espi: Log fifo counters on error

Wei Yongjun (1):
      spi: cadence: Fix missing clk_disable_unprepare() on error in cnds_ru=
ntime_resume()

 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt    |   6 +-
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 .../devicetree/bindings/spi/spi-uniphier.txt       |  22 +
 drivers/mtd/devices/m25p80.c                       |   3 +
 drivers/spi/Kconfig                                |  13 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-ath79.c                            |   2 +-
 drivers/spi/spi-bitbang.c                          |  50 +-
 drivers/spi/spi-butterfly.c                        |   4 +-
 drivers/spi/spi-cadence.c                          |   4 +-
 drivers/spi/spi-davinci.c                          |   2 +-
 drivers/spi/spi-dw-mmio.c                          |  90 ++++
 drivers/spi/spi-dw.c                               |   9 +-
 drivers/spi/spi-dw.h                               |   2 +
 drivers/spi/spi-fsl-dspi.c                         | 505 +++++++++++------=
---
 drivers/spi/spi-fsl-espi.c                         |   5 +-
 drivers/spi/spi-gpio.c                             |  49 +-
 drivers/spi/spi-img-spfi.c                         |   3 +
 drivers/spi/spi-imx.c                              | 162 ++++---
 drivers/spi/spi-lm70llp.c                          |   5 +-
 drivers/spi/spi-mem.c                              |  28 ++
 drivers/spi/spi-omap2-mcspi.c                      |   9 -
 drivers/spi/spi-orion.c                            |  77 +--
 drivers/spi/spi-pxa2xx.c                           |   4 +
 drivers/spi/spi-sh-msiof.c                         |  53 ++-
 drivers/spi/spi-sh-sci.c                           |  20 +-
 drivers/spi/spi-uniphier.c                         | 523 +++++++++++++++++=
++++
 drivers/spi/spi-xtensa-xtfpga.c                    |   2 +-
 include/linux/spi/adi_spi3.h                       | 254 ----------
 include/linux/spi/spi-mem.h                        |  14 +-
 include/linux/spi/spi_bitbang.h                    |   5 +-
 31 files changed, 1253 insertions(+), 674 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
 create mode 100644 drivers/spi/spi-uniphier.c
 delete mode 100644 include/linux/spi/adi_spi3.h

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltxV1EACgkQJNaLcl1U
h9DebQf/f5F8Wt+ZnXmy7xb2tZMMWp+6mA2yLYOZF7UJ4yi+a2SsQM+wFhPQ5rqS
YsqhOfOyRusbfyVLRanZmiwN0rPJgliCbmPYHwZfqYvJNdjoOQGsVIwYxi6nsgeu
U8x87ltUCxNKUVn4c/boBLzud1uGaEDdYX6DnBbwb6pyeMREtnCcibkKS8v9j5EE
CS+CleqKu1Q6Rql4iMpfKUG89cmdsoJpbMOzHm1rqqX+JkkfCtoH8sTBh8+k6q5T
5yb4JpniqNGtQwQtYILHVUOZizPkNrIB6bDtf7EvvQXugOn0VWc0bIQLm/KW64nh
WLKtmdMmQxuSWUykmCpVcqVg479TUQ==
=tPEr
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
