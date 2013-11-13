From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: Factor validation and initialisation of messages outside lock
Date: Wed, 13 Nov 2013 23:49:02 +0000
Message-ID: <1384386542-18256-1-git-send-email-broonie@kernel.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Currently we do a bunch of per-message validation and initialisation in
__spi_async() which is called with the bus lock held. Since none of this
validation depends on the current bus status there's no need to hold the
lock to do it so split it out into a separate __spi_validate() function
which is called prior to taking the bus lock.

This could be slightly neater but keep things simple for now to show the
code motion clearly.

Based on observations from Martin Sperl.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e29d73d..38492e8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1585,15 +1585,11 @@ int spi_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
-static int __spi_async(struct spi_device *spi, struct spi_message *message)
+static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_master *master = spi->master;
 	struct spi_transfer *xfer;
 
-	message->spi = spi;
-
-	trace_spi_message_submit(message);
-
 	if (list_empty(&message->transfers))
 		return -EINVAL;
 	if (!message->complete)
@@ -1694,6 +1690,18 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 	}
 
 	message->status = -EINPROGRESS;
+
+	return 0;
+}
+
+static int __spi_async(struct spi_device *spi, struct spi_message *message)
+{
+	struct spi_master *master = spi->master;
+
+	message->spi = spi;
+
+	trace_spi_message_submit(message);
+
 	return master->transfer(spi, message);
 }
 
@@ -1732,6 +1740,10 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 	int ret;
 	unsigned long flags;
 
+	ret = __spi_validate(spi, message);
+	if (ret != 0)
+		return ret;
+
 	spin_lock_irqsave(&master->bus_lock_spinlock, flags);
 
 	if (master->bus_lock_flag)
@@ -1780,6 +1792,10 @@ int spi_async_locked(struct spi_device *spi, struct spi_message *message)
 	int ret;
 	unsigned long flags;
 
+	ret = __spi_validate(spi, message);
+	if (ret != 0)
+		return ret;
+
 	spin_lock_irqsave(&master->bus_lock_spinlock, flags);
 
 	ret = __spi_async(spi, message);
-- 
1.8.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
