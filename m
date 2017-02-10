From: Frode Isaksen <fisaksen@baylibre.com>
Subject: [PATCH 4/8] spi: davinci: flush caches when performing DMA
Date: Fri, 10 Feb 2017 16:29:40 +0100
Message-ID: <1486740584-17875-5-git-send-email-fisaksen@baylibre.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Frode Isaksen <fisaksen@baylibre.com>, broonie@kernel.org,
 linux-spi@vger.kernel.org
To: nsekhar@ti.com, khilman@baylibre.com, ptitiano@baylibre.com,
 linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This CPU has VIVT caches, so need to flush the
cache for vmalloc'ed buffers, since the address
may be aliased (same phyiscal address used by
multiple virtual addresses).
This fixes errors when mounting and reading/writing
UBIFS volumes with SPI flash.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f1b46f6..c735425 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -29,6 +29,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/slab.h>
+#include <asm/cacheflush.h>
 
 #include <linux/platform_data/spi-davinci.h>
 
@@ -676,7 +677,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			}
 			sg_dma_address(&sg_rx) = t->rx_dma;
 			sg_dma_len(&sg_rx) = t->len;
-		}
+		} else if (is_vmalloc_addr(t->rx_buf))
+			/* VIVT cache, flush since aliased address */
+			flush_kernel_vmap_range((void *)t->rx_buf, t->len);
 
 		sg_init_table(&sg_tx, 1);
 		if (!t->tx_buf) {
@@ -688,7 +691,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			}
 			sg_dma_address(&sg_tx) = t->tx_dma;
 			sg_dma_len(&sg_tx) = t->len;
-		}
+		} else if (is_vmalloc_addr(t->tx_buf))
+			/* VIVT cache, flush since aliased address */
+			flush_kernel_vmap_range((void *)t->tx_buf, t->len);
 
 		rxdesc = dmaengine_prep_slave_sg(dspi->dma_rx,
 				t->rx_sg.sgl ?: &sg_rx, t->rx_sg.nents ?: 1,
@@ -741,6 +746,10 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		if (!t->rx_buf)
 			dma_unmap_single(&spi->dev, t->rx_dma,
 					t->len, DMA_FROM_DEVICE);
+		else if (is_vmalloc_addr(t->rx_buf))
+			/* VIVT cache, invalidate since aliased address */
+			invalidate_kernel_vmap_range((void *)t->rx_buf, t->len);
+
 		if (!t->tx_buf)
 			dma_unmap_single(&spi->dev, t->tx_dma,
 					t->len, DMA_TO_DEVICE);
-- 
2.7.4
