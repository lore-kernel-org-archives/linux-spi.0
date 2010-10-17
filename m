From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/28] Blackfin SPI: convert queue run
	state to true/false
Date: Sun, 17 Oct 2010 18:59:22 -0400
Message-ID: <1287356381-31495-10-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

No point in creating our own version of true/false defines when there is
already a standard stdbool available to us.

Reported-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 045c82a..40d9f64 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -41,8 +41,6 @@ MODULE_LICENSE("GPL");
 #define RUNNING_STATE	((void *)1)
 #define DONE_STATE	((void *)2)
 #define ERROR_STATE	((void *)-1)
-#define QUEUE_RUNNING	0
-#define QUEUE_STOPPED	1
 
 struct driver_data {
 	/* Driver model hookup */
@@ -66,7 +64,7 @@ struct driver_data {
 	spinlock_t lock;
 	struct list_head queue;
 	int busy;
-	int run;
+	bool running;
 
 	/* Message Transfer pump */
 	struct tasklet_struct pump_transfers;
@@ -871,7 +869,7 @@ static void bfin_spi_pump_messages(struct work_struct *work)
 
 	/* Lock queue and check for queue work */
 	spin_lock_irqsave(&drv_data->lock, flags);
-	if (list_empty(&drv_data->queue) || drv_data->run == QUEUE_STOPPED) {
+	if (list_empty(&drv_data->queue) || !drv_data->running) {
 		/* pumper kicked off but no work to do */
 		drv_data->busy = 0;
 		spin_unlock_irqrestore(&drv_data->lock, flags);
@@ -926,7 +924,7 @@ static int bfin_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 
 	spin_lock_irqsave(&drv_data->lock, flags);
 
-	if (drv_data->run == QUEUE_STOPPED) {
+	if (!drv_data->running) {
 		spin_unlock_irqrestore(&drv_data->lock, flags);
 		return -ESHUTDOWN;
 	}
@@ -938,7 +936,7 @@ static int bfin_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	dev_dbg(&spi->dev, "adding an msg in transfer() \n");
 	list_add_tail(&msg->queue, &drv_data->queue);
 
-	if (drv_data->run == QUEUE_RUNNING && !drv_data->busy)
+	if (drv_data->running && !drv_data->busy)
 		queue_work(drv_data->workqueue, &drv_data->pump_messages);
 
 	spin_unlock_irqrestore(&drv_data->lock, flags);
@@ -1177,7 +1175,7 @@ static inline int bfin_spi_init_queue(struct driver_data *drv_data)
 	INIT_LIST_HEAD(&drv_data->queue);
 	spin_lock_init(&drv_data->lock);
 
-	drv_data->run = QUEUE_STOPPED;
+	drv_data->running = false;
 	drv_data->busy = 0;
 
 	/* init transfer tasklet */
@@ -1200,12 +1198,12 @@ static inline int bfin_spi_start_queue(struct driver_data *drv_data)
 
 	spin_lock_irqsave(&drv_data->lock, flags);
 
-	if (drv_data->run == QUEUE_RUNNING || drv_data->busy) {
+	if (drv_data->running || drv_data->busy) {
 		spin_unlock_irqrestore(&drv_data->lock, flags);
 		return -EBUSY;
 	}
 
-	drv_data->run = QUEUE_RUNNING;
+	drv_data->running = true;
 	drv_data->cur_msg = NULL;
 	drv_data->cur_transfer = NULL;
 	drv_data->cur_chip = NULL;
@@ -1230,7 +1228,7 @@ static inline int bfin_spi_stop_queue(struct driver_data *drv_data)
 	 * execution path (pump_messages) would be required to call wake_up or
 	 * friends on every SPI message. Do this instead
 	 */
-	drv_data->run = QUEUE_STOPPED;
+	drv_data->running = false;
 	while (!list_empty(&drv_data->queue) && drv_data->busy && limit--) {
 		spin_unlock_irqrestore(&drv_data->lock, flags);
 		msleep(10);
-- 
1.7.3.1
