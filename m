From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: respect the maximum segment size of DMA device
Date: Wed,  9 Mar 2016 11:20:00 +0200
Message-ID: <1457515200-111327-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The device which is actually does DMA may have a limitation of the maximum
segment size. Respect this setting when preparing scatter-gather list.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 082a1c1..1634332 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -702,6 +702,7 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 		       enum dma_data_direction dir)
 {
 	const bool vmalloced_buf = is_vmalloc_addr(buf);
+	unsigned int max_seg_size = dma_get_max_seg_size(dev);
 	int desc_len;
 	int sgs;
 	struct page *vm_page;
@@ -710,10 +711,10 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 	int i, ret;
 
 	if (vmalloced_buf) {
-		desc_len = PAGE_SIZE;
+		desc_len = min_t(int, max_seg_size, PAGE_SIZE);
 		sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
 	} else {
-		desc_len = master->max_dma_len;
+		desc_len = min_t(int, max_seg_size, master->max_dma_len);
 		sgs = DIV_ROUND_UP(len, desc_len);
 	}
 
@@ -739,7 +740,6 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 			sg_set_buf(&sgt->sgl[i], sg_buf, min);
 		}
 
-
 		buf += min;
 		len -= min;
 	}
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
