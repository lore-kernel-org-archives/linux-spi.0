From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spidev: Remove unneeded variable
Date: Sat,  9 May 2015 12:57:19 -0300
Message-ID: <1431187039-10573-1-git-send-email-festevam@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Remove unneeded variable used to store return value.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/returnvar.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spidev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index b00ae96..dd616ff 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -635,7 +635,6 @@ err_find_dev:
 static int spidev_release(struct inode *inode, struct file *filp)
 {
 	struct spidev_data	*spidev;
-	int			status = 0;
 
 	mutex_lock(&device_list_lock);
 	spidev = filp->private_data;
@@ -664,7 +663,7 @@ static int spidev_release(struct inode *inode, struct file *filp)
 	}
 	mutex_unlock(&device_list_lock);
 
-	return status;
+	return 0;
 }
 
 static const struct file_operations spidev_fops = {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
