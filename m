From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/4] spi: Move queue data structure initialisation to main master init
Date: Thu, 11 Dec 2014 12:26:39 +0000
Message-ID: <1418300802-3803-1-git-send-email-broonie@kernel.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since most devices now do use the standard queue and in order to avoid
initialisation ordering issues being introduced by further refactorings
to improve performance move the initialisation of the queue and the lock
for it to the main master allocation.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index da7e6225b8f6..b81ccdb1bc16 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -989,9 +989,6 @@ static int spi_init_queue(struct spi_master *master)
 {
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
 
-	INIT_LIST_HEAD(&master->queue);
-	spin_lock_init(&master->queue_lock);
-
 	master->running = false;
 	master->busy = false;
 
@@ -1595,6 +1592,8 @@ int spi_register_master(struct spi_master *master)
 		dynamic = 1;
 	}
 
+	INIT_LIST_HEAD(&master->queue);
+	spin_lock_init(&master->queue_lock);
 	spin_lock_init(&master->bus_lock_spinlock);
 	mutex_init(&master->bus_lock_mutex);
 	master->bus_lock_flag = 0;
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
