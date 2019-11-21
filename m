From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3] spi: pic32: Retire dma_request_slave_channel_compat()
Date: Thu, 21 Nov 2019 11:27:03 +0200
Message-ID: <20191121092703.30465-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
To: <broonie@kernel.org>, <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

There is no reason to use the dma_request_slave_channel_compat() as no
filter function and parameter is provided.

Switch the driver to use dma_request_chan() instead and add support for
deferred probing against DMA channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v2:
- Fix copy-paste typo for TX channel request error

Changes since v1:
- Handle deferred probing against DMA channel request.

Trying to crack down on the use of dma_request_slave_channel_compat() in the
tree...

Only compile tested!

Regards,
Peter

 drivers/spi/spi-pic32.c | 46 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 69f517ec59c6..156961b4ca86 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -606,25 +606,30 @@ static void pic32_spi_cleanup(struct spi_device *spi)
 	gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 }
 
-static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
+static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 {
 	struct spi_master *master = pic32s->master;
-	dma_cap_mask_t mask;
+	int ret = 0;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
+	master->dma_rx = dma_request_chan(dev, "spi-rx");
+	if (IS_ERR(master->dma_rx)) {
+		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER)
+			ret = -EPROBE_DEFER;
+		else
+			dev_warn(dev, "RX channel not found.\n");
 
-	master->dma_rx = dma_request_slave_channel_compat(mask, NULL, NULL,
-							  dev, "spi-rx");
-	if (!master->dma_rx) {
-		dev_warn(dev, "RX channel not found.\n");
+		master->dma_rx = NULL;
 		goto out_err;
 	}
 
-	master->dma_tx = dma_request_slave_channel_compat(mask, NULL, NULL,
-							  dev, "spi-tx");
-	if (!master->dma_tx) {
-		dev_warn(dev, "TX channel not found.\n");
+	master->dma_tx = dma_request_chan(dev, "spi-tx");
+	if (IS_ERR(master->dma_tx)) {
+		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER)
+			ret = -EPROBE_DEFER;
+		else
+			dev_warn(dev, "TX channel not found.\n");
+
+		master->dma_tx = NULL;
 		goto out_err;
 	}
 
@@ -634,14 +639,20 @@ static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 	/* DMA chnls allocated and prepared */
 	set_bit(PIC32F_DMA_PREP, &pic32s->flags);
 
-	return;
+	return 0;
 
 out_err:
-	if (master->dma_rx)
+	if (master->dma_rx) {
 		dma_release_channel(master->dma_rx);
+		master->dma_rx = NULL;
+	}
 
-	if (master->dma_tx)
+	if (master->dma_tx) {
 		dma_release_channel(master->dma_tx);
+		master->dma_tx = NULL;
+	}
+
+	return ret;
 }
 
 static void pic32_spi_dma_unprep(struct pic32_spi *pic32s)
@@ -776,7 +787,10 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware	= pic32_spi_unprepare_hardware;
 
 	/* optional DMA support */
-	pic32_spi_dma_prep(pic32s, &pdev->dev);
+	ret = pic32_spi_dma_prep(pic32s, &pdev->dev);
+	if (ret)
+		goto err_bailout;
+
 	if (test_bit(PIC32F_DMA_PREP, &pic32s->flags))
 		master->can_dma	= pic32_spi_can_dma;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
