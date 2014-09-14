From: Jeff Epler <jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Subject: [RFC 3/4] spidev: actually use synchronous transfers
Date: Sun, 14 Sep 2014 09:45:07 -0500
Message-ID: <1410705908-20847-4-git-send-email-jepler@unpythonic.net>
References: <1410705908-20847-1-git-send-email-jepler@unpythonic.net>
To: linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410705908-20847-1-git-send-email-jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

this reduces a source of latency
---
 drivers/spi/spidev.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index dda7632..6e37c59 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -120,15 +120,9 @@ spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 	if (spidev->spi == NULL)
 		status = -ESHUTDOWN;
 	else
-		status = spi_async(spidev->spi, message);
+		status = spi_sync(spidev->spi, message);
 	spin_unlock_irq(&spidev->spi_lock);
 
-	if (status == 0) {
-		wait_for_completion(&done);
-		status = message->status;
-		if (status == 0)
-			status = message->actual_length;
-	}
 	return status;
 }
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
