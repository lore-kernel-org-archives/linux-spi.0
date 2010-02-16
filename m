From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 5/5] spi: added SPI bus locking to
	mpc8xxx_spi
Date: Tue, 16 Feb 2010 20:57:43 +0100
Message-ID: <20100216205743.c4d736d1.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala
	<galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Added SPI bus locking functions. If the bus is locked, the SPI queue is
searched for SPI transmit messages for the chipselect for which the bus is
locked; no other messages will be transmitted, until the bus is unlocked 
again. 
Algorithm borrowed from the blackfin driver spi_bfin5xx.c.

Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---
diff -upr a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -124,6 +124,9 @@ struct spi_pram {
 #define	SPI_PRAM_SIZE	0x100
 #define	SPI_MRBLR	((unsigned int)PAGE_SIZE)
 
+/* value for 'locked' variable to indicate that the bus is unlocked */
+#define SPIBUS_UNLOCKED	0xFF		
+
 /* SPI Controller driver's private data. */
 struct mpc8xxx_spi {
 	struct device *dev;
@@ -171,6 +174,8 @@ struct mpc8xxx_spi {
 	spinlock_t lock;
 
 	struct completion done;
+
+	u8 locked;		/* chipselect number if bus is locked */
 };
 
 static void *mpc8xxx_dummy_rx;
@@ -605,11 +610,39 @@ static void mpc8xxx_spi_work(struct work
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = container_of(work, struct mpc8xxx_spi,
 						       work);
+	u8 locked_cs;
+	u8 next_cs;
 
 	spin_lock_irq(&mpc8xxx_spi->lock);
 	while (!list_empty(&mpc8xxx_spi->queue)) {
 		struct spi_message *m = container_of(mpc8xxx_spi->queue.next,
 						   struct spi_message, queue);
+		struct spi_message *msg = NULL;
+
+		if (mpc8xxx_spi->locked != SPIBUS_UNLOCKED) {
+			locked_cs = mpc8xxx_spi->locked;
+			next_cs = m->spi->chip_select;
+
+			if (next_cs != locked_cs) {
+				list_for_each_entry(msg, &mpc8xxx_spi->queue, 
+						    queue) {
+					next_cs = msg->spi->chip_select;
+					if (next_cs == locked_cs) {
+						m = msg;
+						break;
+					}
+				}
+
+				/* 
+				 * Do nothing even if there are messages 
+				 * for other devices 
+				 */
+				if (next_cs != locked_cs) {
+					spin_unlock_irq(&mpc8xxx_spi->lock);
+					return;
+				}
+			}
+		}
 
 		list_del_init(&m->queue);
 		spin_unlock_irq(&mpc8xxx_spi->lock);
@@ -736,6 +769,50 @@ static irqreturn_t mpc8xxx_spi_irq(s32 i
 	return ret;
 }
 
+/*
+ * lock the spi bus for exclusive access
+ */
+static int mpc8xxx_spi_lock_bus(struct spi_device *spi)
+{
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
+	if (mpc8xxx_spi->locked != SPIBUS_UNLOCKED) {
+		spin_unlock_irqrestore(&mpc8xxx_spi->lock, flags);
+		return -ENOLCK;
+	}
+	mpc8xxx_spi->locked = spi->chip_select;
+
+	spin_unlock_irqrestore(&mpc8xxx_spi->lock, flags);
+
+	return 0;
+}
+
+/*
+ * unlock the spi bus from exclusive access
+ */
+static int mpc8xxx_spi_unlock_bus(struct spi_device *spi)
+{
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
+
+	/* remove the spi bus lock */
+	mpc8xxx_spi->locked = SPIBUS_UNLOCKED;
+
+	/* 
+	 * process all deferred messages for all chipselects 
+	 * other than the locked after the bus became unlocked
+	 */
+	queue_work(mpc8xxx_spi->workqueue, &mpc8xxx_spi->work);
+
+	spin_unlock_irqrestore(&mpc8xxx_spi->lock, flags);
+
+	return 0;
+}
+
 static int mpc8xxx_spi_transfer(struct spi_device *spi,
 				struct spi_message *m)
 {
@@ -992,6 +1069,8 @@ mpc8xxx_spi_probe(struct device *dev, st
 	master->setup = mpc8xxx_spi_setup;
 	master->transfer = mpc8xxx_spi_transfer;
 	master->cleanup = mpc8xxx_spi_cleanup;
+	master->lock_bus = mpc8xxx_spi_lock_bus;
+	master->unlock_bus = mpc8xxx_spi_unlock_bus;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	mpc8xxx_spi->dev = dev;
@@ -999,6 +1078,7 @@ mpc8xxx_spi_probe(struct device *dev, st
 	mpc8xxx_spi->get_tx = mpc8xxx_spi_tx_buf_u8;
 	mpc8xxx_spi->flags = pdata->flags;
 	mpc8xxx_spi->spibrg = pdata->sysclk;
+	mpc8xxx_spi->locked = SPIBUS_UNLOCKED;
 
 	ret = mpc8xxx_spi_cpm_init(mpc8xxx_spi);
 	if (ret)



------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
