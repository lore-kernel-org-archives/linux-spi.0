From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Fix per-page mapping of unaligned vmalloc-ed buffer" to the spi tree
Date: Tue, 07 Jul 2015 14:58:50 +0100
Message-ID: <E1ZCTOc-0005ny-Ez@finisterre>
References: <1435679317-13431-1-git-send-email-andrew_gabbasov@mentor.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Gabbasov <andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435679317-13431-1-git-send-email-andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Fix per-page mapping of unaligned vmalloc-ed buffer

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 65598c13fd66c3b5eac16d5b8eacc704aa17ce40 Mon Sep 17 00:00:00 2001
From: Andrew Gabbasov <andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Date: Tue, 30 Jun 2015 10:48:37 -0500
Subject: [PATCH] spi: Fix per-page mapping of unaligned vmalloc-ed buffer

spi_map_buf() processes mapping of vmalloc-ed buffers in a special way,
making mapping of every page separately. However, if the buffer is not
aligned to page boundary (e.g. sub-array in a vmalloc-ed array), it
fills the scatter table with page-size unaligned pieces, that cross
page boundaries. This is incorrect and can, for example, cause memory
corruption and various crashes when working with ubifs on spi-nor chips
(though those drivers are themselves buggy in that they should be
providing DMAable memory to the SPI framework).

Fix this by using proper scatter table size and intra-page buffer lengths,
so that the whole buffer splits into separate scatter table entries on
page boundaries.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cf8b91b..27e4f1f1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -476,21 +476,30 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 		       enum dma_data_direction dir)
 {
 	const bool vmalloced_buf = is_vmalloc_addr(buf);
-	const int desc_len = vmalloced_buf ? PAGE_SIZE : master->max_dma_len;
-	const int sgs = DIV_ROUND_UP(len, desc_len);
+	int desc_len;
+	int sgs;
 	struct page *vm_page;
 	void *sg_buf;
 	size_t min;
 	int i, ret;
 
+	if (vmalloced_buf) {
+		desc_len = PAGE_SIZE;
+		sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
+	} else {
+		desc_len = master->max_dma_len;
+		sgs = DIV_ROUND_UP(len, desc_len);
+	}
+
 	ret = sg_alloc_table(sgt, sgs, GFP_KERNEL);
 	if (ret != 0)
 		return ret;
 
 	for (i = 0; i < sgs; i++) {
-		min = min_t(size_t, len, desc_len);
 
 		if (vmalloced_buf) {
+			min = min_t(size_t,
+				    len, desc_len - offset_in_page(buf));
 			vm_page = vmalloc_to_page(buf);
 			if (!vm_page) {
 				sg_free_table(sgt);
@@ -499,6 +508,7 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 			sg_set_page(&sgt->sgl[i], vm_page,
 				    min, offset_in_page(buf));
 		} else {
+			min = min_t(size_t, len, desc_len);
 			sg_buf = buf;
 			sg_set_buf(&sgt->sgl[i], sg_buf, min);
 		}
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
