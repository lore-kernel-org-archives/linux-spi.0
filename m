From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi_dw: move spi_dw_chip definition to a header file in
	include/linux/spi/
Date: Thu,  8 Sep 2011 15:23:35 +0800
Message-ID: <1315466615-6043-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
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

So that it could be used to setup slave device's platform data, when platform
boot code enumerates and registers those spi slave devices.

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-dw.h                |   20 +-------------------
 include/linux/spi/spi-dw-platform.h |   23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/spi/spi-dw-platform.h

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 8b7b07b..290688f 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -3,6 +3,7 @@
 
 #include <linux/io.h>
 #include <linux/scatterlist.h>
+#include <linux/spi/spi-dw-platform.h>
 
 /* Bit fields in CTRLR0 */
 #define SPI_DFS_OFFSET			0
@@ -49,12 +50,6 @@
 /* TX RX interrupt level threshold, max can be 256 */
 #define SPI_INT_THRESHOLD		32
 
-enum dw_ssi_type {
-	SSI_MOTO_SPI = 0,
-	SSI_TI_SSP,
-	SSI_NS_MICROWIRE,
-};
-
 struct dw_spi_reg {
 	u32	ctrl0;
 	u32	ctrl1;
@@ -209,19 +204,6 @@ static inline void spi_umask_intr(struct dw_spi *dws, u32 mask)
 	dw_writel(dws, imr, new_mask);
 }
 
-/*
- * Each SPI slave device to work with dw_api controller should
- * has such a structure claiming its working mode (PIO/DMA etc),
- * which can be save in the "controller_data" member of the
- * struct spi_device
- */
-struct dw_spi_chip {
-	u8 poll_mode;	/* 0 for contoller polling mode */
-	u8 type;	/* SPI/SSP/Micrwire */
-	u8 enable_dma;
-	void (*cs_control)(u32 command);
-};
-
 extern int dw_spi_add_host(struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
diff --git a/include/linux/spi/spi-dw-platform.h b/include/linux/spi/spi-dw-platform.h
new file mode 100644
index 0000000..7c283c6
--- /dev/null
+++ b/include/linux/spi/spi-dw-platform.h
@@ -0,0 +1,23 @@
+#ifndef SPI_DW_PLATFORM_HEADER_H
+#define SPI_DW_PLATFORM_HEADER_H
+
+enum dw_ssi_type {
+	SSI_MOTO_SPI = 0,
+	SSI_TI_SSP,
+	SSI_NS_MICROWIRE,
+};
+
+/*
+ * Each SPI slave device to work with dw_api controller should
+ * has such a structure claiming its working mode (PIO/DMA etc),
+ * which can be save in the "controller_data" member of the
+ * struct spi_device
+ */
+struct dw_spi_chip {
+	u8 poll_mode;	/* 0 for contoller polling mode */
+	u8 type;	/* SPI/SSP/Micrwire */
+	u8 enable_dma;
+	void (*cs_control)(u32 command);
+};
+
+#endif /* SPI_DW_PLATFORM_HEADER_H */
-- 
1.7.1


------------------------------------------------------------------------------
Doing More with Less: The Next Generation Virtual Desktop 
What are the key obstacles that have prevented many mid-market businesses
from deploying virtual desktops?   How do next-generation virtual desktops
provide companies an easier-to-deploy, easier-to-manage and more affordable
virtual desktop model.http://www.accelacomm.com/jaw/sfnl/114/51426474/
