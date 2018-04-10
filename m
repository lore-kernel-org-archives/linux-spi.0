From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 02/10] spi: Expose spi_{map,unmap}_buf() for internal use
Date: Wed, 11 Apr 2018 00:44:31 +0200
Message-ID: <20180410224439.9260-3-boris.brezillon@bootlin.com>
References: <20180410224439.9260-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Peter Pan <peterpansjtu@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Sourav Poddar <sourav.poddar@ti.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180410224439.9260-1-boris.brezillon@bootlin.com>
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

spi_{map,unmap}_buf() are needed by the spi-mem logic that is about to
be introduced to prepare data buffer for DMA operations.

Remove the static specifier on these functions and add their prototypes
to include/linux/spi/spi.h. We do not export the symbols here because
both SPI_MEM and SPI can't be enabled as modules and we'd like to
prevent controller/device drivers from using these functions.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
I see 2 other options to not expose internal stuff to spi users or
controller drivers:

1/ we do not expose spi_map/unmap_buf() and instead implement
   spi_controller_dma_map/unmap_mem_op_data() directly in spi.c
2/ we create a new header (drivers/spi/internals.h?) for all
   definitions that are meant for internal use (shared between spi.c
   and spi-mem.c)

I personally prefer #2 as it provides a better separation between spi
and spi-mem code.
---
 drivers/spi/spi.c       | 23 +++++------------------
 include/linux/spi/spi.h | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 24369e437c6b..308e4c2114d8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -740,9 +740,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
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
@@ -821,8 +821,8 @@ static int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
 	return 0;
 }
 
-static void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
-			  struct sg_table *sgt, enum dma_data_direction dir)
+void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
+		   struct sg_table *sgt, enum dma_data_direction dir)
 {
 	if (sgt->orig_nents) {
 		dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
@@ -907,19 +907,6 @@ static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
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
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index bc6bb325d1bf..de6fd95a61c5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -16,6 +16,7 @@
 #define __LINUX_SPI_H
 
 #include <linux/device.h>
+#include <linux/dma-direction.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
@@ -614,6 +615,31 @@ static inline bool spi_controller_is_slave(struct spi_controller *ctlr)
 extern int spi_controller_suspend(struct spi_controller *ctlr);
 extern int spi_controller_resume(struct spi_controller *ctlr);
 
+/*
+ * Helpers needed by the spi-mem logic. Should not be used outside of
+ * spi-mem.c
+ */
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
 /* Calls the driver make to interact with the message queue */
 extern struct spi_message *spi_get_next_queued_message(struct spi_controller *ctlr);
 extern void spi_finalize_current_message(struct spi_controller *ctlr);
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
