From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: spidev: use spi_sync instead of spi_async
Date: Thu, 23 Apr 2015 07:56:01 +0000
Message-ID: <1429775761-3149-1-git-send-email-kernel@martin.sperl.org>
References: <20150422194133.GI22845@sirena.org.uk>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150422194133.GI22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This has the benefit that the "optimization" of the framework in regards
to spi_sync will also benefit spidev users directly and allow running
spi transfers without a necessary context-switch to message-pump.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spidev.c |   30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 92c909e..b00ae96 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -95,37 +95,25 @@ MODULE_PARM_DESC(bufsiz, "data bytes in biggest supported SPI message");
 
 /*-------------------------------------------------------------------------*/
 
-/*
- * We can't use the standard synchronous wrappers for file I/O; we
- * need to protect against async removal of the underlying spi_device.
- */
-static void spidev_complete(void *arg)
-{
-	complete(arg);
-}
-
 static ssize_t
 spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	int status;
-
-	message->complete = spidev_complete;
-	message->context = &done;
+	struct spi_device *spi;
 
 	spin_lock_irq(&spidev->spi_lock);
-	if (spidev->spi == NULL)
+	spi = spidev->spi;
+	spin_unlock_irq(&spidev->spi_lock);
+
+	if (spi == NULL)
 		status = -ESHUTDOWN;
 	else
-		status = spi_async(spidev->spi, message);
-	spin_unlock_irq(&spidev->spi_lock);
+		status = spi_sync(spi, message);
+
+	if (status == 0)
+		status = message->actual_length;
 
-	if (status == 0) {
-		wait_for_completion(&done);
-		status = message->status;
-		if (status == 0)
-			status = message->actual_length;
-	}
 	return status;
 }
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
