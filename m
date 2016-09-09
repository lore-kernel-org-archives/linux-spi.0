From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] mtd: devices: m25p80: Add PM suspend resume support
Date: Fri,  9 Sep 2016 15:13:58 -0400
Message-ID: <1473448438-13245-1-git-send-email-kdasu.kdev@gmail.com>
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Adding PM support so as to be able to probe spi-nor flash
on resume. There are vendor specific commands to setup
the transfer mode and enable read/write as part of
spi_nor_scan(), done on intial probe and needed on resume().
The spi-nor stucture is private to the m25p driver and hence
is the only place this can be done without having to duplicate
code in controller driver.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 9cf7fcd..f8294b4 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -248,7 +248,6 @@ static int m25p_probe(struct spi_device *spi)
 				   data ? data->nr_parts : 0);
 }
 
-
 static int m25p_remove(struct spi_device *spi)
 {
 	struct m25p	*flash = spi_get_drvdata(spi);
@@ -319,10 +318,46 @@ static const struct of_device_id m25p_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, m25p_of_table);
 
+#ifdef CONFIG_PM_SLEEP
+static int m25p_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int m25p_resume(struct device *dev)
+{
+	struct m25p *flash = dev_get_drvdata(dev);
+	struct flash_platform_data	*data;
+	char *flash_name = NULL;
+	enum read_mode mode = SPI_NOR_NORMAL;
+	int ret;
+
+	data = dev_get_platdata(&flash->spi->dev);
+
+	if (data && data->type)
+		flash_name = data->type;
+	else if (!strcmp(flash->spi->modalias, "spi-nor"))
+		flash_name = NULL; /* auto-detect */
+	else
+		flash_name = flash->spi->modalias;
+
+	if (flash->spi->mode & SPI_RX_QUAD)
+		mode = SPI_NOR_QUAD;
+	else if (flash->spi->mode & SPI_RX_DUAL)
+		mode = SPI_NOR_DUAL;
+
+	ret = spi_nor_scan(&flash->spi_nor, flash_name, mode);
+
+	return ret;
+}
+#endif
+static SIMPLE_DEV_PM_OPS(m25p_pm_ops, m25p_suspend, m25p_resume);
+
 static struct spi_driver m25p80_driver = {
 	.driver = {
 		.name	= "m25p80",
 		.of_match_table = m25p_of_table,
+		.pm	= &m25p_pm_ops,
 	},
 	.id_table	= m25p_ids,
 	.probe	= m25p_probe,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
