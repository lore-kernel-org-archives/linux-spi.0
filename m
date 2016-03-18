From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2] spi: fix possible deadlock between internal bus locks and bus_lock_flag
Date: Fri, 18 Mar 2016 11:15:11 +0100
Message-ID: <1603558.KZbpLAQA15@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
	Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

External users may use spi_bus_lock to get exclusive access. This will
also grab the bus_lock_mutex and may therefore result in a deadlock if
__spi_pump_messages also tries to get the mutex.

Therefore adapt spi_pump_messages as well as spi_sync to preset the
bus_locked parameter according to the master->bus_lock_flag.

Fixes: 49023d2e4ead ("spi: core: Fix deadlock when sending messages")
Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
changes in v2:
- move the second check from __spi_pump_messages to its calling functions
  spi_pump_messages and __spi_sync as suggested by Vignesh

 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index de2f2f9..0239b45 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1209,7 +1209,7 @@ static void spi_pump_messages(struct kthread_work *work)
 	struct spi_master *master =
 		container_of(work, struct spi_master, pump_messages);
 
-	__spi_pump_messages(master, true, false);
+	__spi_pump_messages(master, true, master->bus_lock_flag);
 }
 
 static int spi_init_queue(struct spi_master *master)
@@ -2853,7 +2853,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
  */
 int spi_sync(struct spi_device *spi, struct spi_message *message)
 {
-	return __spi_sync(spi, message, 0);
+	return __spi_sync(spi, message, spi->master->bus_lock_flag);
 }
 EXPORT_SYMBOL_GPL(spi_sync);
 
-- 
2.6.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
