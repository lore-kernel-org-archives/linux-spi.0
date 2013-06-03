From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v1 3/3] spi: mpc512x: use the SPI subsystem's message queue
Date: Mon,  3 Jun 2013 14:03:51 +0200
Message-ID: <1370261031-28572-4-git-send-email-gsi@denx.de>
References: <1370261031-28572-1-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dzu-ynQEQJNshbs@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1370261031-28572-1-git-send-email-gsi-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

the SPI subsystem recently grew support to queue messages before handing
them to the SPI master, and erroneously emitted deprecation warnings
when the SPI master's driver did not use the common logic (in fact the
master might queue messages, but implement the queue in the master
driver's source)

  [    0.823015] mpc512x-psc-spi 80011400.psc: master is unqueued, this is deprecated
  [    0.854913] mpc512x-psc-spi 80011500.psc: master is unqueued, this is deprecated

this change makes the MPC512x PSC SPI driver use the SPI subsystem's
support to queue SPI messages and removes the master driver's private
code for the queue support

Signed-off-by: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/spi-mpc512x-psc.c |  183 ++++++++++++++++-------------------------
 1 file changed, 73 insertions(+), 110 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 53c7899..29fce6a 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -21,7 +21,6 @@
 #include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/io.h>
 #include <linux/delay.h>
@@ -39,15 +38,8 @@ struct mpc512x_psc_spi {
 	struct mpc512x_psc_fifo __iomem *fifo;
 	unsigned int irq;
 	u8 bits_per_word;
-	u8 busy;
 	u32 mclk;
 
-	struct workqueue_struct *workqueue;
-	struct work_struct work;
-
-	struct list_head queue;
-	spinlock_t lock;	/* Message queue lock */
-
 	struct completion txisrdone;
 };
 
@@ -134,7 +126,6 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 					 struct spi_transfer *t)
 {
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
-	struct mpc52xx_psc __iomem *psc = mps->psc;
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
 	size_t tx_len = t->len;
 	size_t rx_len = t->len;
@@ -144,13 +135,6 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 	if (!tx_buf && !rx_buf && t->len)
 		return -EINVAL;
 
-	/* Zero MR2 */
-	in_8(&psc->mode);
-	out_8(&psc->mode, 0x0);
-
-	/* enable transmiter/receiver */
-	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
-
 	while (rx_len || tx_len) {
 		size_t txcount;
 		u8 data;
@@ -275,76 +259,90 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 		}
 
 	}
-	/* disable transmiter/receiver and fifo interrupt */
-	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
-	out_be32(&fifo->tximr, 0);
 	return 0;
 }
 
-static void mpc512x_psc_spi_work(struct work_struct *work)
+static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
+				    struct spi_message *m)
 {
-	struct mpc512x_psc_spi *mps = container_of(work,
-						   struct mpc512x_psc_spi,
-						   work);
-
-	spin_lock_irq(&mps->lock);
-	mps->busy = 1;
-	while (!list_empty(&mps->queue)) {
-		struct spi_message *m;
-		struct spi_device *spi;
-		struct spi_transfer *t = NULL;
-		unsigned cs_change;
-		int status;
-
-		m = container_of(mps->queue.next, struct spi_message, queue);
-		list_del_init(&m->queue);
-		spin_unlock_irq(&mps->lock);
-
-		spi = m->spi;
-		cs_change = 1;
-		status = 0;
-		list_for_each_entry(t, &m->transfers, transfer_list) {
-			if (t->bits_per_word || t->speed_hz) {
-				status = mpc512x_psc_spi_transfer_setup(spi, t);
-				if (status < 0)
-					break;
-			}
-
-			if (cs_change)
-				mpc512x_psc_spi_activate_cs(spi);
-			cs_change = t->cs_change;
-
-			status = mpc512x_psc_spi_transfer_rxtx(spi, t);
-			if (status)
+	struct spi_device *spi;
+	unsigned cs_change;
+	int status;
+	struct spi_transfer *t;
+
+	spi = m->spi;
+	cs_change = 1;
+	status = 0;
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->bits_per_word || t->speed_hz) {
+			status = mpc512x_psc_spi_transfer_setup(spi, t);
+			if (status < 0)
 				break;
-			m->actual_length += t->len;
+		}
 
-			if (t->delay_usecs)
-				udelay(t->delay_usecs);
+		if (cs_change)
+			mpc512x_psc_spi_activate_cs(spi);
+		cs_change = t->cs_change;
 
-			if (cs_change)
-				mpc512x_psc_spi_deactivate_cs(spi);
-		}
+		status = mpc512x_psc_spi_transfer_rxtx(spi, t);
+		if (status)
+			break;
+		m->actual_length += t->len;
 
-		m->status = status;
-		m->complete(m->context);
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
 
-		if (status || !cs_change)
+		if (cs_change)
 			mpc512x_psc_spi_deactivate_cs(spi);
+	}
 
-		mpc512x_psc_spi_transfer_setup(spi, NULL);
+	m->status = status;
+	m->complete(m->context);
 
-		spin_lock_irq(&mps->lock);
-	}
-	mps->busy = 0;
-	spin_unlock_irq(&mps->lock);
+	if (status || !cs_change)
+		mpc512x_psc_spi_deactivate_cs(spi);
+
+	mpc512x_psc_spi_transfer_setup(spi, NULL);
+
+	spi_finalize_current_message(master);
+	return status;
+}
+
+static int mpc512x_psc_spi_prep_xfer_hw(struct spi_master *master)
+{
+	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
+	struct mpc52xx_psc __iomem *psc = mps->psc;
+
+	dev_dbg(&master->dev, "%s()\n", __func__);
+
+	/* Zero MR2 */
+	in_8(&psc->mode);
+	out_8(&psc->mode, 0x0);
+
+	/* enable transmitter/receiver */
+	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
+
+	return 0;
+}
+
+static int mpc512x_psc_spi_unprep_xfer_hw(struct spi_master *master)
+{
+	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
+	struct mpc52xx_psc __iomem *psc = mps->psc;
+	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
+
+	dev_dbg(&master->dev, "%s()\n", __func__);
+
+	/* disable transmitter/receiver and fifo interrupt */
+	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
+	out_be32(&fifo->tximr, 0);
+
+	return 0;
 }
 
 static int mpc512x_psc_spi_setup(struct spi_device *spi)
 {
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
 	struct mpc512x_psc_spi_cs *cs = spi->controller_state;
-	unsigned long flags;
 	int ret;
 
 	if (spi->bits_per_word % 8)
@@ -373,28 +371,6 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
 	cs->bits_per_word = spi->bits_per_word;
 	cs->speed_hz = spi->max_speed_hz;
 
-	spin_lock_irqsave(&mps->lock, flags);
-	if (!mps->busy)
-		mpc512x_psc_spi_deactivate_cs(spi);
-	spin_unlock_irqrestore(&mps->lock, flags);
-
-	return 0;
-}
-
-static int mpc512x_psc_spi_transfer(struct spi_device *spi,
-				    struct spi_message *m)
-{
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
-	unsigned long flags;
-
-	m->actual_length = 0;
-	m->status = -EINPROGRESS;
-
-	spin_lock_irqsave(&mps->lock, flags);
-	list_add_tail(&m->queue, &mps->queue);
-	queue_work(mps->workqueue, &mps->work);
-	spin_unlock_irqrestore(&mps->lock, flags);
-
 	return 0;
 }
 
@@ -477,7 +453,7 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
 	struct mpc512x_psc_spi *mps = (struct mpc512x_psc_spi *)dev_id;
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
 
-	/* clear interrupt and wake up the work queue */
+	/* clear interrupt and wake up the rx/tx routine */
 	if (in_be32(&fifo->txisr) &
 	    in_be32(&fifo->tximr) & MPC512x_PSC_FIFO_EMPTY) {
 		out_be32(&fifo->txisr, MPC512x_PSC_FIFO_EMPTY);
@@ -523,7 +499,9 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->setup = mpc512x_psc_spi_setup;
-	master->transfer = mpc512x_psc_spi_transfer;
+	master->prepare_transfer_hardware = mpc512x_psc_spi_prep_xfer_hw;
+	master->transfer_one_message = mpc512x_psc_spi_msg_xfer;
+	master->unprepare_transfer_hardware = mpc512x_psc_spi_unprep_xfer_hw;
 	master->cleanup = mpc512x_psc_spi_cleanup;
 	master->dev.of_node = dev->of_node;
 
@@ -541,31 +519,18 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 			  "mpc512x-psc-spi", mps);
 	if (ret)
 		goto free_master;
+	init_completion(&mps->txisrdone);
 
 	ret = mpc512x_psc_spi_port_config(master, mps);
 	if (ret < 0)
 		goto free_irq;
 
-	spin_lock_init(&mps->lock);
-	init_completion(&mps->txisrdone);
-	INIT_WORK(&mps->work, mpc512x_psc_spi_work);
-	INIT_LIST_HEAD(&mps->queue);
-
-	mps->workqueue =
-		create_singlethread_workqueue(dev_name(master->dev.parent));
-	if (mps->workqueue == NULL) {
-		ret = -EBUSY;
-		goto free_irq;
-	}
-
 	ret = spi_register_master(master);
 	if (ret < 0)
-		goto unreg_master;
+		goto free_irq;
 
 	return ret;
 
-unreg_master:
-	destroy_workqueue(mps->workqueue);
 free_irq:
 	free_irq(mps->irq, mps);
 free_master:
@@ -581,8 +546,6 @@ static int mpc512x_psc_spi_do_remove(struct device *dev)
 	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
 
-	flush_workqueue(mps->workqueue);
-	destroy_workqueue(mps->workqueue);
 	spi_unregister_master(master);
 	free_irq(mps->irq, mps);
 	if (mps->psc)
-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
