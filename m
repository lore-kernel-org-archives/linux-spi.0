From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: Convert to generalized SPI controller API" to the spi tree
Date: Mon, 12 Feb 2018 12:09:48 +0000
Message-ID: <E1elCvc-0007aW-7e@debutante>
References: <20180201151730.27190-1-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180201151730.27190-1-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: Convert to generalized SPI controller API

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 721483e28889431426a15fe906f48aacd17f0999 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 1 Feb 2018 17:17:29 +0200
Subject: [PATCH] spi: dw: Convert to generalized SPI controller API

Convert to generalized SPI controller API introduced by the
commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"").
Inside driver variable name "master" is still used to indicate the driver
is master only.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c |  6 +++---
 drivers/spi/spi-dw.c     | 26 +++++++++++++-------------
 drivers/spi/spi-dw.h     |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 837cb8d0bac6..3db905f5f345 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -112,10 +112,10 @@ static irqreturn_t dma_transfer(struct dw_spi *dws)
 	return IRQ_HANDLED;
 }
 
-static bool mid_spi_can_dma(struct spi_master *master, struct spi_device *spi,
-		struct spi_transfer *xfer)
+static bool mid_spi_can_dma(struct spi_controller *master,
+		struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct dw_spi *dws = spi_master_get_devdata(master);
+	struct dw_spi *dws = spi_controller_get_devdata(master);
 
 	if (!dws->dma_inited)
 		return false;
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 211cc7d75bf8..f693bfe95ab9 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -135,7 +135,7 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
 
 static void dw_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip = spi_get_ctldata(spi);
 
 	/* Chip select logic is inverted from spi_set_cs() */
@@ -250,8 +250,8 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 
 static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct dw_spi *dws = spi_master_get_devdata(master);
+	struct spi_controller *master = dev_id;
+	struct dw_spi *dws = spi_controller_get_devdata(master);
 	u16 irq_status = dw_readl(dws, DW_SPI_ISR) & 0x3f;
 
 	if (!irq_status)
@@ -277,10 +277,10 @@ static int poll_transfer(struct dw_spi *dws)
 	return 0;
 }
 
-static int dw_spi_transfer_one(struct spi_master *master,
+static int dw_spi_transfer_one(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *transfer)
 {
-	struct dw_spi *dws = spi_master_get_devdata(master);
+	struct dw_spi *dws = spi_controller_get_devdata(master);
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u8 imask = 0;
 	u16 txlevel = 0;
@@ -383,10 +383,10 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	return 1;
 }
 
-static void dw_spi_handle_err(struct spi_master *master,
+static void dw_spi_handle_err(struct spi_controller *master,
 		struct spi_message *msg)
 {
-	struct dw_spi *dws = spi_master_get_devdata(master);
+	struct dw_spi *dws = spi_controller_get_devdata(master);
 
 	if (dws->dma_mapped)
 		dws->dma_ops->dma_stop(dws);
@@ -471,7 +471,7 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 
 int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 {
-	struct spi_master *master;
+	struct spi_controller *master;
 	int ret;
 
 	BUG_ON(dws == NULL);
@@ -518,8 +518,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		}
 	}
 
-	spi_master_set_devdata(master, dws);
-	ret = devm_spi_register_master(dev, master);
+	spi_controller_set_devdata(master, dws);
+	ret = devm_spi_register_controller(dev, master);
 	if (ret) {
 		dev_err(&master->dev, "problem registering spi master\n");
 		goto err_dma_exit;
@@ -534,7 +534,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	spi_enable_chip(dws, 0);
 	free_irq(dws->irq, master);
 err_free_master:
-	spi_master_put(master);
+	spi_controller_put(master);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_spi_add_host);
@@ -556,7 +556,7 @@ int dw_spi_suspend_host(struct dw_spi *dws)
 {
 	int ret;
 
-	ret = spi_master_suspend(dws->master);
+	ret = spi_controller_suspend(dws->master);
 	if (ret)
 		return ret;
 
@@ -570,7 +570,7 @@ int dw_spi_resume_host(struct dw_spi *dws)
 	int ret;
 
 	spi_hw_init(&dws->master->dev, dws);
-	ret = spi_master_resume(dws->master);
+	ret = spi_controller_resume(dws->master);
 	if (ret)
 		dev_err(&dws->master->dev, "fail to start queue (%d)\n", ret);
 	return ret;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 5c07cf8f19e0..2cde2473b3e9 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -93,14 +93,14 @@ struct dw_spi_dma_ops {
 	int (*dma_init)(struct dw_spi *dws);
 	void (*dma_exit)(struct dw_spi *dws);
 	int (*dma_setup)(struct dw_spi *dws, struct spi_transfer *xfer);
-	bool (*can_dma)(struct spi_master *master, struct spi_device *spi,
+	bool (*can_dma)(struct spi_controller *master, struct spi_device *spi,
 			struct spi_transfer *xfer);
 	int (*dma_transfer)(struct dw_spi *dws, struct spi_transfer *xfer);
 	void (*dma_stop)(struct dw_spi *dws);
 };
 
 struct dw_spi {
-	struct spi_master	*master;
+	struct spi_controller	*master;
 	enum dw_ssi_type	type;
 
 	void __iomem		*regs;
-- 
2.16.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
