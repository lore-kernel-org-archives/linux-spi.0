From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev: fix inconsistent indenting" to the spi tree
Date: Tue, 04 Aug 2015 18:48:23 +0100
Message-ID: <E1ZMgK7-0007zN-9H@finisterre>
References: <1438346549-24389-1-git-send-email-colin.king@canonical.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438346549-24389-1-git-send-email-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev: fix inconsistent indenting

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

>From 89a6356676eba38e498507b5b67dcc07a714a149 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Date: Fri, 31 Jul 2015 13:42:29 +0100
Subject: [PATCH] spi: spidev: fix inconsistent indenting

Fix inconsistent indenting in spidev_open, no functional change.

Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spidev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9d8841e..029463a 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -602,11 +602,11 @@ static int spidev_open(struct inode *inode, struct file *filp)
 	if (!spidev->tx_buffer) {
 		spidev->tx_buffer = kmalloc(bufsiz, GFP_KERNEL);
 		if (!spidev->tx_buffer) {
-				dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
-				status = -ENOMEM;
+			dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
+			status = -ENOMEM;
 			goto err_find_dev;
-			}
 		}
+	}
 
 	if (!spidev->rx_buffer) {
 		spidev->rx_buffer = kmalloc(bufsiz, GFP_KERNEL);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
