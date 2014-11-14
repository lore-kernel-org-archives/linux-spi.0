From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 2/2] ASoC: wm_adsp: Use vmalloc to allocate firmware download buffer
Date: Fri, 14 Nov 2014 15:40:45 +0000
Message-ID: <1415979645-26264-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1415979645-26264-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415979645-26264-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use vmalloc to allocate the buffer for firmware/coefficient download and
rely on the SPI core to split this up into DMA-able chunks. This should
give better performance and means we no longer need to manually split
the download into page size chunks to avoid allocating overly large
continuous memory regions.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 sound/soc/codecs/wm_adsp.c |   58 +++++++++++++++++--------------------------
 1 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f412a99..0a08ef5e 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -21,6 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -169,11 +170,12 @@ static struct wm_adsp_buf *wm_adsp_buf_alloc(const void *src, size_t len,
 	if (buf == NULL)
 		return NULL;
 
-	buf->buf = kmemdup(src, len, GFP_KERNEL | GFP_DMA);
+	buf->buf = vmalloc(len);
 	if (!buf->buf) {
-		kfree(buf);
+		vfree(buf);
 		return NULL;
 	}
+	memcpy(buf->buf, src, len);
 
 	if (list)
 		list_add_tail(&buf->list, list);
@@ -188,7 +190,7 @@ static void wm_adsp_buf_free(struct list_head *list)
 							   struct wm_adsp_buf,
 							   list);
 		list_del(&buf->list);
-		kfree(buf->buf);
+		vfree(buf->buf);
 		kfree(buf);
 	}
 }
@@ -684,38 +686,24 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		}
 
 		if (reg) {
-			size_t to_write = PAGE_SIZE;
-			size_t remain = le32_to_cpu(region->len);
-			const u8 *data = region->data;
-
-			while (remain > 0) {
-				if (remain < PAGE_SIZE)
-					to_write = remain;
-
-				buf = wm_adsp_buf_alloc(data,
-							to_write,
-							&buf_list);
-				if (!buf) {
-					adsp_err(dsp, "Out of memory\n");
-					ret = -ENOMEM;
-					goto out_fw;
-				}
-
-				ret = regmap_raw_write_async(regmap, reg,
-							     buf->buf,
-							     to_write);
-				if (ret != 0) {
-					adsp_err(dsp,
-						"%s.%d: Failed to write %zd bytes at %d in %s: %d\n",
-						file, regions,
-						to_write, offset,
-						region_name, ret);
-					goto out_fw;
-				}
+			buf = wm_adsp_buf_alloc(region->data,
+						le32_to_cpu(region->len),
+						&buf_list);
+			if (!buf) {
+				adsp_err(dsp, "Out of memory\n");
+				ret = -ENOMEM;
+				goto out_fw;
+			}
 
-				data += to_write;
-				reg += to_write / 2;
-				remain -= to_write;
+			ret = regmap_raw_write_async(regmap, reg, buf->buf,
+						     le32_to_cpu(region->len));
+			if (ret != 0) {
+				adsp_err(dsp,
+					"%s.%d: Failed to write %d bytes at %d in %s: %d\n",
+					file, regions,
+					le32_to_cpu(region->len), offset,
+					region_name, ret);
+				goto out_fw;
 			}
 		}
 
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
