From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] spi/topcliff_pch: Fix potential NULL dereference on allocation error
Date: Wed, 23 Jan 2019 20:00:22 +0800
Message-ID: <20190123120022.14008-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In pch_spi_handle_dma, it doesn't check for NULL returns of kcalloc
so it would result in an Oops.

Fixes: c37f3c2749b5 ("spi/topcliff_pch: DMA support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/spi-topcliff-pch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 97d1375..e7e8ea1 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1008,6 +1008,9 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 
 	/* RX */
 	dma->sg_rx_p = kcalloc(num, sizeof(*dma->sg_rx_p), GFP_ATOMIC);
+	if (!dma->sg_rx_p)
+		return;
+
 	sg_init_table(dma->sg_rx_p, num); /* Initialize SG table */
 	/* offset, length setting */
 	sg = dma->sg_rx_p;
@@ -1068,6 +1071,9 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 	}
 
 	dma->sg_tx_p = kcalloc(num, sizeof(*dma->sg_tx_p), GFP_ATOMIC);
+	if (!dma->sg_tx_p)
+		return;
+
 	sg_init_table(dma->sg_tx_p, num); /* Initialize SG table */
 	/* offset, length setting */
 	sg = dma->sg_tx_p;
-- 
2.7.0
