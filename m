From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: Make debugfs use bus num and make irq name unique" to the spi tree
Date: Mon, 09 Jan 2017 20:02:04 +0000
Message-ID: <E1cQg8q-00075H-RB@debutante>
References: <1483695313-97670-1-git-send-email-preid@electromag.com.au>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483695313-97670-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: Make debugfs use bus num and make irq name unique

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From e70002c80d4de20a5c61c16ecd4f40a48be3efcf Mon Sep 17 00:00:00 2001
From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Date: Fri, 6 Jan 2017 17:35:13 +0800
Subject: [PATCH] spi: dw: Make debugfs use bus num and make irq name unique

Instead of using device name it was suggested that bus number was more
appropriate to differentiate debugfs names. Also reduce buffer size to
more realistic 32 bytes instead of 128.

When request_irq is called the bus number may not be assigned. Therefore
the irq name was not unique when dynamic bus number was being used.
As per most of the spi drivers use the device name instead. No other
use of dws->name could be found so it was removed.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 8 ++++----
 drivers/spi/spi-dw.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 054012f87567..b217c22ff72f 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -107,9 +107,9 @@ static const struct file_operations dw_spi_regs_ops = {
 
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
index c21ca02f8ec5..da5eab62df34 100644
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
