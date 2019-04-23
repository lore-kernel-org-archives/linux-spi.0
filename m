From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 6/6] spi: bcm2835: add driver stats to debugfs
Date: Tue, 23 Apr 2019 20:15:13 +0000
Message-ID: <20190423201513.8073-7-kernel@martin.sperl.org>
References: <20190423201513.8073-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190423201513.8073-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

To estimate efficiency add statistics on transfer types
(polling, interrupt and dma) used to debugfs.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            reorganized patchset
	    added extra rational, descriptions
	    fixed compile issue when CONFIG_DEBUG_FS is unset

---
 drivers/spi/spi-bcm2835.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 755e1e6d2252..83a67eb76325 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -22,6 +22,7 @@

 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -106,6 +107,15 @@ MODULE_PARM_DESC(dma_min_bytes_limit,
  *	length is not a multiple of 4 (to overcome hardware limitation)
  * @tx_spillover: whether @tx_prologue spills over to second TX sglist entry
  * @dma_pending: whether a DMA transfer is in progress
+ * @debugfs_dir: the debugfs directory - neede to remove debugfs when
+ *      unloading the module
+ * @count_transfer_polling: count of how often polling mode is used
+ * @count_transfer_irq: count of how often interrupt mode is used
+ * @count_transfer_irq_after_polling: count of how often we fall back to
+ *      interrupt mode after starting in polling mode.
+ *      These are counted as well in @count_transfer_polling and
+ *      @count_transfer_irq
+ * @count_transfer_dma: count how often dma mode is used
  */
 struct bcm2835_spi {
 	void __iomem *regs;
@@ -120,8 +130,55 @@ struct bcm2835_spi {
 	int rx_prologue;
 	unsigned int tx_spillover;
 	unsigned int dma_pending;
+
+	struct dentry *debugfs_dir;
+	u64 count_transfer_polling;
+	u64 count_transfer_irq;
+	u64 count_transfer_irq_after_polling;
+	u64 count_transfer_dma;
 };

+#if defined(CONFIG_DEBUG_FS)
+static void bcm2835_debugfs_create(struct bcm2835_spi *bs,
+				   const char *dname)
+{
+	char name[64];
+	struct dentry *dir;
+
+	/* get full name */
+	snprintf(name, sizeof(name), "spi-bcm2835-%s", dname);
+
+	/* the base directory */
+	dir = debugfs_create_dir(name, NULL);
+	bs->debugfs_dir = dir;
+
+	/* the counters */
+	debugfs_create_u64("count_transfer_polling", 0444, dir,
+			   &bs->count_transfer_polling);
+	debugfs_create_u64("count_transfer_irq", 0444, dir,
+			   &bs->count_transfer_irq);
+	debugfs_create_u64("count_transfer_irq_after_polling", 0444, dir,
+			   &bs->count_transfer_irq_after_polling);
+	debugfs_create_u64("count_transfer_dma", 0444, dir,
+			   &bs->count_transfer_dma);
+}
+
+static void bcm2835_debugfs_remove(struct bcm2835_spi *bs)
+{
+	debugfs_remove_recursive(bs->debugfs_dir);
+	bs->debugfs_dir = NULL;
+}
+#else
+static void bcm2835_debugfs_create(struct bcm2835_spi *bs,
+				   const char *dname)
+{
+}
+
+static void bcm2835_debugfs_remove(struct bcm2835_spi *bs)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static inline u32 bcm2835_rd(struct bcm2835_spi *bs, unsigned reg)
 {
 	return readl(bs->regs + reg);
@@ -325,6 +382,9 @@ static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);

+	/* update usage statistics */
+	bs->count_transfer_irq++;
+
 	/*
 	 * Enable HW block, but with interrupts still disabled.
 	 * Otherwise the empty TX FIFO would immediately trigger an interrupt.
@@ -583,6 +643,9 @@ static int bcm2835_spi_transfer_one_dma(struct spi_master *master,
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	int ret;

+	/* update usage statistics */
+	bs->count_transfer_dma++;
+
 	/*
 	 * Transfer first few bytes without DMA if length of first TX or RX
 	 * sglist entry is not a multiple of 4 bytes (hardware limitation).
@@ -739,6 +802,9 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;

+	/* update usage statistics */
+	bs->count_transfer_polling++;
+
 	/* enable HW block without interrupts */
 	bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_TA);

@@ -768,6 +834,10 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 					    jiffies - timeout,
 					    bs->tx_len, bs->rx_len);
 			/* fall back to interrupt mode */
+
+			/* update usage statistics */
+			bs->count_transfer_irq_after_polling++;
+
 			return bcm2835_spi_transfer_one_irq(master, spi,
 							    tfr, cs, false);
 		}
@@ -1004,6 +1074,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}

+	bcm2835_debugfs_create(bs, dev_name(&pdev->dev));
+
 	return 0;

 out_clk_disable:
@@ -1018,6 +1090,8 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);

+	bcm2835_debugfs_remove(bs);
+
 	/* Clear FIFOs, and disable the HW block */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
--
2.11.0
