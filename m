From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH v2 1/2] spi: add check_finished() callback
Date: Sun, 11 Dec 2016 21:03:49 +0100
Message-ID: <20161211200350.13590-2-hauke@hauke-m.de>
References: <20161211200350.13590-1-hauke@hauke-m.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161211200350.13590-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This callback checks if the transfer really finished. This allows a
driver to directly call the completion list in the irq handler and it
does not have to bushy wait till the hardware is really finished in the
IRQ handler. This is needed for the Lantiq driver.

Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
---
 drivers/spi/spi.c       | 10 ++++++++++
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 838783c..8702cdf 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1013,6 +1013,16 @@ static int spi_transfer_one_message(struct spi_master *master,
 								 msecs_to_jiffies(ms));
 			}
 
+			if (master->check_finished) {
+				ret = master->check_finished(master, ms);
+				if (ret) {
+					dev_err(&msg->spi->dev,
+						"SPI transfer not finished: %i\n",
+						ret);
+					msg->status = ret;
+				}
+			}
+
 			if (ms == 0) {
 				SPI_STATISTICS_INCREMENT_FIELD(statm,
 							       timedout);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4b743ac..2b851a6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -370,6 +370,9 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *                    transfer_one_message are mutually exclusive; when both
  *                    are set, the generic subsystem does not call your
  *                    transfer_one callback.
+ * @check_finished: This callback allows the driver to check if the message
+ *		    was fully transferred. return a negative value in case
+ *		    of an error.
  * @handle_err: the subsystem calls the driver to handle an error that occurs
  *		in the generic implementation of transfer_one_message().
  * @unprepare_message: undo any work done by prepare_message().
@@ -546,6 +549,7 @@ struct spi_master {
 	void (*set_cs)(struct spi_device *spi, bool enable);
 	int (*transfer_one)(struct spi_master *master, struct spi_device *spi,
 			    struct spi_transfer *transfer);
+	int (*check_finished)(struct spi_master *master, unsigned long timeout);
 	void (*handle_err)(struct spi_master *master,
 			   struct spi_message *message);
 
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
