From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/4] spi: Allow SPI devices to specify that they are timing sensitive
Date: Fri, 10 May 2019 15:34:35 -0700
Message-ID: <20190510223437.84368-3-dianders@chromium.org>
References: <20190510223437.84368-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510223437.84368-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If a device on the SPI bus is very sensitive to timing then it may be
necessary (for correctness) not to get interrupted during a transfer.
One example is the EC (Embedded Controller) on Chromebooks.  The
Chrome OS EC will drop a transfer if more than ~8ms passes between the
chip select being asserted and the transfer finishing.

The SPI framework already has code to handle the case where transfers
are timing senstive.  It can set its message pumping thread to
realtime to to minimize interruptions during the transfer.  However,
at the moment, this mode can only be requested by a SPI controller.
Let's allow the drivers for SPI devices to also request this mode.

NOTE: at the moment if a given device on a bus says that it's timing
sensitive then we'll pump all messages on that bus at high priority.
It is possible we might want to relax this in the future but it seems
like it should be fine for now.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi.c       | 34 ++++++++++++++++++++++++++++------
 include/linux/spi/spi.h |  3 +++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0597f7086de3..d117ab3adafa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1367,10 +1367,30 @@ static void spi_pump_messages(struct kthread_work *work)
 	__spi_pump_messages(ctlr, true);
 }
 
-static int spi_init_queue(struct spi_controller *ctlr)
+/**
+ * spi_boost_thread_priority - set the controller to pump at realtime priority
+ * @ctlr: controller to boost priority of
+ *
+ * This can be called because the controller requested realtime priority
+ * (by setting the ->rt value before calling spi_register_controller()) or
+ * because a device on the bus said that its transfers were timing senstive.
+ *
+ * NOTE: at the moment if any device on a bus says it is timing sensitive then
+ * all the devices on this bus will do transfers at realtime priority.  If
+ * this eventually becomes a problem we may see if we can find a way to boost
+ * the priority only temporarily during relevant transfers.
+ */
+static void spi_boost_thread_priority(struct spi_controller *ctlr)
 {
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
 
+	dev_info(&ctlr->dev,
+		"will run message pump with realtime priority\n");
+	sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
+}
+
+static int spi_init_queue(struct spi_controller *ctlr)
+{
 	ctlr->running = false;
 	ctlr->busy = false;
 
@@ -1390,11 +1410,8 @@ static int spi_init_queue(struct spi_controller *ctlr)
 	 * request and the scheduling of the message pump thread. Without this
 	 * setting the message pump thread will remain at default priority.
 	 */
-	if (ctlr->rt) {
-		dev_info(&ctlr->dev,
-			"will run message pump with realtime priority\n");
-		sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
-	}
+	if (ctlr->rt)
+		spi_boost_thread_priority(ctlr);
 
 	return 0;
 }
@@ -2985,6 +3002,11 @@ int spi_setup(struct spi_device *spi)
 
 	spi_set_cs(spi, false);
 
+	if (spi->timing_sensitive && !spi->controller->rt) {
+		spi->controller->rt = true;
+		spi_boost_thread_priority(spi->controller);
+	}
+
 	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd22ad31..ef6bdd4d25f2 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -109,6 +109,8 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	This may be changed by the device's driver, or left at the
  *	default (0) indicating protocol words are eight bit bytes.
  *	The spi_transfer.bits_per_word can override this for each transfer.
+ * @timing_sensitive: Transfers for this device are senstive to timing
+ *	so we should do our transfer at high priority.
  * @irq: Negative, or the number passed to request_irq() to receive
  *	interrupts from this device.
  * @controller_state: Controller's runtime state
@@ -143,6 +145,7 @@ struct spi_device {
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
+	bool			timing_sensitive;
 	u32			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
-- 
2.21.0.1020.gf2820cf01a-goog
