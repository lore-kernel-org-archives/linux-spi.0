From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev: Hold spi_lock over all defererences of spi in release()" to the spi tree
Date: Wed, 16 Dec 2015 13:27:07 +0000
Message-ID: <E1a9C6l-0003RZ-GZ@debutante>
References: <1447689999-20632-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vegard Nossum <vegard.nossum-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447689999-20632-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev: Hold spi_lock over all defererences of spi in release()

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

>From 56ea1075e7f07724cf9b91039aa0968a0c70112f Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Mon, 16 Nov 2015 13:57:37 +0000
Subject: [PATCH] spi: spidev: Hold spi_lock over all defererences of spi in
 release()

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
