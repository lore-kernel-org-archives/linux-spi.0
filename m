From: Jeff Epler <jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Subject: [RFC 2/4] spidev: Avoid runtime memory allocations
Date: Sun, 14 Sep 2014 09:45:06 -0500
Message-ID: <1410705908-20847-3-git-send-email-jepler@unpythonic.net>
References: <1410705908-20847-1-git-send-email-jepler@unpythonic.net>
To: linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410705908-20847-1-git-send-email-jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

allocating bounce and k_xfers at every iteration was a source of
excess delays.
---
 drivers/spi/spidev.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2e0655d..dda7632 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -85,6 +85,8 @@ struct spidev_data {
 	struct mutex		buf_lock;
 	unsigned		users;
 	u8			*buffer;
+        struct spi_ioc_transfer *bounce;
+        struct spi_transfer     *k_xfers;
 };
 
 static LIST_HEAD(device_list);
@@ -227,9 +229,9 @@ static int spidev_message(struct spidev_data *spidev,
 	int			status = -EFAULT;
 
 	spi_message_init(&msg);
-	k_xfers = kcalloc(n_xfers, sizeof(*k_tmp), GFP_KERNEL);
-	if (k_xfers == NULL)
-		return -ENOMEM;
+        if (n_xfers * sizeof(*k_tmp) > bufsiz)
+                return -ENOMEM;
+	k_xfers = spidev->k_xfers;
 
 	/* Construct spi_message, copying any tx data to bounce buffer.
 	 * We walk the array of user-provided transfers, using each one
@@ -302,7 +304,6 @@ static int spidev_message(struct spidev_data *spidev,
 	status = total;
 
 done:
-	kfree(k_xfers);
 	return status;
 }
 
@@ -451,8 +452,12 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (n_ioc == 0)
 			break;
 
+                if(tmp > bufsiz) {
+			retval = -EINVAL;
+			break;
+                }
 		/* copy into scratch area */
-		ioc = kmalloc(tmp, GFP_KERNEL);
+		ioc = spidev->bounce;
 		if (!ioc) {
 			retval = -ENOMEM;
 			break;
@@ -465,7 +470,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		/* translate to spi_message, execute */
 		retval = spidev_message(spidev, ioc, n_ioc);
-		kfree(ioc);
 		break;
 	}
 
@@ -504,6 +508,19 @@ static int spidev_open(struct inode *inode, struct file *filp)
 				dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
 				status = -ENOMEM;
 			}
+			spidev->bounce = kmalloc(bufsiz, GFP_KERNEL);
+			if (!spidev->bounce) {
+				dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
+                                kfree(spidev->buffer);
+				status = -ENOMEM;
+			}
+			spidev->k_xfers = kmalloc(bufsiz, GFP_KERNEL);
+			if (!spidev->k_xfers) {
+				dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
+                                kfree(spidev->buffer);
+                                kfree(spidev->bounce);
+				status = -ENOMEM;
+			}
 		}
 		if (status == 0) {
 			spidev->users++;
@@ -534,6 +551,12 @@ static int spidev_release(struct inode *inode, struct file *filp)
 		kfree(spidev->buffer);
 		spidev->buffer = NULL;
 
+		kfree(spidev->bounce);
+		spidev->bounce = NULL;
+
+		kfree(spidev->k_xfers);
+		spidev->k_xfers = NULL;
+
 		/* ... after we unbound from the underlying device? */
 		spin_lock_irq(&spidev->spi_lock);
 		dofree = (spidev->spi == NULL);
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
