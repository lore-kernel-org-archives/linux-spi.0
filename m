From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm2835: add driver stats to debugfs" to the spi tree
Date: Wed,  8 May 2019 10:08:53 +0100 (BST)
Message-ID: <20190508090854.0A5F2440034@finisterre.sirena.org.uk>
References: <20190423201513.8073-7-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Mark Brown <broonie@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Martin Sperl <kernel@martin.sperl.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190423201513.8073-7-kernel@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm2835: add driver stats to debugfs

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

>From 154f7da56f1ecba42021d550c9e8432ac8d32c26 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Tue, 23 Apr 2019 20:15:13 +0000
Subject: [PATCH] spi: bcm2835: add driver stats to debugfs

To estimate efficiency add statistics on transfer types
(polling, interrupt and dma) used to debugfs.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            reorganized patchset
	    added extra rational, descriptions
	    fixed compile issue when CONFIG_DEBUG_FS is unset
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 74 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 3230d37fa89a..eb67da697ef5 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -22,6 +22,7 @@
 
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -101,6 +102,15 @@ MODULE_PARM_DESC(polling_limit_us,
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
@@ -115,8 +125,55 @@ struct bcm2835_spi {
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
@@ -320,6 +377,9 @@ static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 
+	/* update usage statistics */
+	bs->count_transfer_irq++;
+
 	/*
 	 * Enable HW block, but with interrupts still disabled.
 	 * Otherwise the empty TX FIFO would immediately trigger an interrupt.
@@ -564,6 +624,9 @@ static int bcm2835_spi_transfer_one_dma(struct spi_master *master,
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	int ret;
 
+	/* update usage statistics */
+	bs->count_transfer_dma++;
+
 	/*
 	 * Transfer first few bytes without DMA if length of first TX or RX
 	 * sglist entry is not a multiple of 4 bytes (hardware limitation).
@@ -706,6 +769,9 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;
 
+	/* update usage statistics */
+	bs->count_transfer_polling++;
+
 	/* enable HW block without interrupts */
 	bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_TA);
 
@@ -735,6 +801,10 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
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
@@ -982,6 +1052,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
+	bcm2835_debugfs_create(bs, dev_name(&pdev->dev));
+
 	return 0;
 
 out_clk_disable:
@@ -996,6 +1068,8 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 
+	bcm2835_debugfs_remove(bs);
+
 	/* Clear FIFOs, and disable the HW block */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
-- 
2.20.1
