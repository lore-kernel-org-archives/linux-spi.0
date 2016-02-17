From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pl022: Remove obsolete struct pl022 members from kerneldoc
Date: Wed, 17 Feb 2016 13:52:12 +0200
Message-ID: <1455709932-12146-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

These structure members were removed in 2012 by the commit ffbbdd21329f
("spi: create a message queueing infrastructure").

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pl022.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 5e5fd77e2711..f7f7ba17b40e 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -346,13 +346,6 @@ struct vendor_data {
  * @clk: outgoing clock "SPICLK" for the SPI bus
  * @master: SPI framework hookup
  * @master_info: controller-specific data from machine setup
- * @kworker: thread struct for message pump
- * @kworker_task: pointer to task for message pump kworker thread
- * @pump_messages: work struct for scheduling work to the message pump
- * @queue_lock: spinlock to syncronise access to message queue
- * @queue: message queue
- * @busy: message pump is busy
- * @running: message pump is running
  * @pump_transfers: Tasklet used in Interrupt Transfer mode
  * @cur_msg: Pointer to current spi_message being processed
  * @cur_transfer: Pointer to current spi_transfer
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
