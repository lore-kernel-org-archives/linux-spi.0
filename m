From: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2] spi: add support for aeroflex gaisler spimctrl
Date: Sat, 30 Apr 2011 15:11:52 +0200
Message-ID: <1304169112-11224-1-git-send-email-jan@gaisler.com>
References: <1304023295-5829-1-git-send-email-jan@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1304023295-5829-1-git-send-email-jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch adds support for Aeroflex Gaisler SPI memory controller (SPIMCTRL).
SPIMCTRL memory maps a SPI flash device into AMBA address space. The core
also has a register interface where any command can be sent to the device.

The controller is typically found on LEON/GRLIB SoCs.

Tested on GR-LEON4-ITX development board.

Patch is against spi/next.

Signed-off-by: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
---

Changes in V2:
* Use IRQF_SHARED and check in interrupt handler if DONE flag is set,
  otherwise return IRQ_NONE
* Rename driver to match name of other LEON/GRLIB drivers
* Fixes after comments from Grant Likely:
** Fix inconsistent whitespace in Kconfig entry
** Use of_node_get() when assigning hw->bitbang.master->dev.of_node
** Use platform_get_resource() instead of hardcoding the offset into the
   resource table
---
 drivers/spi/Kconfig  |    8 ++++++++
 drivers/spi/Makefile |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fc14b8d..be53561 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -53,6 +53,14 @@ if SPI_MASTER
 
 comment "SPI Master Controller Drivers"
 
+config SPI_GRLIB_SPIMCTRL
+	tristate "Aeroflex Gaisler SPI memory controller"
+	depends on SPARC_LEON
+	select SPI_BITBANG
+	help
+	  This is the driver for Aeroflex Gaisler's SPI memory controller
+	  (SPIMCTRL) found on some LEON/GRLIB SoCs.
+
 config SPI_ALTERA
 	tristate "Altera SPI Controller"
 	select SPI_BITBANG
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index fd2fc5f..a528000 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -9,6 +9,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 
 # SPI master controller drivers (bus)
+obj-$(CONFIG_SPI_GRLIB_SPIMCTRL)	+= grlib_spimctrl.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi_altera.o
 obj-$(CONFIG_SPI_ATMEL)			+= atmel_spi.o
 obj-$(CONFIG_SPI_ATH79)			+= ath79_spi.o
-- 
1.7.0.4


------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
