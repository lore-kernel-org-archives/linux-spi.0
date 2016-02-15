From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 3/3] spi: rockchip: add debug interface support
Date: Mon, 15 Feb 2016 16:28:22 +0800
Message-ID: <1455524902-2780-1-git-send-email-shawn.lin@rock-chips.com>
References: <1455524848-2646-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455524848-2646-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add debugfs support for user to debug rockchip spi
problems.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/spi/spi-rockchip.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7cb1b2d..e858393 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -28,6 +28,10 @@
 #include <linux/io.h>
 #include <linux/dmaengine.h>
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
+
 #define DRIVER_NAME "rockchip-spi"
 
 /* SPI register offsets */
@@ -199,8 +203,81 @@ struct rockchip_spi {
 	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
 	struct rockchip_spi_dma_data dma_tx;
+
+	#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+	#endif
+};
+
+#ifdef CONFIG_DEBUG_FS
+static int rockchip_spi_dbg_show(struct seq_file *s, void *v)
+{
+	struct rockchip_spi *rs = s->private;
+
+	seq_printf(s, "CTRLR0:\t0x%08x\n",
+		   readl_relaxed(rs->regs + ROCKCHIP_SPI_CTRLR0));
+	seq_printf(s, "CTRLR1:\t0x%08x\n",
+		   readl_relaxed(rs->regs + ROCKCHIP_SPI_CTRLR1));
+	seq_printf(s, "BAUDR:\t0x%08x\n",
+		   readl_relaxed(rs->regs + ROCKCHIP_SPI_BAUDR));
+	seq_printf(s, "TXFTLR:\t0x%08x\n",
+		   readl_relaxed(rs->regs + ROCKCHIP_SPI_TXFTLR));
+	seq_printf(s, "RXFTLR:\t0x%08x\n",
+		   readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFTLR));
+	seq_printf(s, "SR:\t0x%08x\n",
+		   readl_relaxed(rs->regs + ROCKCHIP_SPI_SR));
+	seq_printf(s, "ISR:\t0x%08x\n",
+		   readl_relaxed(rs->regs + ROCKCHIP_SPI_ISR));
+	seq_printf(s, "DMACR:\t0x%08x\n",
+		   readl_relaxed(rs->regs + ROCKCHIP_SPI_DMACR));
+	seq_printf(s, "rs->state:\t0x%08x\n", rs->state);
+	seq_printf(s, "rs->speed:\t0x%08x\n", rs->speed);
+	seq_printf(s, "rs->tmode:\t0x%08x\n", rs->tmode);
+	seq_printf(s, "rs->mode:\t0x%08x\n", rs->mode);
+
+	return 0;
+}
+
+static int rockchip_spi_dbg_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rockchip_spi_dbg_show, inode->i_private);
+}
+
+static const struct file_operations rockchip_spi_dbg_ops = {
+	.owner          = THIS_MODULE,
+	.open           = rockchip_spi_dbg_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
 };
 
+static int rockchip_spi_debugfs_init(struct rockchip_spi *rs)
+{
+	rs->debugfs = debugfs_create_dir("rockchip_spi", NULL);
+	if (!rs->debugfs)
+		return -ENOMEM;
+
+	debugfs_create_file("regs", S_IFREG | S_IRUGO,
+		rs->debugfs, (void *)rs, &rockchip_spi_dbg_ops);
+	return 0;
+}
+
+static void rockchip_spi_debugfs_remove(struct rockchip_spi *rs)
+{
+	debugfs_remove_recursive(rs->debugfs);
+}
+#else
+static inline int rockchip_spi_debugfs_init(struct rockchip_spi *rs)
+{
+	return 0;
+}
+
+static inline void rockchip_spi_debugfs_remove(struct rockchip_spi *rs)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
+
 static inline void spi_enable_chip(struct rockchip_spi *rs, int enable)
 {
 	writel_relaxed((enable ? 1 : 0), rs->regs + ROCKCHIP_SPI_SSIENR);
@@ -746,6 +823,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_register_master;
 	}
 
+	rockchip_spi_debugfs_init(rs);
 	return 0;
 
 err_register_master:
@@ -770,6 +848,7 @@ static int rockchip_spi_remove(struct platform_device *pdev)
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
 	pm_runtime_disable(&pdev->dev);
+	rockchip_spi_debugfs_remove(rs);
 
 	clk_disable_unprepare(rs->spiclk);
 	clk_disable_unprepare(rs->apb_pclk);
-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
