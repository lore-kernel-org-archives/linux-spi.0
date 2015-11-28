From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] spi: dw-mid: constify dw_spi_dma_ops structure
Date: Sat, 28 Nov 2015 15:09:38 +0100
Message-ID: <1448719778-32271-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The dw_spi_dma_ops structure is never modified, so declare it as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/spi/spi-dw-mid.c |    2 +-
 drivers/spi/spi-dw.h     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index bb1052e..9185f6c 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -283,7 +283,7 @@ static void mid_spi_dma_stop(struct dw_spi *dws)
 	}
 }
 
-static struct dw_spi_dma_ops mid_dma_ops = {
+static const struct dw_spi_dma_ops mid_dma_ops = {
 	.dma_init	= mid_spi_dma_init,
 	.dma_exit	= mid_spi_dma_exit,
 	.dma_setup	= mid_spi_dma_setup,
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 35589a2..61bc3cb 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -130,7 +130,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
-	struct dw_spi_dma_ops	*dma_ops;
+	const struct dw_spi_dma_ops *dma_ops;
 	void			*dma_tx;
 	void			*dma_rx;
 

