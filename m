From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fix possible deadlock between internal bus locks and bus_lock_flag" to the spi tree
Date: Fri, 18 Mar 2016 10:58:14 +0000
Message-ID: <E1ags6g-0004Id-Ut@debutante>
References: <1603558.KZbpLAQA15@diego>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1603558.KZbpLAQA15@diego>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fix possible deadlock between internal bus locks and bus_lock_flag

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 24c8cd1b081286fd34340f0e1fc68a774a5a775f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Date: Fri, 18 Mar 2016 11:15:11 +0100
Subject: [PATCH] spi: fix possible deadlock between internal bus locks and
 bus_lock_flag

External users may use spi_bus_lock to get exclusive access. This will
also grab the bus_lock_mutex and may therefore result in a deadlock if
__spi_pump_messages also tries to get the mutex.

Therefore adapt spi_pump_messages as well as spi_sync to preset the
bus_locked parameter according to the master->bus_lock_flag.

Fixes: 49023d2e4ead ("spi: core: Fix deadlock when sending messages")
Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index de2f2f90d799..0239b45eed92 100644
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
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
