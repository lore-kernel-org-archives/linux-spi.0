From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH v3 1/2] spi: add transfer_status() callback
Date: Tue,  3 Jan 2017 18:20:14 +0100
Message-ID: <20170103172015.13052-2-hauke@hauke-m.de>
References: <20170103172015.13052-1-hauke@hauke-m.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170103172015.13052-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This callback allows a driver to return the status of the SPI transfer
which was asynchronously scheduled by transfer_one().

Currently a call to spi_finalize_current_transfer() will mark the
transfer as transferred successfully. To return an error it is only
possible to not call spi_finalize_current_transfer() at all and let
this time out and result in a timeout error. With this callback the
driver gets asked about the status of the last transfer.

In the Lantiq driver I want to use this to circumvent a strange
hardware design in addition.

Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
---
 drivers/spi/spi.c       | 14 ++++++++++++++
 include/linux/spi/spi.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e3220c..745dc9c5fee2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1021,6 +1021,20 @@ static int spi_transfer_one_message(struct spi_master *master,
 								 msecs_to_jiffies(ms));
 			}
 
+			if (master->transfer_status) {
+				ret = master->transfer_status(master, ms);
+				if (ret) {
+					SPI_STATISTICS_INCREMENT_FIELD(statm,
+								       errors);
+					SPI_STATISTICS_INCREMENT_FIELD(stats,
+								       errors);
+					dev_err(&msg->spi->dev,
+						"SPI transfer status: %d\n",
+						ret);
+					goto out;
+				}
+			}
+
 			if (ms == 0) {
 				SPI_STATISTICS_INCREMENT_FIELD(statm,
 							       timedout);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 75c6bd0ac605..5b90b3086de8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -370,6 +370,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *                    transfer_one_message are mutually exclusive; when both
  *                    are set, the generic subsystem does not call your
  *                    transfer_one callback.
+ * @transfer_status: This callback allows the driver to return an error code
+ *		     in case the scheduled single spi transfer failed.
  * @handle_err: the subsystem calls the driver to handle an error that occurs
  *		in the generic implementation of transfer_one_message().
  * @unprepare_message: undo any work done by prepare_message().
@@ -547,6 +549,7 @@ struct spi_master {
 	void (*set_cs)(struct spi_device *spi, bool enable);
 	int (*transfer_one)(struct spi_master *master, struct spi_device *spi,
 			    struct spi_transfer *transfer);
+	int (*transfer_status)(struct spi_master *master, unsigned long timeout);
 	void (*handle_err)(struct spi_master *master,
 			   struct spi_message *message);
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
