From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: tegra: slink: do not prepare dma transfer with DMA_CTRL_ACK flag
Date: Fri, 23 Nov 2012 14:52:39 +0530
Message-ID: <1353662559-26515-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	<linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Spi starts transfer using dma with DMA_CTRL_ACK which is not require
becasue spi driver does not use completed dma_desc after transfer
done and so it does not ack the dma descriptor. Removing the
DMA_CTRL_ACK flag to avoid memory leak in dma driver.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra20-slink.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 7882b50..5b4c8c8 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -473,7 +473,7 @@ static int tegra_slink_start_tx_dma(struct tegra_slink_data *tspi, int len)
 	INIT_COMPLETION(tspi->tx_dma_complete);
 	tspi->tx_dma_desc = dmaengine_prep_slave_single(tspi->tx_dma_chan,
 				tspi->tx_dma_phys, len, DMA_MEM_TO_DEV,
-				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
+				DMA_PREP_INTERRUPT);
 	if (!tspi->tx_dma_desc) {
 		dev_err(tspi->dev, "Not able to get desc for Tx\n");
 		return -EIO;
@@ -492,7 +492,7 @@ static int tegra_slink_start_rx_dma(struct tegra_slink_data *tspi, int len)
 	INIT_COMPLETION(tspi->rx_dma_complete);
 	tspi->rx_dma_desc = dmaengine_prep_slave_single(tspi->rx_dma_chan,
 				tspi->rx_dma_phys, len, DMA_DEV_TO_MEM,
-				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
+				DMA_PREP_INTERRUPT);
 	if (!tspi->rx_dma_desc) {
 		dev_err(tspi->dev, "Not able to get desc for Rx\n");
 		return -EIO;
-- 
1.7.1.1
