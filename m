From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 2/5] spi: img-spfi: Implement a prepare_message() callback
Date: Mon,  6 Apr 2015 14:29:04 -0700
Message-ID: <1428355747-16822-2-git-send-email-abrestic@chromium.org>
References: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

In preparation for switching to using the SPI core's CS GPIO handling,
move setup of the PORT_STATE register, which must be configured before
CS is asserted, to a prepare_message() callback.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/spi/spi-img-spfi.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 7d18bec..b1c0165 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -397,6 +397,25 @@ stop_dma:
 	return -EIO;
 }
 
+static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
+{
+	struct img_spfi *spfi = spi_master_get_devdata(master);
+	u32 val;
+
+	val = spfi_readl(spfi, SPFI_PORT_STATE);
+	if (msg->spi->mode & SPI_CPHA)
+		val |= SPFI_PORT_STATE_CK_PHASE(msg->spi->chip_select);
+	else
+		val &= ~SPFI_PORT_STATE_CK_PHASE(msg->spi->chip_select);
+	if (msg->spi->mode & SPI_CPOL)
+		val |= SPFI_PORT_STATE_CK_POL(msg->spi->chip_select);
+	else
+		val &= ~SPFI_PORT_STATE_CK_POL(msg->spi->chip_select);
+	spfi_writel(spfi, val, SPFI_PORT_STATE);
+
+	return 0;
+}
+
 static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
@@ -434,18 +453,6 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 					      &master->cur_msg->transfers))
 		val |= SPFI_CONTROL_CONTINUE;
 	spfi_writel(spfi, val, SPFI_CONTROL);
-
-	val = spfi_readl(spfi, SPFI_PORT_STATE);
-	if (spi->mode & SPI_CPHA)
-		val |= SPFI_PORT_STATE_CK_PHASE(spi->chip_select);
-	else
-		val &= ~SPFI_PORT_STATE_CK_PHASE(spi->chip_select);
-	if (spi->mode & SPI_CPOL)
-		val |= SPFI_PORT_STATE_CK_POL(spi->chip_select);
-	else
-		val &= ~SPFI_PORT_STATE_CK_POL(spi->chip_select);
-	spfi_writel(spfi, val, SPFI_PORT_STATE);
-
 	spfi_writel(spfi, xfer->len << SPFI_TRANSACTION_TSIZE_SHIFT,
 		    SPFI_TRANSACTION);
 }
@@ -599,6 +606,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 
 	master->set_cs = img_spfi_set_cs;
 	master->transfer_one = img_spfi_transfer_one;
+	master->prepare_message = img_spfi_prepare;
 
 	spfi->tx_ch = dma_request_slave_channel(spfi->dev, "tx");
 	spfi->rx_ch = dma_request_slave_channel(spfi->dev, "rx");
-- 
2.2.0.rc0.207.ga3a616c
