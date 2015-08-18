From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] spi: s3c64xx: simplify probe function by using local
 variable for &pdev->dev
Date: Tue, 18 Aug 2015 23:05:11 +0200
Message-ID: <55D39E07.9040700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Simplify the probe function by replacing all occurrences of &pdev->dev
with a local variable.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 58 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index cd1cfac..c4d3b06 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1024,39 +1024,39 @@ static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 
 static int s3c64xx_spi_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct resource	*mem_res;
 	struct resource	*res;
 	struct s3c64xx_spi_driver_data *sdd;
-	struct s3c64xx_spi_info *sci = dev_get_platdata(&pdev->dev);
+	struct s3c64xx_spi_info *sci = dev_get_platdata(dev);
 	struct spi_master *master;
 	int ret, irq;
 	char clk_name[16];
 
-	if (!sci && pdev->dev.of_node) {
-		sci = s3c64xx_spi_parse_dt(&pdev->dev);
+	if (!sci && dev->of_node) {
+		sci = s3c64xx_spi_parse_dt(dev);
 		if (IS_ERR(sci))
 			return PTR_ERR(sci);
 	}
 
 	if (!sci) {
-		dev_err(&pdev->dev, "platform_data missing!\n");
+		dev_err(dev, "platform_data missing!\n");
 		return -ENODEV;
 	}
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (mem_res == NULL) {
-		dev_err(&pdev->dev, "Unable to get SPI MEM resource\n");
+		dev_err(dev, "Unable to get SPI MEM resource\n");
 		return -ENXIO;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_warn(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+		dev_warn(dev, "Failed to get IRQ: %d\n", irq);
 		return irq;
 	}
 
-	master = spi_alloc_master(&pdev->dev,
-				sizeof(struct s3c64xx_spi_driver_data));
+	master = spi_alloc_master(dev, sizeof(struct s3c64xx_spi_driver_data));
 	if (master == NULL) {
 		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
 		return -ENOMEM;
@@ -1071,9 +1071,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->pdev = pdev;
 	sdd->sfr_start = mem_res->start;
 	if (pdev->dev.of_node) {
-		ret = of_alias_get_id(pdev->dev.of_node, "spi");
+		ret = of_alias_get_id(dev->of_node, "spi");
 		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get alias id, errno %d\n",
+			dev_err(dev, "failed to get alias id, errno %d\n",
 				ret);
 			goto err0;
 		}
@@ -1087,14 +1087,14 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (!sdd->pdev->dev.of_node) {
 		res = platform_get_resource(pdev, IORESOURCE_DMA,  0);
 		if (!res) {
-			dev_warn(&pdev->dev, "Unable to get SPI tx dma resource. Switching to poll mode\n");
+			dev_warn(dev, "Unable to get SPI tx dma resource. Switching to poll mode\n");
 			sdd->port_conf->quirks = S3C64XX_SPI_QUIRK_POLL;
 		} else
 			sdd->tx_dma.dmach = res->start;
 
 		res = platform_get_resource(pdev, IORESOURCE_DMA,  1);
 		if (!res) {
-			dev_warn(&pdev->dev, "Unable to get SPI rx dma resource. Switching to poll mode\n");
+			dev_warn(dev, "Unable to get SPI rx dma resource. Switching to poll mode\n");
 			sdd->port_conf->quirks = S3C64XX_SPI_QUIRK_POLL;
 		} else
 			sdd->rx_dma.dmach = res->start;
@@ -1103,7 +1103,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
 	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
 
-	master->dev.of_node = pdev->dev.of_node;
+	master->dev.of_node = dev->of_node;
 	master->bus_num = sdd->port_id;
 	master->setup = s3c64xx_spi_setup;
 	master->cleanup = s3c64xx_spi_cleanup;
@@ -1121,43 +1121,43 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (!is_polling(sdd))
 		master->can_dma = s3c64xx_spi_can_dma;
 
-	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
+	sdd->regs = devm_ioremap_resource(dev, mem_res);
 	if (IS_ERR(sdd->regs)) {
 		ret = PTR_ERR(sdd->regs);
 		goto err0;
 	}
 
 	if (sci->cfg_gpio && sci->cfg_gpio()) {
-		dev_err(&pdev->dev, "Unable to config gpio\n");
+		dev_err(dev, "Unable to config gpio\n");
 		ret = -EBUSY;
 		goto err0;
 	}
 
 	/* Setup clocks */
-	sdd->clk = devm_clk_get(&pdev->dev, "spi");
+	sdd->clk = devm_clk_get(dev, "spi");
 	if (IS_ERR(sdd->clk)) {
-		dev_err(&pdev->dev, "Unable to acquire clock 'spi'\n");
+		dev_err(dev, "Unable to acquire clock 'spi'\n");
 		ret = PTR_ERR(sdd->clk);
 		goto err0;
 	}
 
 	if (clk_prepare_enable(sdd->clk)) {
-		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
+		dev_err(dev, "Couldn't enable clock 'spi'\n");
 		ret = -EBUSY;
 		goto err0;
 	}
 
 	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
-	sdd->src_clk = devm_clk_get(&pdev->dev, clk_name);
+	sdd->src_clk = devm_clk_get(dev, clk_name);
 	if (IS_ERR(sdd->src_clk)) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"Unable to acquire clock '%s'\n", clk_name);
 		ret = PTR_ERR(sdd->src_clk);
 		goto err2;
 	}
 
 	if (clk_prepare_enable(sdd->src_clk)) {
-		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n", clk_name);
+		dev_err(dev, "Couldn't enable clock '%s'\n", clk_name);
 		ret = -EBUSY;
 		goto err2;
 	}
@@ -1168,10 +1168,10 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	spin_lock_init(&sdd->lock);
 	init_completion(&sdd->xfer_completion);
 
-	ret = devm_request_irq(&pdev->dev, irq, s3c64xx_spi_irq, 0,
+	ret = devm_request_irq(dev, irq, s3c64xx_spi_irq, 0,
 				"spi-s3c64xx", sdd);
 	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to request IRQ %d: %d\n",
+		dev_err(dev, "Failed to request IRQ %d: %d\n",
 			irq, ret);
 		goto err3;
 	}
@@ -1180,18 +1180,18 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
 	       sdd->regs + S3C64XX_SPI_INT_EN);
 
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_master(dev, master);
 	if (ret != 0) {
-		dev_err(&pdev->dev, "cannot register SPI master: %d\n", ret);
+		dev_err(dev, "cannot register SPI master: %d\n", ret);
 		goto err3;
 	}
 
-	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
+	dev_dbg(dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
 					sdd->port_id, master->num_chipselect);
-	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\tDMA=[Rx-%d, Tx-%d]\n",
+	dev_dbg(dev, "\tIOmem=[%pR]\tFIFO %dbytes\tDMA=[Rx-%d, Tx-%d]\n",
 					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
 					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
