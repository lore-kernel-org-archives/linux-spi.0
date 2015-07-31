From: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: [PATCH] spi: spidev: fix inconsistent indenting
Date: Fri, 31 Jul 2015 13:42:29 +0100
Message-ID: <1438346549-24389-1-git-send-email-colin.king@canonical.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

Fix inconsistent indenting in spidev_open, no functional change.

Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/spi/spidev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index c7de641..a76c559 100644
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
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
