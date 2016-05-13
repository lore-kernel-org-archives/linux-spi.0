From: Thomas Perrot <thomas.perrot-cVvwS2TCF4I@public.gmane.org>
Subject: [PATCH] spi: fix __spi_pump_messages deadlock
Date: Fri, 13 May 2016 11:31:32 +0200
Message-ID: <1463131892-5392-1-git-send-email-thomas.perrot@tupi.fr>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Thomas Perrot <thomas.perrot-cVvwS2TCF4I@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Thomas Perrot <thomas.perrot-cVvwS2TCF4I@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0239b45..785080a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1192,7 +1192,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread,
 	}
 
 out:
-	if (!bus_locked)
+	if (bus_locked)
 		mutex_unlock(&master->bus_lock_mutex);
 
 	/* Prod the scheduler in case transfer_one() was busy waiting */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
