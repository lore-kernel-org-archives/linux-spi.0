From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 4/9] spi: bcm2835aux: add driver specific stats to debugfs
Date: Sun, 24 Feb 2019 12:54:35 +0000
Message-ID: <20190224125440.16117-5-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>,
 Hubert Denkmair <h.denkmair-4pT7WzY1KUiELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190224125440.16117-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
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
(polling and interrupt) used via debugfs.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 922fd798508e..0a5f21eb3b99 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -21,6 +21,7 @@

 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -102,8 +103,57 @@ struct bcm2835aux_spi {
 	int tx_len;
 	int rx_len;
 	int pending;
+
+#if defined(CONFIG_DEBUG_FS)
+#define BCM2835_AUX_INCR(field) ((field)++)
+	u64 count_transfer_polling;
+	u64 count_transfer_irq;
+	u64 count_transfer_irq_after_poll;
+
+	struct dentry *debugfs_dir;
+#else
+#define BCM2835_AUX_INCR(field)
+#endif /* CONFIG_DEBUG_FS */
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
@@ -251,6 +301,9 @@ static int bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);

+	/* update statistics */
+	BCM2835_AUX_INCR(bs->count_transfer_irq);
+
 	/* fill in registers and fifos before enabling interrupts */
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
@@ -275,6 +328,9 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 	unsigned long timeout;
 	u32 stat;

+	/* update statistics */
+	BCM2835_AUX_INCR(bs->count_transfer_polling);
+
 	/* configure spi */
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
@@ -310,6 +366,7 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 					    jiffies - timeout,
 					    bs->tx_len, bs->rx_len);
 			/* forward to interrupt handler */
+			BCM2835_AUX_INCR(bs->count_transfer_irq_after_poll);
 			return __bcm2835aux_spi_transfer_one_irq(master,
 							       spi, tfr);
 		}
@@ -555,6 +612,8 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}

+	bcm2835aux_debugfs_create(bs, dev_name(&pdev->dev));
+
 	return 0;

 out_clk_disable:
@@ -569,6 +628,8 @@ static int bcm2835aux_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);

+	bcm2835aux_debugfs_remove(bs);
+
 	bcm2835aux_spi_reset_hw(bs);

 	/* disable the HW block by releasing the clock */
--
2.11.0
