From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] spi-orion: convert to new infrastructure
Date: Tue, 12 Jun 2012 15:57:40 +0200
Message-ID: <1339509460-62258-1-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

Get rid of the 'master is unqueued' warning messages during boot.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 drivers/spi/spi-orion.c |  147 ++++++++++++++++-------------------------------
 1 files changed, 49 insertions(+), 98 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index dfd04e9..58e703f 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -35,22 +35,14 @@
 #define ORION_SPI_CLK_PRESCALE_MASK	0x1F
 
 struct orion_spi {
-	struct work_struct	work;
-
-	/* Lock access to transfer list.	*/
-	spinlock_t		lock;
-
-	struct list_head	msg_queue;
 	struct spi_master	*master;
 	void __iomem		*base;
 	unsigned int		max_speed;
 	unsigned int		min_speed;
 	struct orion_spi_info	*spi_info;
-	struct clk              *clk;
+	struct clk		*clk;
 };
 
-static struct workqueue_struct *orion_spi_wq;
-
 static inline void __iomem *spi_reg(struct orion_spi *orion_spi, u32 reg)
 {
 	return orion_spi->base + reg;
@@ -277,73 +269,53 @@ out:
 }
 
 
-static void orion_spi_work(struct work_struct *work)
+static void orion_spi_work(struct orion_spi *orion_spi, struct spi_message *m)
 {
-	struct orion_spi *orion_spi =
-		container_of(work, struct orion_spi, work);
-
-	spin_lock_irq(&orion_spi->lock);
-	while (!list_empty(&orion_spi->msg_queue)) {
-		struct spi_message *m;
-		struct spi_device *spi;
-		struct spi_transfer *t = NULL;
-		int par_override = 0;
-		int status = 0;
-		int cs_active = 0;
-
-		m = container_of(orion_spi->msg_queue.next, struct spi_message,
-				 queue);
-
-		list_del_init(&m->queue);
-		spin_unlock_irq(&orion_spi->lock);
-
-		spi = m->spi;
-
-		/* Load defaults */
-		status = orion_spi_setup_transfer(spi, NULL);
-
-		if (status < 0)
-			goto msg_done;
-
-		list_for_each_entry(t, &m->transfers, transfer_list) {
-			if (par_override || t->speed_hz || t->bits_per_word) {
-				par_override = 1;
-				status = orion_spi_setup_transfer(spi, t);
-				if (status < 0)
-					break;
-				if (!t->speed_hz && !t->bits_per_word)
-					par_override = 0;
-			}
-
-			if (!cs_active) {
-				orion_spi_set_cs(orion_spi, 1);
-				cs_active = 1;
-			}
-
-			if (t->len)
-				m->actual_length +=
-					orion_spi_write_read(spi, t);
-
-			if (t->delay_usecs)
-				udelay(t->delay_usecs);
-
-			if (t->cs_change) {
-				orion_spi_set_cs(orion_spi, 0);
-				cs_active = 0;
-			}
+	struct spi_device *spi;
+	struct spi_transfer *t = NULL;
+	int par_override = 0;
+	int status = 0;
+	int cs_active = 0;
+
+	spi = m->spi;
+
+	/* Load defaults */
+	status = orion_spi_setup_transfer(spi, NULL);
+	if (status < 0)
+		goto msg_done;
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (par_override || t->speed_hz || t->bits_per_word) {
+			par_override = 1;
+			status = orion_spi_setup_transfer(spi, t);
+			if (status < 0)
+				break;
+			if (!t->speed_hz && !t->bits_per_word)
+				par_override = 0;
 		}
 
-msg_done:
-		if (cs_active)
-			orion_spi_set_cs(orion_spi, 0);
+		if (!cs_active) {
+			orion_spi_set_cs(orion_spi, 1);
+			cs_active = 1;
+		}
+
+		if (t->len)
+			m->actual_length += orion_spi_write_read(spi, t);
 
-		m->status = status;
-		m->complete(m->context);
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
 
-		spin_lock_irq(&orion_spi->lock);
+		if (t->cs_change) {
+			orion_spi_set_cs(orion_spi, 0);
+			cs_active = 0;
+		}
 	}
 
-	spin_unlock_irq(&orion_spi->lock);
+msg_done:
+	if (cs_active)
+		orion_spi_set_cs(orion_spi, 0);
+
+	m->status = status;
 }
 
 static int __init orion_spi_reset(struct orion_spi *orion_spi)
@@ -376,23 +348,22 @@ static int orion_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int orion_spi_transfer(struct spi_device *spi, struct spi_message *m)
+static int orion_spi_transfer_one_message(struct spi_master *spi,
+					  struct spi_message *m)
 {
 	struct orion_spi *orion_spi;
 	struct spi_transfer *t = NULL;
-	unsigned long flags;
 
+	orion_spi = spi_master_get_devdata(spi);
 	m->actual_length = 0;
 	m->status = 0;
 
 	/* reject invalid messages and transfers */
-	if (list_empty(&m->transfers) || !m->complete)
+	if (list_empty(&m->transfers))
 		return -EINVAL;
 
-	orion_spi = spi_master_get_devdata(spi->master);
-
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		unsigned int bits_per_word = spi->bits_per_word;
+		unsigned int bits_per_word = m->spi->bits_per_word;
 
 		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
 			dev_err(&spi->dev,
@@ -430,18 +401,13 @@ static int orion_spi_transfer(struct spi_device *spi, struct spi_message *m)
 		}
 	}
 
-
-	spin_lock_irqsave(&orion_spi->lock, flags);
-	list_add_tail(&m->queue, &orion_spi->msg_queue);
-	queue_work(orion_spi_wq, &orion_spi->work);
-	spin_unlock_irqrestore(&orion_spi->lock, flags);
+	orion_spi_work(orion_spi, m);
+	spi_finalize_current_message(spi);
 
 	return 0;
 msg_rejected:
 	/* Message rejected and not queued */
 	m->status = -EINVAL;
-	if (m->complete)
-		m->complete(m->context);
 	return -EINVAL;
 }
 
@@ -469,7 +435,7 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	master->mode_bits = 0;
 
 	master->setup = orion_spi_setup;
-	master->transfer = orion_spi_transfer;
+	master->transfer_one_message = orion_spi_transfer_one_message;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
 
 	dev_set_drvdata(&pdev->dev, master);
@@ -503,11 +469,6 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	}
 	spi->base = ioremap(r->start, SZ_1K);
 
-	INIT_WORK(&spi->work, orion_spi_work);
-
-	spin_lock_init(&spi->lock);
-	INIT_LIST_HEAD(&spi->msg_queue);
-
 	if (orion_spi_reset(spi) < 0)
 		goto out_rel_mem;
 
@@ -537,8 +498,6 @@ static int __exit orion_spi_remove(struct platform_device *pdev)
 	master = dev_get_drvdata(&pdev->dev);
 	spi = spi_master_get_devdata(master);
 
-	cancel_work_sync(&spi->work);
-
 	clk_disable_unprepare(spi->clk);
 	clk_put(spi->clk);
 
@@ -562,21 +521,13 @@ static struct platform_driver orion_spi_driver = {
 
 static int __init orion_spi_init(void)
 {
-	orion_spi_wq = create_singlethread_workqueue(
-				orion_spi_driver.driver.name);
-	if (orion_spi_wq == NULL)
-		return -ENOMEM;
-
 	return platform_driver_probe(&orion_spi_driver, orion_spi_probe);
 }
 module_init(orion_spi_init);
 
 static void __exit orion_spi_exit(void)
 {
-	flush_workqueue(orion_spi_wq);
 	platform_driver_unregister(&orion_spi_driver);
-
-	destroy_workqueue(orion_spi_wq);
 }
 module_exit(orion_spi_exit);
 
-- 
1.7.4.2


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
