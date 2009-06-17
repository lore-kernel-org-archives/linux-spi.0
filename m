From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: i.MX SPI driver
Date: Wed, 17 Jun 2009 12:40:18 +0200
Message-ID: <1245235220-23816-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Hi David,

The new i.MX SPI driver has been posted twice on the list, I received no
objections from anyone, so please consider pulling the following branch

Thanks,
  Sascha


The following changes since commit 65795efbd380a832ae508b04dba8f8e53f0b84d9:
  Linus Torvalds (1):
        Merge branch 'next-i2c' of git://aeryn.fluff.org.uk/bjdooks/linux

are available in the git repository at:

  git://git.pengutronix.de/git/sha/linux-2.6.git for-david

Sascha Hauer (2):
      remove i.MX SPI driver
      SPI: Add SPI driver for most known i.MX SoCs

 arch/arm/plat-mxc/include/mach/spi.h |   27 +
 drivers/spi/Kconfig                  |    7 +-
 drivers/spi/Makefile                 |    2 +-
 drivers/spi/mxc_spi.c                |  685 +++++++++++++
 drivers/spi/spi_imx.c                | 1779 ----------------------------------
 5 files changed, 717 insertions(+), 1783 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/spi.h
 create mode 100644 drivers/spi/mxc_spi.c
 delete mode 100644 drivers/spi/spi_imx.c



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
