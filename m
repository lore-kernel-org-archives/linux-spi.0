From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [GIT PULL] spi changes for v3.5 merge window
Date: Thu, 24 May 2012 14:00:48 -0600
Message-ID: <CACxGe6vc0aWuRuiwBqd-bed45EN3VWB2p9PWYLi_yP5onrtGTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

Description below; please pull.

Thanks,
g.

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 tags/spi-for-linus

for you to fetch changes up to 1e8a52e18cfb381bc9cc1f0b720540364d2a6edd:

  spi: By default setup spi_masters with 1 chipselect and dynamics bus
number (2012-05-19 23:42:08 -0600)

----------------------------------------------------------------
SPI changes for v3.5 merge window

Bug fixes and new features for SPI device drivers.  Also move device
tree support code out of drivers/of and into drivers/spi/spi.c where
it makes more sense.

----------------------------------------------------------------
Arnd Bergmann (1):
      spi/topcliff: use correct __devexit_p annotation

Axel Lin (1):
      spi: use module_pci_driver

Barry Song (1):
      SPI: PRIMA2: use the newest APIs of PINCTRL to fix compiling errors

Benoit Cousson (1):
      spi/omap: Remove bus_num usage for instance index

Felipe Balbi (2):
      spi: omap2-mcspi: make it behave as a module
      spi: omap2-mcspi: convert to module_platform_driver

Grant Likely (4):
      Merge branch 'spi' of git://gitorious.org/linus-tree/linus-tree
into spi/next
      spi/devicetree: Move devicetree support code into spi directory
      Merge tag 'v3.4-rc6' into spi/next
      spi: By default setup spi_masters with 1 chipselect and dynamics
bus number

Hannu Heikkinen (1):
      spi/ep93xx: clean probe/remove routines

Herton Ronaldo Krzesinski (1):
      spi/spi-fsl-spi: reference correct pdata in fsl_spi_cs_control

Shimoda, Yoshihiro (1):
      spi/rspi: add dmaengine support

Shubhrajyoti D (5):
      OMAP : SPI : use devm_* functions
      spi: omap2-mcspi: add support for pm_runtime autosuspend
      spi/omap2-mcspi: Trivial optimisation
      spi: Dont call prepare/unprepare transfer if not populated
      spi/omap2-mcspi: convert to the pump message infrastructure

Steven King (1):
      spi: refactor spi-coldfire-qspi to use SPI queue framework.

 drivers/of/Kconfig              |    6 -
 drivers/of/Makefile             |    1 -
 drivers/of/of_spi.c             |   99 -----------
 drivers/spi/spi-ath79.c         |    3 -
 drivers/spi/spi-coldfire-qspi.c |  255 ++++++++++++--------------
 drivers/spi/spi-dw-pci.c        |   13 +-
 drivers/spi/spi-ep93xx.c        |   37 ++--
 drivers/spi/spi-fsl-espi.c      |    1 -
 drivers/spi/spi-fsl-lib.c       |    2 +-
 drivers/spi/spi-fsl-spi.c       |    2 +-
 drivers/spi/spi-lm70llp.c       |    3 -
 drivers/spi/spi-mpc52xx.c       |    3 -
 drivers/spi/spi-omap2-mcspi.c   |  373 +++++++++++++++++----------------------
 drivers/spi/spi-ppc4xx.c        |    4 -
 drivers/spi/spi-pxa2xx-pci.c    |   12 +-
 drivers/spi/spi-rspi.c          |  320 ++++++++++++++++++++++++++++++++-
 drivers/spi/spi-sirf.c          |   20 +--
 drivers/spi/spi-topcliff-pch.c  |    3 +-
 drivers/spi/spi.c               |   98 +++++++++-
 include/linux/of_spi.h          |   23 ---
 include/linux/spi/rspi.h        |   31 ++++
 21 files changed, 736 insertions(+), 573 deletions(-)
 delete mode 100644 drivers/of/of_spi.c
 delete mode 100644 include/linux/of_spi.h
 create mode 100644 include/linux/spi/rspi.h


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
