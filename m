From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: spidev: Hold spi_lock over all defererences of spi in release()
Date: Mon, 16 Nov 2015 16:06:39 +0000
Message-ID: <1447689999-20632-1-git-send-email-broonie@kernel.org>
Cc: Vegard Nossum <vegard.nossum-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We use the spi_lock spinlock to protect against races between the device
being removed and file operations on the spidev.  This means that in the
removal path all references to the device need to be done under lock as
in removal we dropping references to the device.

Reported-by: Vegard Nossum <vegard.nossum-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 91a0fcd72423..d0e7dfc647cf 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -651,11 +651,11 @@ static int spidev_release(struct inode *inode, struct file *filp)
 		kfree(spidev->rx_buffer);
 		spidev->rx_buffer = NULL;
 
+		spin_lock_irq(&spidev->spi_lock);
 		if (spidev->spi)
 			spidev->speed_hz = spidev->spi->max_speed_hz;
 
 		/* ... after we unbound from the underlying device? */
-		spin_lock_irq(&spidev->spi_lock);
 		dofree = (spidev->spi == NULL);
 		spin_unlock_irq(&spidev->spi_lock);
 
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
