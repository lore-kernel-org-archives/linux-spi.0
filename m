From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 1/2] spi: Fix mapping from vmalloc-ed buffer to scatter list
Date: Mon, 17 Nov 2014 09:14:31 +0000
Message-ID: <1416215672-31554-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Cc: marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We can only use page_address on memory that has been mapped using kmap,
when the buffer passed to the SPI has been allocated by vmalloc the page
has not necessarily been mapped through kmap. This means sometimes
page_address will return NULL causing the pointer we pass to sg_set_buf
to be invalid.

As we only call page_address so that we can pass a virtual address to
sg_set_buf which will then immediately call virt_to_page on it, fix this
by calling sg_set_page directly rather then relying on the sg_set_buf
helper.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/spi/spi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ebcb33d..50f20f2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -615,13 +615,13 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 				sg_free_table(sgt);
 				return -ENOMEM;
 			}
-			sg_buf = page_address(vm_page) +
-				((size_t)buf & ~PAGE_MASK);
+			sg_set_page(&sgt->sgl[i], vm_page,
+				    min, offset_in_page(buf));
 		} else {
 			sg_buf = buf;
+			sg_set_buf(&sgt->sgl[i], sg_buf, min);
 		}
 
-		sg_set_buf(&sgt->sgl[i], sg_buf, min);
 
 		buf += min;
 		len -= min;
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
