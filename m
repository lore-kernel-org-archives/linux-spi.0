From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH 2/2] spidev: Adjust five checks for null pointers
Date: Wed, 17 May 2017 17:47:29 +0200
Message-ID: <df3e58c6-f70d-a5d3-102e-4fab2f7df126@users.sourceforge.net>
References: <c5452d8c-d123-d5e9-b2cc-a386d1325aec@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c5452d8c-d123-d5e9-b2cc-a386d1325aec-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date: Wed, 17 May 2017 17:30:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spidev.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e6dc37fbea4e..846c54129744 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -106,8 +106,7 @@ spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 	spin_lock_irq(&spidev->spi_lock);
 	spi = spidev->spi;
 	spin_unlock_irq(&spidev->spi_lock);
-
-	if (spi == NULL)
+	if (!spi)
 		status = -ESHUTDOWN;
 	else
 		status = spi_sync(spi, message);
@@ -218,7 +217,7 @@ static int spidev_message(struct spidev_data *spidev,
 
 	spi_message_init(&msg);
 	k_xfers = kcalloc(n_xfers, sizeof(*k_tmp), GFP_KERNEL);
-	if (k_xfers == NULL)
+	if (!k_xfers)
 		return -ENOMEM;
 
 	/* Construct spi_message, copying any tx data to bounce buffer.
@@ -387,8 +386,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	spin_lock_irq(&spidev->spi_lock);
 	spi = spi_dev_get(spidev->spi);
 	spin_unlock_irq(&spidev->spi_lock);
-
-	if (spi == NULL)
+	if (!spi)
 		return -ESHUTDOWN;
 
 	/* use the buffer lock here for triple duty:
@@ -535,8 +533,7 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 	spin_lock_irq(&spidev->spi_lock);
 	spi = spi_dev_get(spidev->spi);
 	spin_unlock_irq(&spidev->spi_lock);
-
-	if (spi == NULL)
+	if (!spi)
 		return -ESHUTDOWN;
 
 	/* SPI_IOC_MESSAGE needs the buffer locked "normally" */
@@ -655,7 +652,7 @@ static int spidev_release(struct inode *inode, struct file *filp)
 			spidev->speed_hz = spidev->spi->max_speed_hz;
 
 		/* ... after we unbound from the underlying device? */
-		dofree = (spidev->spi == NULL);
+		dofree = !spidev->spi;
 		spin_unlock_irq(&spidev->spi_lock);
 
 		if (dofree)
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
