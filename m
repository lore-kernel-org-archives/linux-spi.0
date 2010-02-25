From: Grant Likely <grant.likely@secretlab.ca>
Subject: [git pull] SPI changes for 2.6.34
Date: Thu, 25 Feb 2010 10:28:51 -0700
Message-ID: <fa686aa41002250928u5cf04507u7e9334ff1a428b53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-next <linux-next@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus.

SPI changes.  Marinated in linux-next for the better part of a month
to enhance the flavour.

g.

secretlab/next-spi
The following changes since commit 60b341b778cc2929df16c0a504c91621b3c6=
a4ad:
  Linus Torvalds (1):
        Linux 2.6.33

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next-spi

Alberto Panizzo (1):
      spi/spi_imx: add device information by switching pr_debug() to de=
v_dbg()

Ernst Schwab (1):
      spi: Correct SPI clock frequency setting in spi_mpc8xxx

=46eng Tang (5):
      spi/dw_spi: bug fix in wait_till_not_busy()
      spi/dw_spi: add a missed dw_spi_remove_host() in exit sequence
      spi/dw_spi: refine the IRQ mode working flow
      spi/dw_spi: add a FIFO depth detection
      spi/dw_spi: fix missing export of dw_spi_remove_host

George Shore (5):
      spi/dw_spi: enable platform specific chipselect.
      spi/dw_spi: add return value to empty mrst_spi_debugfs_init()
      spi/dw_spi: fixed a spelling typo in a warning message.
      spi/dw_spi: remove conditional from 'poll_transfer'.
      spi/dw_spi: conditional transfer mode changes

Grant Likely (2):
      spi/dw_spi: fix __init/__devinit section mismatch
      Merge commit 'v2.6.33-rc6' into secretlab/next-spi

Jassi Brar (6):
      spi/s3c64xx: Rename s3c64xx_spi_cntrlr_info
      spi/s3c64xx: Differentiate ip and rate clock
      spi/s3c64xx: Move src_clk to local driver data
      spi/s3c64xx: Check before mem-region release
      spi/s3c64xx: Include moved header
      spi/s3c64xx: Add new parameter to cs callback

Jean-Hugues Deschenes (4):
      Memory-mapped dw_spi driver
      spi/dw_spi: mmio code style fixups
      spi/dw_spi: Allow dw_spi.c to be a module
      spi/dw_spi: Fix dw_spi_mmio to depend on HAVE_CLK

Joe Perches (1):
      spi/spi_s3c64xx.c: Fix continuation line formats

Magnus Damm (1):
      spi: update MSIOF includes

M=E1rton N=E9meth (1):
      spi: make Open Firmware device id constant

Paul Mundt (1):
      spi: xilinx_spi: Fix up I/O routine wrapping bogosity.

Robert P. J. Day (1):
      spi: Fix reversed args to time_before() in Freescale stmp driver.

Sandeep Paulraj (1):
      spi: Add SPI master driver for DaVinci/DA8xx

Steven King (1):
      spi: Add Freescale/Motorola Coldfire QSPI driver

Uwe Kleine-K=F6nig (1):
      spi/mpc8xxx: don't check platform_get_irq's return value against =
zero

 drivers/spi/Kconfig           |   23 +-
 drivers/spi/Makefile          |    3 +
 drivers/spi/coldfire_qspi.c   |  640 +++++++++++++++++++++
 drivers/spi/davinci_spi.c     | 1255 +++++++++++++++++++++++++++++++++=
++++++++
 drivers/spi/dw_spi.c          |  111 +++--
 drivers/spi/dw_spi_mmio.c     |  147 +++++
 drivers/spi/dw_spi_pci.c      |    2 +
 drivers/spi/mpc52xx_psc_spi.c |    2 +-
 drivers/spi/mpc52xx_spi.c     |    2 +-
 drivers/spi/spi_imx.c         |    2 +-
 drivers/spi/spi_mpc8xxx.c     |    8 +-
 drivers/spi/spi_ppc4xx.c      |    2 +-
 drivers/spi/spi_s3c64xx.c     |   89 ++--
 drivers/spi/spi_sh_msiof.c    |    2 +-
 drivers/spi/spi_stmp.c        |    2 +-
 drivers/spi/xilinx_spi.c      |   28 +-
 drivers/spi/xilinx_spi_of.c   |    2 +-
 include/linux/spi/dw_spi.h    |    5 +
 18 files changed, 2225 insertions(+), 100 deletions(-)
 create mode 100644 drivers/spi/coldfire_qspi.c
 create mode 100644 drivers/spi/davinci_spi.c
 create mode 100644 drivers/spi/dw_spi_mmio.c


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
