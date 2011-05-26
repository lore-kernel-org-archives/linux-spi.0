From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [git pull] spi changes for $NEXT_KERNEL
Date: Thu, 26 May 2011 09:48:26 -0600
Message-ID: <BANLkTinDm9Y8yyZwV=MqTAuU4KKNDQRx6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
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

Here are the spi changes for the next release.  Please pull.

Thanks,
g.

The following changes since commit 4db70f73e56961b9bcdfd0c36c62847a18b7dbb5:

  tmpfs: fix XATTR N overriding POSIX_ACL Y (2011-05-25 19:53:02 -0700)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 spi/next

Alek Du (3):
      spi/dw_spi: remove the un-necessary flush()
      spi/dw_spi: change poll mode transfer from byte ops to batch ops
      spi/dw_spi: improve the interrupt mode with the batch ops

Axel Lin (4):
      spi/spi_sh: use spi_unregister_master instead of spi_master_put
in remove path
      spi/spi_tegra: use spi_unregister_master() instead of spi_master_put()
      spi/spi_nuc900: Use spi_bitbang_stop instead of
spi_unregister_master in nuc900_spi_remove
      spi/spi_s3c24xx: Use spi_bitbang_stop instead of
spi_unregister_master in s3c24xx_spi_remove

Feng Tang (1):
      spi/dw_spi: unify the low level read/write routines

Grant Likely (1):
      Merge commit 'v2.6.39' into spi/next

Linus Walleij (2):
      spi/pl022: mark driver non-experimental
      spi/pl022: use cpu_relax in the busy loop

Magnus Templing (1):
      spi/pl022: timeout on polled transfer v2

Mark Brown (1):
      spi: Use void pointers for data in simple SPI I/O operations

Viresh Kumar (1):
      spi/amba-pl022: work in polling or interrupt mode if pl022_dma_probe fails

 drivers/spi/Kconfig       |    4 +-
 drivers/spi/amba-pl022.c  |   35 +++++---
 drivers/spi/dw_spi.c      |  202 +++++++++++++++------------------------------
 drivers/spi/dw_spi.h      |    2 -
 drivers/spi/spi.c         |    4 +-
 drivers/spi/spi_nuc900.c  |    2 +-
 drivers/spi/spi_s3c24xx.c |    2 +-
 drivers/spi/spi_sh.c      |    2 +-
 drivers/spi/spi_tegra.c   |    2 +-
 include/linux/spi/spi.h   |    8 +-
 10 files changed, 100 insertions(+), 163 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
vRanger cuts backup time in half-while increasing security.
With the market-leading solution for virtual backup and recovery, 
you get blazing-fast, flexible, and affordable data protection.
Download your free trial now. 
http://p.sf.net/sfu/quest-d2dcopy1
