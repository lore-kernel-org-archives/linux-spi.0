From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] link dw_spi.o with the kernel objects
Date: Thu, 21 Jan 2010 10:33:53 -0500
Message-ID: <20100121153254.18310.27155.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

The bulk of the dw_spi driver is contained in dw_spi.c, which was statically
linked with the kernel, whether dw_spi_(pci|mmio) was requested to be built
as a module or not. This patch links dw_spi.o with the kernel module.

The kernel objects are renamed to dw_spi_(pic|mmio)_drv.ko in the process.

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/Makefile |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index c3e5ce7..e061b71 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -16,9 +16,10 @@ obj-$(CONFIG_SPI_BFIN)			+= spi_bfin5xx.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_AU1550)		+= au1550_spi.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
-obj-$(CONFIG_SPI_DESIGNWARE)		+= dw_spi.o
-obj-$(CONFIG_SPI_DW_PCI)		+= dw_spi_pci.o
-obj-$(CONFIG_SPI_DW_MMIO)		+= dw_spi_mmio.o
+obj-$(CONFIG_SPI_DW_PCI)		+= dw_spi_pci_drv.o
+dw_spi_pci_drv-objs				:= dw_spi_pci.o dw_spi.o
+obj-$(CONFIG_SPI_DW_MMIO)		+= dw_spi_mmio_drv.o
+dw_spi_mmio_drv-objs			:= dw_spi_mmio.o dw_spi.o
 obj-$(CONFIG_SPI_GPIO)			+= spi_gpio.o
 obj-$(CONFIG_SPI_IMX)			+= spi_imx.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi_lm70llp.o


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
