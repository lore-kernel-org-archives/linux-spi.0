From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: Add cond_resched() in main message processing loop
Date: Mon, 15 Feb 2016 18:34:41 +0000
Message-ID: <1455561281-18573-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When a controller has only PIO support it is very likely that we will
run into use cases where we spend a very large amount of time consuming
CPU.  Code that does this should call cond_resched() every once in a
while to give other tasks more of a chance to run so do that in the main
SPI loop, the overhead is negligable if it's not needed.

Suggested-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0ad55946e388..4252a112985c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1207,6 +1207,9 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 		return;
 	}
 	mutex_unlock(&master->bus_lock_mutex);
+
+	/* Prod the scheduler in case transfer_one() was busy waiting */
+	cond_resched();
 }
 
 /**
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
