From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: spi-next updated
Date: Thu, 21 Jan 2010 10:02:51 -0700
Message-ID: <fa686aa41001210902n459435beteae54e558c30eea7@mail.gmail.com>
References: <fa686aa41001201316s1fc6581fg4a75894d0b32c458@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa41001201316s1fc6581fg4a75894d0b32c458-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi all,

I've updated my spi-next branch again.  It now includes the following
patches.  (I'm sending the whole list instead of just the delta since
my last update ran afoul of the mailing list # of recipients rule).

g.

The following changes since commit 7284ce6c9f6153d1777df5f310c959724d1bd446:
  Linus Torvalds (1):
        Linux 2.6.33-rc4

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next-spi

Alberto Panizzo (1):
      spi/spi_imx: add device information by switching pr_debug() to dev_db=
g()

Feng Tang (5):
      spi/dw_spi: bug fix in wait_till_not_busy()
      spi/dw_spi: add a missed dw_spi_remove_host() in exit sequence
      spi/dw_spi: refine the IRQ mode working flow
      spi/dw_spi: add a FIFO depth detection
      spi/dw_spi: conditional transfer mode changes

Grant Likely (1):
      spi/dw_spi: fix __init/__devinit section mismatch

Jassi Brar (6):
      spi/s3c64xx: Rename s3c64xx_spi_cntrlr_info
      spi/s3c64xx: Differentiate ip and rate clock
      spi/s3c64xx: Move src_clk to local driver data
      spi/s3c64xx: Check before mem-region release
      spi/s3c64xx: Include moved header
      spi/s3c64xx: Add new parameter to cs callback

Jean-Hugues Deschenes (3):
      Memory-mapped dw_spi driver
      spi/dw_spi: mmio code style fixups
      spi/dw_spi: Allow dw_spi.c to be a module

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
      spi/mpc8xxx: don't check platform_get_irq's return value against zero

 drivers/spi/Kconfig           |   23 +-
 drivers/spi/Makefile          |    3 +
 drivers/spi/coldfire_qspi.c   |  640 +++++++++++++++++++++
 drivers/spi/davinci_spi.c     | 1255 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/spi/dw_spi.c          |  111 +++--
 drivers/spi/dw_spi_mmio.c     |  147 +++++
 drivers/spi/dw_spi_pci.c      |    2 +
 drivers/spi/mpc52xx_psc_spi.c |    2 +-
 drivers/spi/mpc52xx_spi.c     |    2 +-
 drivers/spi/spi_imx.c         |    2 +-
 drivers/spi/spi_mpc8xxx.c     |    4 +-
 drivers/spi/spi_ppc4xx.c      |    2 +-
 drivers/spi/spi_s3c64xx.c     |   78 ++--
 drivers/spi/spi_sh_msiof.c    |    2 +-
 drivers/spi/spi_stmp.c        |    2 +-
 drivers/spi/xilinx_spi.c      |   28 +-
 drivers/spi/xilinx_spi_of.c   |    2 +-
 include/linux/spi/dw_spi.h    |    5 +
 18 files changed, 2218 insertions(+), 92 deletions(-)
 create mode 100644 drivers/spi/coldfire_qspi.c
 create mode 100644 drivers/spi/davinci_spi.c
 create mode 100644 drivers/spi/dw_spi_mmio.c


On Wed, Jan 20, 2010 at 2:16 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> w=
rote:
> Hi all. =A0I've picked up a bunch of the SPI patches into my next-spi
> branch in preparation for 2.6.34. =A0Please take a look and let me know
> if I'm missing anything.
>
> You can also check on the status of patches in patchwork:
>
> http://patchwork.kernel.org/project/spi-devel-general/list/
>
> Cheers,
> g.
>
> The following changes since commit 7284ce6c9f6153d1777df5f310c959724d1bd4=
46:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Linux 2.6.33-rc4
>
> are available in the git repository at:
>
> =A0git://git.secretlab.ca/git/linux-2.6 next-spi
>
> Alberto Panizzo (1):
> =A0 =A0 =A0spi/spi_imx: add device information by switching pr_debug() to=
 dev_dbg()
>
> Feng Tang (3):
> =A0 =A0 =A0spi/dw_spi: bug fix in wait_till_not_busy()
> =A0 =A0 =A0spi/dw_spi: add a missed dw_spi_remove_host() in exit sequence
> =A0 =A0 =A0spi/dw_spi: refine the IRQ mode working flow
>
> Grant Likely (1):
> =A0 =A0 =A0spi/dw_spi: fix __init/__devinit section mismatch
>
> Jassi Brar (6):
> =A0 =A0 =A0spi/s3c64xx: Rename s3c64xx_spi_cntrlr_info
> =A0 =A0 =A0spi/s3c64xx: Differentiate ip and rate clock
> =A0 =A0 =A0spi/s3c64xx: Move src_clk to local driver data
> =A0 =A0 =A0spi/s3c64xx: Check before mem-region release
> =A0 =A0 =A0spi/s3c64xx: Include moved header
> =A0 =A0 =A0spi/s3c64xx: Add new parameter to cs callback
>
> Magnus Damm (1):
> =A0 =A0 =A0spi: update MSIOF includes
>
> M=E1rton N=E9meth (1):
> =A0 =A0 =A0spi: make Open Firmware device id constant
>
> Paul Mundt (1):
> =A0 =A0 =A0spi: xilinx_spi: Fix up I/O routine wrapping bogosity.
>
> Robert P. J. Day (1):
> =A0 =A0 =A0spi: Fix reversed args to time_before() in Freescale stmp driv=
er.
>
> Sandeep Paulraj (1):
> =A0 =A0 =A0spi: Add SPI master driver for DaVinci/DA8xx
>
> Steven King (1):
> =A0 =A0 =A0spi: Add Freescale/Motorola Coldfire QSPI driver
>
> Uwe Kleine-K=F6nig (1):
> =A0 =A0 =A0spi/mpc8xxx: don't check platform_get_irq's return value again=
st zero
>
> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 17 +
> =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0drivers/spi/coldfire_qspi.c =A0 | =A0640 +++++++++++++++++++++
> =A0drivers/spi/davinci_spi.c =A0 =A0 | 1255 +++++++++++++++++++++++++++++=
++++++++++++
> =A0drivers/spi/dw_spi.c =A0 =A0 =A0 =A0 =A0| =A0 68 ++-
> =A0drivers/spi/dw_spi_pci.c =A0 =A0 =A0| =A0 =A02 +
> =A0drivers/spi/mpc52xx_psc_spi.c | =A0 =A02 +-
> =A0drivers/spi/mpc52xx_spi.c =A0 =A0 | =A0 =A02 +-
> =A0drivers/spi/spi_imx.c =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/spi/spi_mpc8xxx.c =A0 =A0 | =A0 =A04 +-
> =A0drivers/spi/spi_ppc4xx.c =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/spi/spi_s3c64xx.c =A0 =A0 | =A0 78 ++--
> =A0drivers/spi/spi_sh_msiof.c =A0 =A0| =A0 =A02 +-
> =A0drivers/spi/spi_stmp.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/spi/xilinx_spi.c =A0 =A0 =A0| =A0 28 +-
> =A0drivers/spi/xilinx_spi_of.c =A0 | =A0 =A02 +-
> =A0include/linux/spi/dw_spi.h =A0 =A0| =A0 =A01 +
> =A017 files changed, 2024 insertions(+), 85 deletions(-)
> =A0create mode 100644 drivers/spi/coldfire_qspi.c
> =A0create mode 100644 drivers/spi/davinci_spi.c
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
