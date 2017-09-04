From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v4.14
Date: Mon, 4 Sep 2017 17:38:58 +0100
Message-ID: <20170904163858.tdtwycrtofos2tpl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aeqdrfyqi4ahj6s2"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--aeqdrfyqi4ahj6s2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 569dbb88e80deb68974ef6fdd6a13edb9d686261:

  Linux 4.13 (2017-09-03 13:56:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.14

for you to fetch changes up to ecb478bf866b8450c724958815e8d46b97c1b113:

  Merge remote-tracking branch 'spi/topic/xlp' into spi-next (2017-09-04 15:51:34 +0100)

----------------------------------------------------------------
spi: Updates for v4.14

A fairly quiet release for the SPI subsystem:

 - Move to using IDR for allocating bus numbers.
 - Modernisation of the ep93xx driver, removing a lot of open coding and
   using the framework more.
 - The tools have been moved to use the standard tools build system and
   an install target added (there will be a fairly trivial conflict
   with tip resulting from the changes in the main tools Makefile).
 - A refactoring of the Qualcomm QUP driver which enables new variants
   to be supported.
 - Explicit support for the Freescale i.MX53 and i.MX6 SPI, Renesas
   R-Car H3 and Rockchip RV1108 controllers.

There's also a trivial add/add conflict in spi.c with the ACPI tree
adding a header for some Apple support and the IDR code needing a header
too.

----------------------------------------------------------------
Andy Shevchenko (5):
      spi: tools: move to tools buildsystem
      spi: tools: add install section
      spi: core: Propagate error code of add_uevent_var()
      spi: pxa2xx: Revert "Only claim CS GPIOs when the slave device is created"
      spi: pxa2xx: Don't touch CS pin until we have a transfer pending

Andy Yan (1):
      spi: rockchip: add compatible string for rv1108 spi

Aravind Thokala (2):
      spi/ath79: Fix checkpatch warnings
      spi/bcm63xx-hspi: Fix checkpatch warnings

Arnd Bergmann (4):
      spi: fix building SPI_PXA on MMP
      spi: qup: hide warning for uninitialized variable
      spi: qup: fix 64-bit build warning
      spi: imx: fix little-endian build

Arvind Yadav (1):
      spi: pl022: constify amba_id

Colin Ian King (2):
      spi: loopback-test: make several module parameters static
      spi: pic32: fix spelling mistakes on macro names

Geert Uytterhoeven (2):
      spi: sh-msiof: Add support for R-Car H3
      spi: sh-msiof: Limit minimum divider on R-Car Gen3

Greg Ungerer (1):
      spi: imx: fix use of native chip-selects with devicetree

Gustavo A. R. Silva (4):
      spi: xlp: fix error return code in xlp_spi_probe()
      spi/bcm63xx: fix error return code in bcm63xx_spi_probe()
      spi/bcm63xx-hspi: fix error return code in bcm63xx_hsspi_probe()
      spi: spi-sh: fix error return code in spi_sh_probe()

H Hartley Sweeten (7):
      spi: spi-ep93xx: remove io wrappers
      spi: spi-ep93xx: use 32-bit read/write for all registers
      spi: spi-ep93xx: add spi master prepare_transfer_hardware()
      spi: spi-ep93xx: absorb the interrupt enable/disable helpers
      spi: spi-ep93xx: pass the spi_master pointer around
      spi: spi-ep93xx: remove private data 'current_msg'
      spi: spi-ep93xx: use the default master transfer queueing mechanism

Hauke Mehrtens (1):
      spi: spi-falcon: drop check of boot select

Huibin Hong (1):
      spi: rockchip: configure CTRLR1 according to size and data frame

Jan Kiszka (2):
      spi: pxa2xx: Only claim CS GPIOs when the slave device is created
      spi: pxa2xx: Convert to GPIO descriptor API where possible

Jeffy Chen (3):
      spi: rockchip: Slightly rework return value handling
      spi: rockchip: Fix clock handling in remove
      spi: rockchip: Fix clock handling in suspend/resume

Kamal Dasu (1):
      spi: bcm-qspi: Remove hardcoded settings and spi-nor.h dependency

Lars-Peter Clausen (2):
      spi: altera: Switch to SPI core transfer queue management
      spi: altera: Consolidate TX/RX data register access

Mark Brown (7):
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branches 'spi/topic/altera', 'spi/topic/at79', 'spi/topic/bcm-qspi', 'spi/topic/bcm63xx' and 'spi/topic/bcm63xx-hspi' into spi-next
      Merge remote-tracking branches 'spi/topic/cadence', 'spi/topic/dt', 'spi/topic/ep93xx' and 'spi/topic/falcon' into spi-next
      Merge remote-tracking branches 'spi/topic/imx', 'spi/topic/loopback', 'spi/topic/omap', 'spi/topic/pic32' and 'spi/topic/pl022' into spi-next
      Merge remote-tracking branches 'spi/topic/pxa', 'spi/topic/pxa2xx', 'spi/topic/qup', 'spi/topic/rockchip' and 'spi/topic/sh' into spi-next
      Merge remote-tracking branches 'spi/topic/sh-msiof', 'spi/topic/stm32', 'spi/topic/sunxi', 'spi/topic/tegra' and 'spi/topic/tools' into spi-next
      Merge remote-tracking branch 'spi/topic/xlp' into spi-next

Naga Sureshkumar Relli (1):
      spi: cadence: change sequence of calling runtime_enable

Oleksij Rempel (3):
      spi: loopback-test: provide loop_req option.
      spi: loopback-test: implement testing with no CS
      spi: imx: add SPI_NO_CS support

Philipp Zabel (5):
      spi: stm32: explicitly request exclusive reset control
      spi: sun6i: explicitly request exclusive reset control
      spi: tegra20-slink: explicitly request exclusive reset control
      spi: tegra114: explicitly request exclusive reset control
      spi: tegra20-sflash: explicitly request exclusive reset control

Rob Herring (1):
      spi: Convert to using %pOF instead of full_name

Sergei Shtylyov (1):
      spi: use of_property_read_bool()

Shubhrajyoti Datta (1):
      spi: cadence: Add support for context loss

Suniel Mahesh (3):
      spi: Pick spi bus number from Linux idr or spi alias
      spi: Kernel coding style fixes
      spi: omap: Allocate bus number from spi framework

Varadarajan Narayanan (14):
      spi: qup: Enable chip select support
      spi: qup: Setup DMA mode correctly
      spi: qup: Add completion timeout
      spi: qup: Place the QUP in run mode before DMA
      spi: qup: Fix error handling in spi_qup_prep_sg
      spi: qup: Fix transaction done signaling
      spi: qup: Do block sized read/write in block mode
      spi: qup: refactor spi_qup_io_config into two functions
      spi: qup: call io_config in mode specific function
      spi: qup: allow block mode to generate multiple transactions
      spi: qup: refactor spi_qup_prep_sg
      spi: qup: allow multiple DMA transactions per spi xfer
      spi: qup: Ensure done detection
      spi: qup: Fix QUP version identify method

jiada wang (3):
      spi: imx: introduce fifo_size and has_dmamode in spi_imx_devtype_data
      spi: imx: add selection for iMX53 and iMX6 controller
      spi: imx: dynamic burst length adjust for PIO mode

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   1 +
 Documentation/devicetree/bindings/spi/sh-msiof.txt |   1 +
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 drivers/spi/Kconfig                                |   5 +-
 drivers/spi/spi-altera.c                           | 163 +++---
 drivers/spi/spi-ath79.c                            |  13 +-
 drivers/spi/spi-bcm-qspi.c                         |  89 ++--
 drivers/spi/spi-bcm63xx-hsspi.c                    |  10 +-
 drivers/spi/spi-bcm63xx.c                          |   4 +-
 drivers/spi/spi-cadence.c                          |   4 +-
 drivers/spi/spi-ep93xx.c                           | 501 +++++++-----------
 drivers/spi/spi-falcon.c                           |   5 -
 drivers/spi/spi-imx.c                              | 218 +++++++-
 drivers/spi/spi-loopback-test.c                    |  34 +-
 drivers/spi/spi-omap2-mcspi.c                      |   4 -
 drivers/spi/spi-orion.c                            |   4 +-
 drivers/spi/spi-pic32.c                            |   4 +-
 drivers/spi/spi-pl022.c                            |   2 +-
 drivers/spi/spi-pxa2xx.c                           |  35 +-
 drivers/spi/spi-pxa2xx.h                           |   2 +-
 drivers/spi/spi-qup.c                              | 564 ++++++++++++++-------
 drivers/spi/spi-rockchip.c                         |  60 +--
 drivers/spi/spi-sh-msiof.c                         |  32 +-
 drivers/spi/spi-sh.c                               |   4 +-
 drivers/spi/spi-stm32.c                            |   2 +-
 drivers/spi/spi-sun6i.c                            |   2 +-
 drivers/spi/spi-tegra114.c                         |   2 +-
 drivers/spi/spi-tegra20-sflash.c                   |   2 +-
 drivers/spi/spi-tegra20-slink.c                    |   2 +-
 drivers/spi/spi-xlp.c                              |   4 +-
 drivers/spi/spi.c                                  | 110 ++--
 tools/Makefile                                     |   4 +-
 tools/spi/Build                                    |   2 +
 tools/spi/Makefile                                 |  64 ++-
 34 files changed, 1126 insertions(+), 828 deletions(-)
 create mode 100644 tools/spi/Build

--aeqdrfyqi4ahj6s2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmtgaEACgkQJNaLcl1U
h9Dbsgf+MdU1cvlQP5K3KsPIjQYcqw9k2mXjSR2D9GnxX+oKVIxcxsWitbFGlzJG
PlUr6LQ87EvvwDFhSDOfdqcU9Kl0E5y3nKa3KK4hBcjtGGq2XZ8itBuLb9a21m/M
8K71dLkxCviAPyE1KUUsvRMw8gRvb8Tp7wrKu0+8c3zRkc4O6mCpxR3uC320uGkl
HZTYtNgWxq4XJf9as8p1jl6vuNodQHKuUqcL73fj5xEUYB0iGM1eZageQeewEEv5
7ATGnO/atpvdigR3skE+He1536sUeBZH91+Wf8BapyCz9RHWWUNzWN9StHH0zlTl
fqhYFYaCcz0mdQmHBbVqA92AN9AfpQ==
=iGob
-----END PGP SIGNATURE-----

--aeqdrfyqi4ahj6s2--
