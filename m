From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH 1/1] spi: dw: Make debugfs use bus num and make irq name unique
Date: Fri,  6 Jan 2017 17:35:13 +0800
Message-ID: <1483695313-97670-1-git-send-email-preid@electromag.com.au>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Instead of using device name it was suggested that bus number was more
appropriate to differentiate debugfs names. Also reduce buffer size to
more realistic 32 bytes instead of 128.

When request_irq is called the bus number may not be assigned. Therefore
the irq name was not unique when dynamic bus number was being used.
As per most of the spi drivers use the device name instead. No other
use of dws->name could be found so it was removed.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 drivers/spi/spi-dw.c | 8 ++++----
 drivers/spi/spi-dw.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 054012f..b217c22 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -107,9 +107,9 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
 
 static int dw_spi_debugfs_init(struct dw_spi *dws)
 {
-	char name[128];
+	char name[32];
 
-	snprintf(name, 128, "dw_spi-%s", dev_name(&dws->master->dev));
+	snprintf(name, 32, "dw_spi%d", dws->master->bus_num);
 	dws->debugfs = debugfs_create_dir(name, NULL);
 	if (!dws->debugfs)
 		return -ENOMEM;
@@ -486,9 +486,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	dws->type = SSI_MOTO_SPI;
 	dws->dma_inited = 0;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
-	snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);
 
-	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dws->name, master);
+	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
+			  master);
 	if (ret < 0) {
 		dev_err(dev, "can not get IRQ\n");
 		goto err_free_master;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index c21ca02..da5eab6 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -101,7 +101,6 @@ struct dw_spi_dma_ops {
 struct dw_spi {
 	struct spi_master	*master;
 	enum dw_ssi_type	type;
-	char			name[16];
 
 	void __iomem		*regs;
 	unsigned long		paddr;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
