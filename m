From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] spi-bfin5xx: Adjust 14 checks for null pointers
Date: Wed, 17 May 2017 13:55:31 +0200
Message-ID: <07be1666-abb0-8abe-e66c-7b7dbc7c94bd@users.sourceforge.net>
References: <f8ad3eb5-d6aa-3e82-1265-a63ed2c7cb88@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <f8ad3eb5-d6aa-3e82-1265-a63ed2c7cb88@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 17 May 2017 13:13:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written …

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/spi/spi-bfin5xx.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index 3265f4967d2b..c1353ac49c9c 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -489,7 +489,7 @@ static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
 		"in dma_irq_handler dmastat:0x%x spistat:0x%x\n",
 		dmastat, spistat);
 
-	if (drv_data->rx != NULL) {
+	if (drv_data->rx) {
 		u16 cr = bfin_read(&drv_data->regs->ctl);
 		/* discard old RX data and clear RXS */
 		bfin_spi_dummy_read(drv_data);
@@ -506,7 +506,7 @@ static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
 	 * to be transmitted ... software needs to poll TXS in the SPI_STAT
 	 * register until it goes low for 2 successive reads
 	 */
-	if (drv_data->tx != NULL) {
+	if (drv_data->tx) {
 		while ((bfin_read(&drv_data->regs->stat) & BIT_STAT_TXS) ||
 		       (bfin_read(&drv_data->regs->stat) & BIT_STAT_TXS))
 			cpu_relax();
@@ -612,7 +612,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		return;
 	}
 
-	if (transfer->tx_buf != NULL) {
+	if (transfer->tx_buf) {
 		drv_data->tx = (void *)transfer->tx_buf;
 		drv_data->tx_end = drv_data->tx + transfer->len;
 		dev_dbg(&drv_data->pdev->dev, "tx_buf is %p, tx_end is %p\n",
@@ -621,7 +621,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		drv_data->tx = NULL;
 	}
 
-	if (transfer->rx_buf != NULL) {
+	if (transfer->rx_buf) {
 		full_duplex = transfer->tx_buf != NULL;
 		drv_data->rx = transfer->rx_buf;
 		drv_data->rx_end = drv_data->rx + transfer->len;
@@ -723,7 +723,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 
 		/* In dma mode, rx or tx must be NULL in one transfer */
 		dma_config = (RESTART | dma_width | DI_EN);
-		if (drv_data->rx != NULL) {
+		if (drv_data->rx) {
 			/* set transfer mode, and enable SPI */
 			dev_dbg(&drv_data->pdev->dev, "doing DMA in to %p (size %zx)\n",
 				drv_data->rx, drv_data->len_in_bytes);
@@ -738,7 +738,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 			dma_start_addr = (unsigned long)drv_data->rx;
 			cr |= BIT_CTL_TIMOD_DMA_RX | BIT_CTL_SENDOPT;
 
-		} else if (drv_data->tx != NULL) {
+		} else if (drv_data->tx) {
 			dev_dbg(&drv_data->pdev->dev, "doing DMA out.\n");
 
 			/* flush caches, if needed */
@@ -789,7 +789,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		bfin_spi_dummy_read(drv_data);
 
 		/* start transfer */
-		if (drv_data->tx == NULL)
+		if (!drv_data->tx)
 			bfin_write(&drv_data->regs->tdbr, chip->idle_tx_val);
 		else {
 			int loop;
@@ -827,7 +827,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 
 		if (drv_data->tx != drv_data->tx_end)
 			tranf_success = 0;
-	} else if (drv_data->tx != NULL) {
+	} else if (drv_data->tx) {
 		/* write only half duplex */
 		dev_dbg(&drv_data->pdev->dev,
 			"IO write: cr is 0x%x\n", cr);
@@ -836,7 +836,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 
 		if (drv_data->tx != drv_data->tx_end)
 			tranf_success = 0;
-	} else if (drv_data->rx != NULL) {
+	} else if (drv_data->rx) {
 		/* read only half duplex */
 		dev_dbg(&drv_data->pdev->dev,
 			"IO read: cr is 0x%x\n", cr);
@@ -979,6 +979,6 @@ static int bfin_spi_setup(struct spi_device *spi)
 	/* Only alloc (or use chip_info) on first setup */
 	chip_info = NULL;
 	chip = spi_get_ctldata(spi);
-	if (chip == NULL) {
+	if (!chip) {
 		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 		if (!chip) {
@@ -1086,7 +1086,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 
 	if (chip->chip_select_num >= MAX_CTRL_CS) {
 		/* Only request on first setup */
-		if (spi_get_ctldata(spi) == NULL) {
+		if (!spi_get_ctldata(spi)) {
 			ret = gpio_request(chip->cs_gpio, spi->modalias);
 			if (ret) {
 				dev_err(&spi->dev, "gpio_request() error\n");
@@ -1278,21 +1278,21 @@ static int bfin_spi_probe(struct platform_device *pdev)
 
 	/* Find and map our resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
+	if (!res) {
 		dev_err(dev, "Cannot get IORESOURCE_MEM\n");
 		status = -ENOENT;
 		goto out_error_get_res;
 	}
 
 	drv_data->regs = ioremap(res->start, resource_size(res));
-	if (drv_data->regs == NULL) {
+	if (!drv_data->regs) {
 		dev_err(dev, "Cannot map IO\n");
 		status = -ENXIO;
 		goto out_error_ioremap;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (res == NULL) {
+	if (!res) {
 		dev_err(dev, "No DMA channel specified\n");
 		status = -ENOENT;
 		goto out_error_free_io;
-- 
2.13.0

