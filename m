From: Andrew Gabbasov <andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Fix per-page mapping of unaligned vmalloc-ed buffer
Date: Mon, 1 Jun 2015 05:14:36 -0500
Message-ID: <1433153676-18229-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi_map_buf() processes mapping of vmalloc-ed buffers in a special way,
making mapping of every page separately. However, if the buffer is not
aligned to page boundary (e.g. sub-array in a vmalloc-ed array), it
fills the scatter table with page-size unaligned pieces, that cross
page boundaries. This is incorrect and can, for example, cause memory
corruption and various crashes when working with ubifs on spi-nor chips.

Fix this by using proper scatter table size and intra-page buffer lengths,
so that the whole buffer splits into separate scatter table entries on
page boundaries.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 50910d8..14016dc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -477,7 +477,9 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 {
 	const bool vmalloced_buf = is_vmalloc_addr(buf);
 	const int desc_len = vmalloced_buf ? PAGE_SIZE : master->max_dma_len;
-	const int sgs = DIV_ROUND_UP(len, desc_len);
+	const int sgs = DIV_ROUND_UP(vmalloced_buf ?
+					len + offset_in_page(buf) : len,
+				     desc_len);
 	struct page *vm_page;
 	void *sg_buf;
 	size_t min;
@@ -488,9 +490,10 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 		return ret;
 
 	for (i = 0; i < sgs; i++) {
-		min = min_t(size_t, len, desc_len);
 
 		if (vmalloced_buf) {
+			min = min_t(size_t,
+				    len, desc_len - offset_in_page(buf));
 			vm_page = vmalloc_to_page(buf);
 			if (!vm_page) {
 				sg_free_table(sgt);
@@ -499,6 +502,7 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 			sg_set_page(&sgt->sgl[i], vm_page,
 				    min, offset_in_page(buf));
 		} else {
+			min = min_t(size_t, len, desc_len);
 			sg_buf = buf;
 			sg_set_buf(&sgt->sgl[i], sg_buf, min);
 		}
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
