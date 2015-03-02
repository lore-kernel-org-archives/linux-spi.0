From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 3/9] spi: dw-mid: convert value of dma_width to enum dma_slave_buswidth
Date: Mon,  2 Mar 2015 20:16:00 +0200
Message-ID: <1425320166-13788-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425320166-13788-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425320166-13788-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

DMAEngine has a specific type to be used for bus width. This patch converts the
code to use the values of the specific type when configure DMA transfer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 13 +++++++++++--
 drivers/spi/spi-dw.c     | 12 ++++++++----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index c8416ef..25c8fa7 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -100,6 +100,15 @@ static void mid_spi_dma_exit(struct dw_spi *dws)
 	dma_release_channel(dws->rxchan);
 }
 
+static enum dma_slave_buswidth convert_dma_width(u32 dma_width) {
+	if (dma_width == 1)
+		return DMA_SLAVE_BUSWIDTH_1_BYTE;
+	else if (dma_width == 2)
+		return DMA_SLAVE_BUSWIDTH_2_BYTES;
+
+	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+}
+
 /*
  * dws->dma_chan_busy is set before the dma transfer starts, callback for tx
  * channel will clear a corresponding bit.
@@ -126,7 +135,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws)
 	txconf.dst_addr = dws->dma_addr;
 	txconf.dst_maxburst = LNW_DMA_MSIZE_16;
 	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	txconf.dst_addr_width = dws->dma_width;
+	txconf.dst_addr_width = convert_dma_width(dws->dma_width);
 	txconf.device_fc = false;
 
 	dmaengine_slave_config(dws->txchan, &txconf);
@@ -175,7 +184,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws)
 	rxconf.src_addr = dws->dma_addr;
 	rxconf.src_maxburst = LNW_DMA_MSIZE_16;
 	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	rxconf.src_addr_width = dws->dma_width;
+	rxconf.src_addr_width = convert_dma_width(dws->dma_width);
 	rxconf.device_fc = false;
 
 	dmaengine_slave_config(dws->rxchan, &rxconf);
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 950bc50..f3e4092 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -315,7 +315,6 @@ static int dw_spi_transfer_one(struct spi_master *master,
 {
 	struct dw_spi *dws = spi_master_get_devdata(master);
 	struct chip_data *chip = spi_get_ctldata(spi);
-	u8 bits = 0;
 	u8 imask = 0;
 	u8 cs_change = 0;
 	u16 txlevel = 0;
@@ -357,9 +356,14 @@ static int dw_spi_transfer_one(struct spi_master *master,
 		}
 	}
 	if (transfer->bits_per_word) {
-		bits = transfer->bits_per_word;
-		dws->n_bytes = dws->dma_width = bits >> 3;
-		cr0 = (bits - 1)
+		if (transfer->bits_per_word == 8) {
+			dws->n_bytes = 1;
+			dws->dma_width = 1;
+		} else if (transfer->bits_per_word == 16) {
+			dws->n_bytes = 2;
+			dws->dma_width = 2;
+		}
+		cr0 = (transfer->bits_per_word - 1)
 			| (chip->type << SPI_FRF_OFFSET)
 			| (spi->mode << SPI_MODE_OFFSET)
 			| (chip->tmode << SPI_TMOD_OFFSET);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
