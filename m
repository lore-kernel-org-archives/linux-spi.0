From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Expose spi_{map,
 unmap}_buf() for internal use" to the spi tree
Date: Mon, 23 Apr 2018 19:05:43 +0100
Message-ID: <E1fAfqR-0004M5-3E@debutante>
References: <20180422183522.11118-2-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-spi@vger.kernel.org,
 Peter Pan <peterpansjtu@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180422183522.11118-2-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Expose spi_{map,unmap}_buf() for internal use

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 46336966bf0852d76f76c1292c057635b05dbb1b Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@bootlin.com>
Date: Sun, 22 Apr 2018 20:35:14 +0200
Subject: [PATCH] spi: Expose spi_{map,unmap}_buf() for internal use

spi_{map,unmap}_buf() are needed by the spi-mem logic that is about to
be introduced to prepare data buffer for DMA operations.

Remove the static specifier on these functions and add their prototypes
to drivers/spi/internals.h. We do not export the symbols here because
both SPI_MEM and SPI can't be enabled as modules and we'd like to
prevent controller/device drivers from using these functions.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/internals.h | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c       | 25 +++++++------------------
 2 files changed, 48 insertions(+), 18 deletions(-)
 create mode 100644 drivers/spi/internals.h

diff --git a/drivers/spi/internals.h b/drivers/spi/internals.h
new file mode 100644
index 000000000000..dbe56c77b464
--- /dev/null
+++ b/drivers/spi/internals.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 Exceet Electronics GmbH
+ * Copyright (C) 2018 Bootlin
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ *
+ * Helpers needed by the spi or spi-mem logic. Should not be used outside of
+ * spi-mem.c and spi.c.
+ */
+
+#ifndef __LINUX_SPI_INTERNALS_H
+#define __LINUX_SPI_INTERNALS_H
+
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/scatterlist.h>
+#include <linux/spi/spi.h>
+
+#ifdef CONFIG_HAS_DMA
+int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
+		struct sg_table *sgt, void *buf, size_t len,
+		enum dma_data_direction dir);
+void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
+		   struct sg_table *sgt, enum dma_data_direction dir);
+#else /* !CONFIG_HAS_DMA */
+static inline int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
+			      struct sg_table *sgt, void *buf, size_t len,
+			      enum dma_data_direction dir)
+{
+	return -EINVAL;
+}
+
+static inline void spi_unmap_buf(struct spi_controller *ctlr,
+				 struct device *dev, struct sg_table *sgt,
+				 enum dma_data_direction dir)
+{
+}
+#endif /* CONFIG_HAS_DMA */
+
+#endif /* __LINUX_SPI_INTERNALS_H */
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7b213faa0a2b..86b778d8563e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -46,6 +46,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
 
+#include "internals.h"
+
 static DEFINE_IDR(spi_master_idr);
 
 static void spidev_release(struct device *dev)
@@ -740,9 +742,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 }
 
 #ifdef CONFIG_HAS_DMA
-static int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
-		       struct sg_table *sgt, void *buf, size_t len,
-		       enum dma_data_direction dir)
+int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
+		struct sg_table *sgt, void *buf, size_t len,
+		enum dma_data_direction dir)
 {
 	const bool vmalloced_buf = is_vmalloc_addr(buf);
 	unsigned int max_seg_size = dma_get_max_seg_size(dev);
@@ -821,8 +823,8 @@ static int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
 	return 0;
 }
 
-static void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
-			  struct sg_table *sgt, enum dma_data_direction dir)
+void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
+		   struct sg_table *sgt, enum dma_data_direction dir)
 {
 	if (sgt->orig_nents) {
 		dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
@@ -907,19 +909,6 @@ static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	return 0;
 }
 #else /* !CONFIG_HAS_DMA */
-static inline int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
-			      struct sg_table *sgt, void *buf, size_t len,
-			      enum dma_data_direction dir)
-{
-	return -EINVAL;
-}
-
-static inline void spi_unmap_buf(struct spi_controller *ctlr,
-				 struct device *dev, struct sg_table *sgt,
-				 enum dma_data_direction dir)
-{
-}
-
 static inline int __spi_map_msg(struct spi_controller *ctlr,
 				struct spi_message *msg)
 {
-- 
2.17.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
