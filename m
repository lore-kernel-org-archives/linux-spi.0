From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 2/2] spi: imx: dynamic burst length adjust for DMA mode
Date: Wed, 8 Feb 2017 15:20:28 +0900
Message-ID: <20170208062028.22313-3-jiada_wang@mentor.com>
References: <20170208062028.22313-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fixed-term.Oleksij.Rempel@de.bosch.com>, <jiada_wang@mentor.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170208062028.22313-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

previously burst length (BURST_LENGTH) is always set to equal
to bits_per_word, causes a 10us gap between each word in
transfer, which significantly affects performance.

This patch uses 32 bits transfer to simulate lower bits transfer,
and adjusts burst length to reduce the number of gaps in DMA
transfer.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/spi/spi-imx.c | 154 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 130 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 04b4ea8..68ff781 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -39,6 +39,8 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 
+#include <asm/cacheflush.h>
+
 #include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/spi-imx.h>
 
@@ -216,6 +218,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 	unsigned int bpw, i;
+	u32 length, div;
 
 	if (!master->dma_rx)
 		return false;
@@ -232,8 +235,18 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (bpw != 1 && bpw != 2 && bpw != 4)
 		return false;
 
+	length = transfer->len;
+
+	if (spi_imx->dynamic_burst) {
+		bpw = sizeof(u32);
+		length = transfer->len - transfer->len % sizeof(u32);
+		div = length / MX51_ECSPI_CTRL_MAX_BURST  + 1;
+		length = (length / div) - (length / div) % sizeof(u32);
+		spi_imx->count_index = transfer->len - length * div;
+	}
+
 	for (i = spi_imx_get_fifosize(spi_imx) / 2; i > 0; i--) {
-		if (!(transfer->len % (i * bpw)))
+		if (!(length % (i * bpw)))
 			break;
 	}
 
@@ -423,6 +436,7 @@ static int mx51_ecspi_config(struct spi_device *spi,
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
 	u32 clk = config->speed_hz, delay, reg;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
+	u32 div, length;
 
 	/*
 	 * The hardware seems to have a race condition when changing modes. The
@@ -441,9 +455,18 @@ static int mx51_ecspi_config(struct spi_device *spi,
 	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
 
 	if (spi_imx->dynamic_burst) {
-		if (config->len > MX51_ECSPI_CTRL_MAX_BURST)
-			ctrl |= MX51_ECSPI_CTRL_BL_MASK;
-		else
+		if (config->len > MX51_ECSPI_CTRL_MAX_BURST) {
+			if (spi_imx->usedma) {
+				length = config->len -
+					 config->len % sizeof(u32);
+				div = length / MX51_ECSPI_CTRL_MAX_BURST  + 1;
+				length = (length / div) -
+					 (length / div) % sizeof(u32);
+				ctrl |= ((length * 8 - 1) <<
+					MX51_ECSPI_CTRL_BL_OFFSET);
+			} else
+				ctrl |= MX51_ECSPI_CTRL_BL_MASK;
+		} else
 			ctrl |= (((config->len - config->len % 4) * 8 - 1) <<
 				MX51_ECSPI_CTRL_BL_OFFSET);
 	} else
@@ -933,10 +956,16 @@ static int spi_imx_dma_configure(struct spi_master *master,
 		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	case 2:
-		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		if (spi_imx->dynamic_burst)
+			buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		else
+			buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
 	case 1:
-		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		if (spi_imx->dynamic_burst)
+			buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		else
+			buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
 		break;
 	default:
 		return -EINVAL;
@@ -1122,6 +1151,32 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
 }
 
+static int spi_imx_pio_txrx(struct spi_imx_data *spi_imx)
+{
+	unsigned long transfer_timeout;
+	unsigned long timeout;
+
+	spi_imx->txfifo = 0;
+
+	reinit_completion(&spi_imx->xfer_done);
+
+	spi_imx_push(spi_imx);
+
+	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
+
+	transfer_timeout = spi_imx_calculate_timeout(spi_imx, spi_imx->count);
+
+	timeout = wait_for_completion_timeout(&spi_imx->xfer_done,
+					      transfer_timeout);
+	if (!timeout) {
+		dev_err(spi_imx->dev, "I/O Error in PIO\n");
+		spi_imx->devtype_data->reset(spi_imx);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
@@ -1130,6 +1185,20 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	unsigned long timeout;
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
+	unsigned int old_nents = 0;
+	int ret;
+
+	spi_imx->count = transfer->len - spi_imx->count_index;
+	if (spi_imx->dynamic_burst && spi_imx->count_index) {
+		/* Cut RX data tail */
+		old_nents = rx->nents;
+		WARN_ON(sg_dma_len(&rx->sgl[rx->nents - 1]) <
+			spi_imx->count_index);
+		sg_dma_len(&rx->sgl[rx->nents - 1]) -=
+			spi_imx->count_index;
+		if (sg_dma_len(&rx->sgl[rx->nents - 1]) == 0)
+			--rx->nents;
+	}
 
 	/*
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
@@ -1147,6 +1216,30 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	reinit_completion(&spi_imx->dma_rx_completion);
 	dma_async_issue_pending(master->dma_rx);
 
+	if (spi_imx->dynamic_burst) {
+		dma_sync_sg_for_cpu(master->dma_tx->device->dev,
+				    tx->sgl, tx->nents, DMA_TO_DEVICE);
+		if (spi_imx->bpw_w == 1)
+			spi_imx_u32_swap_u8(transfer, (u8 *)transfer->tx_buf);
+		if (spi_imx->bpw_w == 2)
+			spi_imx_u32_swap_u16(transfer,
+				(u16 *)transfer->tx_buf);
+
+		if (spi_imx->count_index) {
+			/* Cut TX data tail */
+			old_nents = tx->nents;
+			WARN_ON(sg_dma_len(&tx->sgl[tx->nents - 1]) <
+				spi_imx->count_index);
+			sg_dma_len(&tx->sgl[tx->nents - 1]) -=
+				spi_imx->count_index;
+			if (sg_dma_len(&tx->sgl[tx->nents - 1]) == 0)
+				--tx->nents;
+		}
+
+		dma_sync_sg_for_device(master->dma_tx->device->dev,
+				       tx->sgl, tx->nents, DMA_TO_DEVICE);
+	}
+
 	desc_tx = dmaengine_prep_slave_sg(master->dma_tx,
 				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -1161,6 +1254,12 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	reinit_completion(&spi_imx->dma_tx_completion);
 	dma_async_issue_pending(master->dma_tx);
 
+	if (spi_imx->dynamic_burst && spi_imx->count_index) {
+		spi_imx->tx_buf = transfer->tx_buf + spi_imx->count;
+		spi_imx->rx_buf = transfer->rx_buf + spi_imx->count;
+		spi_imx->count = spi_imx->count_index;
+	}
+
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
 	/* Wait SDMA to finish the data transfer.*/
@@ -1182,6 +1281,27 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		return -ETIMEDOUT;
 	}
 
+	if (spi_imx->dynamic_burst) {
+		spi_imx->dynamic_burst = 0;
+
+		if (spi_imx->count_index) {
+			ret = spi_imx_pio_txrx(spi_imx);
+			if (ret < 0)
+				return ret;
+		}
+
+		if (spi_imx->bpw_w == 1)
+			spi_imx_u32_swap_u8(transfer, (u8 *)transfer->rx_buf);
+		if (spi_imx->bpw_w == 2)
+			spi_imx_u32_swap_u16(transfer,
+					(u16 *)transfer->rx_buf);
+		dmac_flush_range(transfer->rx_buf,
+				transfer->rx_buf + transfer->len);
+		outer_flush_range(virt_to_phys(transfer->rx_buf),
+				virt_to_phys(transfer->rx_buf) +
+				transfer->len);
+	}
+
 	return transfer->len;
 }
 
@@ -1189,13 +1309,11 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
-	unsigned long transfer_timeout;
-	unsigned long timeout;
+	int ret;
 
 	spi_imx->tx_buf = transfer->tx_buf;
 	spi_imx->rx_buf = transfer->rx_buf;
 	spi_imx->count = transfer->len;
-	spi_imx->txfifo = 0;
 
 	if (spi_imx->dynamic_burst) {
 		spi_imx->count_index =
@@ -1211,21 +1329,9 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 					(u16 *)transfer->tx_buf);
 	}
 
-	reinit_completion(&spi_imx->xfer_done);
-
-	spi_imx_push(spi_imx);
-
-	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
-
-	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
-
-	timeout = wait_for_completion_timeout(&spi_imx->xfer_done,
-					      transfer_timeout);
-	if (!timeout) {
-		dev_err(&spi->dev, "I/O Error in PIO\n");
-		spi_imx->devtype_data->reset(spi_imx);
-		return -ETIMEDOUT;
-	}
+	ret = spi_imx_pio_txrx(spi_imx);
+	if (ret < 0)
+		return ret;
 
 	if (spi_imx->dynamic_burst) {
 		if (spi_imx->bpw_w == 1)
-- 
2.9.3
