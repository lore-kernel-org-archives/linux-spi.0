From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Subject: [PATCH 1/5 v2] spi-topcliff-pch: add tx-memory clear after complete transmitting
Date: Tue,  6 Sep 2011 17:16:34 +0900
Message-ID: <1315296998-7296-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Cc: qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com,
	kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currently, in case of reading date from SPI flash,
command is sent twice.
The cause is that tx-memory clear processing is missing .
This patch adds the tx-momory clear processing.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
---
v2: v1 patch series are included invalid patch file
---
 drivers/spi/spi-topcliff-pch.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 1d23f38..7a98caa 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -837,6 +837,11 @@ static void pch_spi_start_transfer(struct pch_spi_data *data)
 
 	dma_sync_sg_for_cpu(&data->master->dev, dma->sg_rx_p, dma->nent,
 			    DMA_FROM_DEVICE);
+
+	dma_sync_sg_for_cpu(&data->master->dev, dma->sg_tx_p, dma->nent,
+			    DMA_FROM_DEVICE);
+	memset(data->dma.tx_buf_virt, 0, PAGE_SIZE);
+
 	async_tx_ack(dma->desc_rx);
 	async_tx_ack(dma->desc_tx);
 	kfree(dma->sg_tx_p);
-- 
1.7.4.4
