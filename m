From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: [PATCH v1] spi: davinci: Support DMA transfers larger than 65535 words
Date: Mon, 14 Mar 2011 11:49:02 -0400
Message-ID: <1300117742-1832-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The current davinci SPI driver, in DMA mode, is limited to 65535
words for a single transfer.  Modify the driver by configuring a
3 dimensional EDMA transfer to support up to 65535x65535
words.

Signed-off-by: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Tested-by: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
---
changes since v0:
   - Added spaces per style guide comments.

This patch is an attempt to address the issue raised here:

http://comments.gmane.org/gmane.linux.davinci/20581

Tested with:
dd if=/dev/mtd7 of=/tmp/test.1K bs=1024 count=1024
dd if=/dev/mtd7 of=/tmp/test.64K bs=65536 count=16
dd if=/dev/mtd7 of=/tmp/test.128K bs=131072 count=8
md5sum /tmp/test*

 drivers/spi/davinci_spi.c |   33 +++++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 037ba82..1f0ed80 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -571,6 +571,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		unsigned long tx_reg, rx_reg;
 		struct edmacc_param param;
 		void *rx_buf;
+		int b, c;
 
 		dma = &dspi->dma;
 
@@ -599,14 +600,30 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			}
 		}
 
+		/*
+		 * If number of words is greater than 65535, then we need
+		 * to configure a 3 dimension transfer.  Use the BCNTRLD
+		 * feature to allow for transfers that aren't even multiples
+		 * of 65535 (or any other possible b size) by first transferring
+		 * the remainder amount then grabbing the next N blocks of
+		 * 65535 words.
+		 */
+
+		c = dspi->wcount / (SZ_64K - 1);	/* N 65535 Blocks */
+		b = dspi->wcount - c * (SZ_64K - 1);	/* Remainder */
+		if (b)
+			c++;
+		else
+			b = SZ_64K - 1;
+
 		param.opt = TCINTEN | EDMA_TCC(dma->tx_channel);
 		param.src = t->tx_buf ? t->tx_dma : tx_reg;
-		param.a_b_cnt = dspi->wcount << 16 | data_type;
+		param.a_b_cnt = b << 16 | data_type;
 		param.dst = tx_reg;
 		param.src_dst_bidx = t->tx_buf ? data_type : 0;
-		param.link_bcntrld = 0xffff;
-		param.src_dst_cidx = 0;
-		param.ccnt = 1;
+		param.link_bcntrld = 0xffffffff;
+		param.src_dst_cidx = t->tx_buf ? data_type : 0;
+		param.ccnt = c;
 		edma_write_slot(dma->tx_channel, &param);
 		edma_link(dma->tx_channel, dma->dummy_param_slot);
 
@@ -643,12 +660,12 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		param.opt = TCINTEN | EDMA_TCC(dma->rx_channel);
 		param.src = rx_reg;
-		param.a_b_cnt = dspi->rcount << 16 | data_type;
+		param.a_b_cnt = b << 16 | data_type;
 		param.dst = t->rx_dma;
 		param.src_dst_bidx = (t->rx_buf ? data_type : 0) << 16;
-		param.link_bcntrld = 0xffff;
-		param.src_dst_cidx = 0;
-		param.ccnt = 1;
+		param.link_bcntrld = 0xffffffff;
+		param.src_dst_cidx = (t->rx_buf ? data_type : 0) << 16;
+		param.ccnt = c;
 		edma_write_slot(dma->rx_channel, &param);
 
 		if (pdata->cshold_bug)
-- 
1.7.0.4
