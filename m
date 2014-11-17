From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 2/2] spi: spi-mxs: Fix mapping from vmalloc-ed buffer to scatter list
Date: Mon, 17 Nov 2014 09:14:32 +0000
Message-ID: <1416215672-31554-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1416215672-31554-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Cc: marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416215672-31554-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We can only use page_address on memory that has been mapped using kmap,
when the buffer passed to the SPI has been allocated by vmalloc the page
has not necessarily been mapped through kmap. This means sometimes
page_address will return NULL causing the pointer we pass to sg_init_one
to be invalid. Currently, this issue doesn't show up on the MXS
architecture as the defconfig defines CONFIG_HIGHMEM=n which means all
pages are mapped. For the sake of robustness though it is best to
correct the issue.

As we only call page_address so that we can pass a virtual address to
sg_init_one which will eventually call virt_to_page on it, fix this
by calling sg_set_page directly rather then relying on the sg_init_one
helper.

Note this patch is only build tested as I don't have an MXS system to
test on.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/spi/spi-mxs.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index a9e72f9..06a1154 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -182,7 +182,6 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 	int min, ret;
 	u32 ctrl0;
 	struct page *vm_page;
-	void *sg_buf;
 	struct {
 		u32			pio[4];
 		struct scatterlist	sg;
@@ -232,13 +231,14 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 				ret = -ENOMEM;
 				goto err_vmalloc;
 			}
-			sg_buf = page_address(vm_page) +
-				((size_t)buf & ~PAGE_MASK);
+
+			sg_init_table(&dma_xfer[sg_count].sg, 1);
+			sg_set_page(&dma_xfer[sg_count].sg, vm_page,
+				    min, offset_in_page(buf));
 		} else {
-			sg_buf = buf;
+			sg_init_one(&dma_xfer[sg_count].sg, buf, min);
 		}
 
-		sg_init_one(&dma_xfer[sg_count].sg, sg_buf, min);
 		ret = dma_map_sg(ssp->dev, &dma_xfer[sg_count].sg, 1,
 			(flags & TXRX_WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
