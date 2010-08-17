From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] SPI: remove superfluous DMA buffer syncs on PL022
Date: Wed, 18 Aug 2010 00:08:44 +0200
Message-ID: <1282082924-25809-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yuanyabin1978@sina.com, Dan Williams <dan.j.williams@intel.com>,
	Russell King <linux@arm.linux.org.uk>,
	Linus Walleij <linus.walleij@stericsson.com>,
	linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This removes the superfluous DMA buffer syncs identified by Russell
in the DMA support for PL022.

Cc: yuanyabin1978@sina.com
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/spi/amba-pl022.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 59b3948..521d3d9 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -794,12 +794,7 @@ static void dma_callback(void *data)
 	struct pl022 *pl022 = data;
 	struct spi_message *msg = pl022->cur_msg;
 
-	/* Sync in RX buffer to CPU */
 	BUG_ON(!pl022->sgt_rx.sgl);
-	dma_sync_sg_for_cpu(&pl022->adev->dev,
-			    pl022->sgt_rx.sgl,
-			    pl022->sgt_rx.nents,
-			    DMA_FROM_DEVICE);
 
 #ifdef VERBOSE_DEBUG
 	/*
@@ -812,6 +807,11 @@ static void dma_callback(void *data)
 		struct scatterlist *sg;
 		unsigned int i;
 
+		dma_sync_sg_for_cpu(&pl022->adev->dev,
+				    pl022->sgt_rx.sgl,
+				    pl022->sgt_rx.nents,
+				    DMA_FROM_DEVICE);
+
 		for_each_sg(pl022->sgt_rx.sgl, sg, pl022->sgt_rx.nents, i) {
 			dev_dbg(&pl022->adev->dev, "SPI RX SG ENTRY: %d", i);
 			print_hex_dump(KERN_ERR, "SPI RX: ",
@@ -1001,12 +1001,6 @@ static int configure_dma(struct pl022 *pl022)
 	if (sglen != pages)
 		goto err_tx_sgmap;
 
-	/* Synchronize the TX scatterlist, invalidate buffers, caches etc */
-	dma_sync_sg_for_device(&pl022->adev->dev,
-			       pl022->sgt_tx.sgl,
-			       pl022->sgt_tx.nents,
-			       DMA_TO_DEVICE);
-
 	/* Send both scatterlists */
 	rxdesc = rxchan->device->device_prep_slave_sg(rxchan,
 				      pl022->sgt_rx.sgl,
-- 
1.6.3.3
