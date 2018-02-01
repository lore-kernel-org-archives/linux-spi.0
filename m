From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] spi: pxa2xx: Convert to generalized SPI controller API
Date: Thu,  1 Feb 2018 17:17:30 +0200
Message-ID: <20180201151730.27190-2-jarkko.nikula@linux.intel.com>
References: <20180201151730.27190-1-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180201151730.27190-1-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Convert to generalized SPI controller API introduced by the
commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"").
Inside driver variable name "master" is still used to indicate the driver
is master only.

While at it, change "unsigned cs" to "unsigned int cs" in
pxa2xx_spi_fw_translate_cs() to suppress checkpatch warning.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c |  4 ++--
 drivers/spi/spi-pxa2xx.c     | 40 ++++++++++++++++++++++------------------
 drivers/spi/spi-pxa2xx.h     |  2 +-
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 04f3eecf5cf3..3d7f66080c57 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -191,7 +191,7 @@ int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 {
 	struct pxa2xx_spi_master *pdata = drv_data->master_info;
 	struct device *dev = &drv_data->pdev->dev;
-	struct spi_master *master = drv_data->master;
+	struct spi_controller *master = drv_data->master;
 	dma_cap_mask_t mask;
 
 	dma_cap_zero(mask);
@@ -215,7 +215,7 @@ int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 
 void pxa2xx_spi_dma_release(struct driver_data *drv_data)
 {
-	struct spi_master *master = drv_data->master;
+	struct spi_controller *master = drv_data->master;
 
 	if (master->dma_rx) {
 		dmaengine_terminate_sync(master->dma_rx);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b0822d1dba29..487a6f1067c9 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -962,7 +962,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 	return clk_div << 8;
 }
 
-static bool pxa2xx_spi_can_dma(struct spi_master *master,
+static bool pxa2xx_spi_can_dma(struct spi_controller *master,
 			       struct spi_device *spi,
 			       struct spi_transfer *xfer)
 {
@@ -976,7 +976,7 @@ static bool pxa2xx_spi_can_dma(struct spi_master *master,
 static void pump_transfers(unsigned long data)
 {
 	struct driver_data *drv_data = (struct driver_data *)data;
-	struct spi_master *master = drv_data->master;
+	struct spi_controller *master = drv_data->master;
 	struct spi_message *message = master->cur_msg;
 	struct chip_data *chip = spi_get_ctldata(message->spi);
 	u32 dma_thresh = chip->dma_threshold;
@@ -1182,10 +1182,10 @@ static void pump_transfers(unsigned long data)
 	pxa2xx_spi_write(drv_data, SSCR1, cr1);
 }
 
-static int pxa2xx_spi_transfer_one_message(struct spi_master *master,
+static int pxa2xx_spi_transfer_one_message(struct spi_controller *master,
 					   struct spi_message *msg)
 {
-	struct driver_data *drv_data = spi_master_get_devdata(master);
+	struct driver_data *drv_data = spi_controller_get_devdata(master);
 
 	/* Initial message state*/
 	msg->state = START_STATE;
@@ -1198,9 +1198,9 @@ static int pxa2xx_spi_transfer_one_message(struct spi_master *master,
 	return 0;
 }
 
-static int pxa2xx_spi_unprepare_transfer(struct spi_master *master)
+static int pxa2xx_spi_unprepare_transfer(struct spi_controller *master)
 {
-	struct driver_data *drv_data = spi_master_get_devdata(master);
+	struct driver_data *drv_data = spi_controller_get_devdata(master);
 
 	/* Disable the SSP now */
 	pxa2xx_spi_write(drv_data, SSCR0,
@@ -1212,7 +1212,8 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_master *master)
 static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 		    struct pxa2xx_spi_chip *chip_info)
 {
-	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	struct driver_data *drv_data =
+		spi_controller_get_devdata(spi->controller);
 	struct gpio_desc *gpiod;
 	int err = 0;
 
@@ -1270,7 +1271,8 @@ static int setup(struct spi_device *spi)
 	struct pxa2xx_spi_chip *chip_info;
 	struct chip_data *chip;
 	const struct lpss_config *config;
-	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	struct driver_data *drv_data =
+		spi_controller_get_devdata(spi->controller);
 	uint tx_thres, tx_hi_thres, rx_thres;
 
 	switch (drv_data->ssp_type) {
@@ -1410,7 +1412,8 @@ static int setup(struct spi_device *spi)
 static void cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
-	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	struct driver_data *drv_data =
+		spi_controller_get_devdata(spi->controller);
 
 	if (!chip)
 		return;
@@ -1575,9 +1578,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 }
 #endif
 
-static int pxa2xx_spi_fw_translate_cs(struct spi_master *master, unsigned cs)
+static int pxa2xx_spi_fw_translate_cs(struct spi_controller *master,
+				      unsigned int cs)
 {
-	struct driver_data *drv_data = spi_master_get_devdata(master);
+	struct driver_data *drv_data = spi_controller_get_devdata(master);
 
 	if (has_acpi_companion(&drv_data->pdev->dev)) {
 		switch (drv_data->ssp_type) {
@@ -1602,7 +1606,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pxa2xx_spi_master *platform_info;
-	struct spi_master *master;
+	struct spi_controller *master;
 	struct driver_data *drv_data;
 	struct ssp_device *ssp;
 	const struct lpss_config *config;
@@ -1633,7 +1637,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		pxa_ssp_free(ssp);
 		return -ENOMEM;
 	}
-	drv_data = spi_master_get_devdata(master);
+	drv_data = spi_controller_get_devdata(master);
 	drv_data->master = master;
 	drv_data->master_info = platform_info;
 	drv_data->pdev = pdev;
@@ -1651,7 +1655,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
 	master->fw_translate_cs = pxa2xx_spi_fw_translate_cs;
 	master->auto_runtime_pm = true;
-	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	master->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 
 	drv_data->ssp_type = ssp->type;
 
@@ -1793,7 +1797,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
-	status = devm_spi_register_master(&pdev->dev, master);
+	status = devm_spi_register_controller(&pdev->dev, master);
 	if (status != 0) {
 		dev_err(&pdev->dev, "problem registering spi master\n");
 		goto out_error_clock_enabled;
@@ -1807,7 +1811,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	free_irq(ssp->irq, drv_data);
 
 out_error_master_alloc:
-	spi_master_put(master);
+	spi_controller_put(master);
 	pxa_ssp_free(ssp);
 	return status;
 }
@@ -1858,7 +1862,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	struct ssp_device *ssp = drv_data->ssp;
 	int status;
 
-	status = spi_master_suspend(drv_data->master);
+	status = spi_controller_suspend(drv_data->master);
 	if (status != 0)
 		return status;
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
@@ -1884,7 +1888,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 		lpss_ssp_setup(drv_data);
 
 	/* Start the queue running */
-	status = spi_master_resume(drv_data->master);
+	status = spi_controller_resume(drv_data->master);
 	if (status != 0) {
 		dev_err(dev, "problem starting queue (%d)\n", status);
 		return status;
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 94f7b0713281..513ec6c6e25b 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -31,7 +31,7 @@ struct driver_data {
 
 	/* SPI framework hookup */
 	enum pxa_ssp_type ssp_type;
-	struct spi_master *master;
+	struct spi_controller *master;
 
 	/* PXA hookup */
 	struct pxa2xx_spi_master *master_info;
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
