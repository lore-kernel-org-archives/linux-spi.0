From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/6] spi: dw: don't use mrst prefix anymore
Date: Fri, 12 Sep 2014 15:11:56 +0300
Message-ID: <1410523921-16732-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1410523921-16732-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410523921-16732-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since driver is used on other platforms and debugfs stuff would be useful there
as well let's substitute mrst_ by dw_ where it suits. Additionally let's use
SPI master device name when print registers dump.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 33117fb..6fb36f1 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -59,22 +59,20 @@ struct chip_data {
 
 #ifdef CONFIG_DEBUG_FS
 #define SPI_REGS_BUFSIZE	1024
-static ssize_t  spi_show_regs(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
+		size_t count, loff_t *ppos)
 {
-	struct dw_spi *dws;
+	struct dw_spi *dws = file->private_data;
 	char *buf;
 	u32 len = 0;
 	ssize_t ret;
 
-	dws = file->private_data;
-
 	buf = kzalloc(SPI_REGS_BUFSIZE, GFP_KERNEL);
 	if (!buf)
 		return 0;
 
 	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"MRST SPI0 registers:\n");
+			"%s registers:\n", dev_name(&dws->master->dev));
 	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"=================================\n");
 	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
@@ -110,41 +108,41 @@ static ssize_t  spi_show_regs(struct file *file, char __user *user_buf,
 	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"=================================\n");
 
-	ret =  simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
 	kfree(buf);
 	return ret;
 }
 
-static const struct file_operations mrst_spi_regs_ops = {
+static const struct file_operations dw_spi_regs_ops = {
 	.owner		= THIS_MODULE,
 	.open		= simple_open,
-	.read		= spi_show_regs,
+	.read		= dw_spi_show_regs,
 	.llseek		= default_llseek,
 };
 
-static int mrst_spi_debugfs_init(struct dw_spi *dws)
+static int dw_spi_debugfs_init(struct dw_spi *dws)
 {
-	dws->debugfs = debugfs_create_dir("mrst_spi", NULL);
+	dws->debugfs = debugfs_create_dir("dw_spi", NULL);
 	if (!dws->debugfs)
 		return -ENOMEM;
 
 	debugfs_create_file("registers", S_IFREG | S_IRUGO,
-		dws->debugfs, (void *)dws, &mrst_spi_regs_ops);
+		dws->debugfs, (void *)dws, &dw_spi_regs_ops);
 	return 0;
 }
 
-static void mrst_spi_debugfs_remove(struct dw_spi *dws)
+static void dw_spi_debugfs_remove(struct dw_spi *dws)
 {
 	debugfs_remove_recursive(dws->debugfs);
 }
 
 #else
-static inline int mrst_spi_debugfs_init(struct dw_spi *dws)
+static inline int dw_spi_debugfs_init(struct dw_spi *dws)
 {
 	return 0;
 }
 
-static inline void mrst_spi_debugfs_remove(struct dw_spi *dws)
+static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
 {
 }
 #endif /* CONFIG_DEBUG_FS */
@@ -694,7 +692,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		goto err_dma_exit;
 	}
 
-	mrst_spi_debugfs_init(dws);
+	dw_spi_debugfs_init(dws);
 	return 0;
 
 err_dma_exit:
@@ -711,7 +709,7 @@ void dw_spi_remove_host(struct dw_spi *dws)
 {
 	if (!dws)
 		return;
-	mrst_spi_debugfs_remove(dws);
+	dw_spi_debugfs_remove(dws);
 
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
