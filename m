From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 1/2] spi: Allow master drivers to set realtime priority
Date: Thu, 23 Mar 2017 11:36:45 +0100
Message-ID: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de>
Cc: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
        Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 14af60b6fb3b ("spi/pl022: Add high priority message pump
support") extended the pl022 driver to optionally run the message pump
kworker thread with realtime priority, subject to a bool set by the
platform.

Commit ffbbdd21329f ("spi: create a message queueing infrastructure")
moved a large portion of pl022 to generic code, making the realtime
priority support available to other drivers.

However the priority is set to MAX_RT_PRIO - 1, higher than most IRQs
and identical to the CPU timer clock threads.  This seems excessive so
make the priority configurable.

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi-pl022.c | 4 +++-
 drivers/spi/spi.c       | 8 +++++---
 include/linux/spi/spi.h | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f7f7ba17b40e..f66cc3b6d489 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2153,9 +2153,11 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	master->auto_runtime_pm = true;
 	master->transfer_one_message = pl022_transfer_one_message;
 	master->unprepare_transfer_hardware = pl022_unprepare_transfer_hardware;
-	master->rt = platform_info->rt;
 	master->dev.of_node = dev->of_node;
 
+	if (platform_info->rt)
+		master->rt_prio = MAX_RT_PRIO - 1;
+
 	if (platform_info->num_chipselect && platform_info->chipselects) {
 		for (i = 0; i < num_cs; i++)
 			pl022->chipselects[i] = platform_info->chipselects[i];
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f699ea530b88..3220f6d87a66 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1286,7 +1286,7 @@ static void spi_pump_messages(struct kthread_work *work)
 
 static int spi_init_queue(struct spi_master *master)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
+	struct sched_param param = { .sched_priority = master->rt_prio };
 
 	master->running = false;
 	master->busy = false;
@@ -1308,9 +1308,10 @@ static int spi_init_queue(struct spi_master *master)
 	 * request and the scheduling of the message pump thread. Without this
 	 * setting the message pump thread will remain at default priority.
 	 */
-	if (master->rt) {
+	if (master->rt_prio >= 0 && master->rt_prio < MAX_RT_PRIO) {
 		dev_info(&master->dev,
-			"will run message pump with realtime priority\n");
+			 "will run message pump with realtime priority %d\n",
+			 master->rt_prio);
 		sched_setscheduler(master->kworker_task, SCHED_FIFO, &param);
 	}
 
@@ -1862,6 +1863,7 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 
 	device_initialize(&master->dev);
 	master->bus_num = -1;
+	master->rt_prio = -1;
 	master->num_chipselect = 1;
 	master->dev.class = &spi_master_class;
 	master->dev.parent = dev;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 5a8c4b24f2dc..5ec405669668 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -341,11 +341,11 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @xfer_completion: used by core transfer_one_message()
  * @busy: message pump is busy
  * @running: message pump is running
- * @rt: whether this queue is set to run as a realtime task
  * @auto_runtime_pm: the core should ensure a runtime PM reference is held
  *                   while the hardware is prepared, using the parent
  *                   device for the spidev
  * @max_dma_len: Maximum length of a DMA transfer for the device.
+ * @rt_prio: realtime priority of the message pump (-1 to use default prio)
  * @prepare_transfer_hardware: a message will soon arrive from the queue
  *	so the subsystem requests the driver to prepare the transfer hardware
  *	by issuing this call
@@ -522,12 +522,12 @@ struct spi_master {
 	bool				idling;
 	bool				busy;
 	bool				running;
-	bool				rt;
 	bool				auto_runtime_pm;
 	bool                            cur_msg_prepared;
 	bool				cur_msg_mapped;
 	struct completion               xfer_completion;
 	size_t				max_dma_len;
+	int				rt_prio;
 
 	int (*prepare_transfer_hardware)(struct spi_master *master);
 	int (*transfer_one_message)(struct spi_master *master,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
