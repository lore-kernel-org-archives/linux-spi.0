From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 5/7] mtd: provide helper to prepare buffers
 for DMA operations
Date: Wed, 30 Mar 2016 17:39:52 +0200
Message-ID: <1459352394-22810-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1459352394-22810-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Dave Gordon <david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBUPG563QKGQENBDSJAQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1459352394-22810-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Some NAND controller drivers are making use of DMA to transfer data from
the controller to the buffer passed by the MTD user.
Provide a generic mtd_map/unmap_buf() implementation to avoid open coded
(and sometime erroneous) implementations.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mtd/mtdcore.c   | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h | 25 +++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3096251..3c368f0 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1253,6 +1253,72 @@ void *mtd_kmalloc_up_to(const struct mtd_info *mtd, size_t *size)
 }
 EXPORT_SYMBOL_GPL(mtd_kmalloc_up_to);
 
+#ifdef CONFIG_HAS_DMA
+/**
+ * mtd_map_buf - create an SG table and prepare it for DMA operations
+ *
+ * @mtd: mtd device description object pointer
+ * @dev: device handling the DMA operation
+ * @buf: buf used to create the SG table
+ * @len: length of buf
+ * @constraints: optional constraints to take into account when creating
+ *		 the SG table. Can be NULL if no specific constraints
+ *		 are required.
+ * @dir: direction of the DMA operation
+ *
+ * This function should be used when an MTD driver wants to do DMA operations
+ * on a buffer passed by the MTD layer. This functions takes care of
+ * vmallocated buffer constraints, and return and sg_table that you can safely
+ * use.
+ */
+int mtd_map_buf(struct mtd_info *mtd, struct device *dev,
+		struct sg_table *sgt, const void *buf, size_t len,
+		const struct sg_constraints *constraints,
+		enum dma_data_direction dir)
+{
+	int ret;
+
+	ret = sg_alloc_table_from_buf(sgt, buf, len, constraints, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	ret = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
+	if (!ret)
+		ret = -ENOMEM;
+
+	if (ret < 0) {
+		sg_free_table(sgt);
+		return ret;
+	}
+
+	sgt->nents = ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtd_map_buf);
+
+/**
+ * mtd_map_buf - unmap an SG table and release its resources
+ *
+ * @mtd: mtd device description object pointer
+ * @dev: device handling the DMA operation
+ * @sgt: SG table
+ * @dir: direction of the DMA operation
+ *
+ * This function unmaps a previously mapped SG table and release SG table
+ * resources. Should be called when your DMA operation is done.
+ */
+void mtd_unmap_buf(struct mtd_info *mtd, struct device *dev,
+		   struct sg_table *sgt, enum dma_data_direction dir)
+{
+	if (sgt->orig_nents) {
+		dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
+		sg_free_table(sgt);
+	}
+}
+EXPORT_SYMBOL_GPL(mtd_unmap_buf);
+#endif /* !CONFIG_HAS_DMA */
+
 #ifdef CONFIG_PROC_FS
 
 /*====================================================================*/
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 7712721..15cff85 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -24,6 +24,7 @@
 #include <linux/uio.h>
 #include <linux/notifier.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 
 #include <mtd/mtd-abi.h>
 
@@ -410,6 +411,30 @@ extern void register_mtd_user (struct mtd_notifier *new);
 extern int unregister_mtd_user (struct mtd_notifier *old);
 void *mtd_kmalloc_up_to(const struct mtd_info *mtd, size_t *size);
 
+#ifdef CONFIG_HAS_DMA
+int mtd_map_buf(struct mtd_info *mtd, struct device *dev,
+		struct sg_table *sgt, const void *buf, size_t len,
+		const struct sg_constraints *constraints,
+		enum dma_data_direction dir);
+void mtd_unmap_buf(struct mtd_info *mtd, struct device *dev,
+		   struct sg_table *sgt, enum dma_data_direction dir);
+#else
+static inline int mtd_map_buf(struct mtd_info *mtd, struct device *dev,
+			      struct sg_table *sgt, const void *buf,
+			      size_t len,
+			      const struct sg_constraints *constraints
+			      enum dma_data_direction dir)
+{
+	return -ENOTSUPP;
+}
+
+static void mtd_unmap_buf(struct mtd_info *mtd, struct device *dev,
+			  struct sg_table *sgt, enum dma_data_direction dir)
+{
+	return -ENOTSUPP;
+}
+#endif
+
 void mtd_erase_callback(struct erase_info *instr);
 
 static inline int mtd_is_bitflip(int err) {
-- 
2.5.0
