From: kernel@martin.sperl.org
Subject: [PATCH V3 8/9] spi: bcm2835aux: add driver stats to debugfs
Date: Sat, 30 Mar 2019 10:13:53 +0000
Message-ID: <20190330101353.12981-1-kernel@martin.sperl.org>
References: <20190330093106.20723-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190330093106.20723-1-kernel@martin.sperl.org>
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

From: Martin Sperl <kernel@martin.sperl.org>

To estimate efficiency add statistics on transfer types
(polling and interrupt) used to debugfs.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

---
Changelog:
  V2 -> V3: make use of counters regardless of CONFIG_DEBUG_FS

 drivers/spi/spi-bcm2835aux.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 99414319001a..e7a4a161b78b 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -21,6 +21,7 @@

 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -102,8 +103,52 @@ struct bcm2835aux_spi {
 	int tx_len;
 	int rx_len;
 	int pending;
+
+	u64 count_transfer_polling;
+	u64 count_transfer_irq;
+	u64 count_transfer_irq_after_poll;
+
+	struct dentry *debugfs_dir;
 };

+#if defined(CONFIG_DEBUG_FS)
+static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs,
+				      const char *dname)
+{
+	char name[64];
+	struct dentry *dir;
+
+	/* get full name */
+	snprintf(name, sizeof(name), "spi-bcm2835aux-%s", dname);
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
+	debugfs_create_u64("count_transfer_irq_after_poll", 0444, dir,
+			   &bs->count_transfer_irq_after_poll);
+}
+
+static void bcm2835aux_debugfs_remove(struct bcm2835aux_spi *bs)
+{
+	debugfs_remove_recursive(bs->debugfs_dir);
+	bs->debugfs_dir = NULL;
+}
+#else
+static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)
+{
+}
+
+static void bcm2835aux_debugfs_remove(struct bcm2835aux_spi *bs)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static inline u32 bcm2835aux_rd(struct bcm2835aux_spi *bs, unsigned reg)
 {
 	return readl(bs->regs + reg);
@@ -242,6 +287,9 @@ static int bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);

+	/* update statistics */
+	bs->count_transfer_irq++;
+
 	/* fill in registers and fifos before enabling interrupts */
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
@@ -265,6 +313,9 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;

+	/* update statistics */
+	bs->count_transfer_polling++;
+
 	/* configure spi */
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
@@ -285,6 +336,7 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 					    jiffies - timeout,
 					    bs->tx_len, bs->rx_len);
 			/* forward to interrupt handler */
+			bs->count_transfer_irq_after_poll++;
 			return __bcm2835aux_spi_transfer_one_irq(master,
 							       spi, tfr);
 		}
@@ -533,6 +585,8 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}

+	bcm2835aux_debugfs_create(bs, dev_name(&pdev->dev));
+
 	return 0;

 out_clk_disable:
@@ -547,6 +601,8 @@ static int bcm2835aux_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);

+	bcm2835aux_debugfs_remove(bs);
+
 	bcm2835aux_spi_reset_hw(bs);

 	/* disable the HW block by releasing the clock */
--
2.11.0
