From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: don't lock the bus in __spi_pump_messages if it is already locked
Date: Fri, 18 Mar 2016 00:18:19 +0100
Message-ID: <1848110.TJtF6nar8z@diego>
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

Fixes: 49023d2e4ead ("spi: core: Fix deadlock when sending messages")
Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index de2f2f9..62f962b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1160,7 +1160,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread,
 		}
 	}
 
-	if (!bus_locked)
+	if (!bus_locked && !master->bus_lock_flag)
 		mutex_lock(&master->bus_lock_mutex);
 
 	trace_spi_message_start(master->cur_msg);
@@ -1192,7 +1192,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread,
 	}
 
 out:
-	if (!bus_locked)
+	if (!bus_locked && !master->bus_lock_flag)
 		mutex_unlock(&master->bus_lock_mutex);
 
 	/* Prod the scheduler in case transfer_one() was busy waiting */
-- 
2.6.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
