From: Juan Gutierrez <juan.gutierrez-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH] spi: use sg_next for walking through the allocated scatterlist table
Date: Mon, 21 Nov 2016 16:50:03 -0600
Message-ID: <1479768603-15583-1-git-send-email-juan.gutierrez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <juan.gutierrez-3arQi8VN3Tc@public.gmane.org>, <yibin.gong-3arQi8VN3Tc@public.gmane.org>,
        <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

A null dereference or Oops exception might occurs when reading at once the
whole content of an spi-nor of big enough size that requires an scatterlist
table that does not fit into one single page.

The spi_map_buf function is ignoring the chained sg case by dereferenceing
the scatterlist elements in an array fashion. This wrongly assumes that
the allocation of the scatterlist elements are contiguous. This is true as
long as the scatterlist table fits within a PAGE_SIZE. However, for
allocation where the scatter table is bigger than that, the pages allocated
by sg_alloc might not be contigous.

The sg table can be properly walked by sg_next instead of using an array.

Signed-off-by: Juan Gutierrez <juan.gutierrez-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 838783c..6435548 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -720,6 +720,7 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 	int desc_len;
 	int sgs;
 	struct page *vm_page;
+	struct scatterlist *sg;
 	void *sg_buf;
 	size_t min;
 	int i, ret;
@@ -738,6 +739,7 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 	if (ret != 0)
 		return ret;
 
+	sg = &sgt->sgl[0];
 	for (i = 0; i < sgs; i++) {
 
 		if (vmalloced_buf || kmap_buf) {
@@ -751,16 +753,17 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 				sg_free_table(sgt);
 				return -ENOMEM;
 			}
-			sg_set_page(&sgt->sgl[i], vm_page,
+			sg_set_page(sg, vm_page,
 				    min, offset_in_page(buf));
 		} else {
 			min = min_t(size_t, len, desc_len);
 			sg_buf = buf;
-			sg_set_buf(&sgt->sgl[i], sg_buf, min);
+			sg_set_buf(sg, sg_buf, min);
 		}
 
 		buf += min;
 		len -= min;
+		sg = sg_next(sg);
 	}
 
 	ret = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
