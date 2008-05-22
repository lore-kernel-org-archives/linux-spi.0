From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: [PATCH] spi: Push the BKL down into the drivers
Date: Thu, 22 May 2008 22:45:09 +0100
Message-ID: <20080522224509.29ede566@core>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Another step to removing ->ioctl and to removing the BKL

Signed-off-by: Alan Cox <alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index b3518ca..67e907c 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -29,6 +29,7 @@
 #include <linux/errno.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/smp_lock.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spidev.h>
@@ -240,9 +241,8 @@ done:
 	return status;
 }
 
-static int
-spidev_ioctl(struct inode *inode, struct file *filp,
-		unsigned int cmd, unsigned long arg)
+static long
+spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	int			err = 0;
 	int			retval = 0;
@@ -269,6 +269,7 @@ spidev_ioctl(struct inode *inode, struct file *filp,
 	if (err)
 		return -EFAULT;
 
+	lock_kernel();
 	spidev = filp->private_data;
 	spi = spidev->spi;
 
@@ -357,7 +358,8 @@ spidev_ioctl(struct inode *inode, struct file *filp,
 		/* segmented and/or full-duplex I/O request */
 		if (_IOC_NR(cmd) != _IOC_NR(SPI_IOC_MESSAGE(0))
 				|| _IOC_DIR(cmd) != _IOC_WRITE)
-			return -ENOTTY;
+			retval = -ENOTTY;
+			break;
 
 		tmp = _IOC_SIZE(cmd);
 		if ((tmp % sizeof(struct spi_ioc_transfer)) != 0) {
@@ -385,6 +387,7 @@ spidev_ioctl(struct inode *inode, struct file *filp,
 		kfree(ioc);
 		break;
 	}
+	unlock_kernel();
 	return retval;
 }
 
@@ -447,7 +450,7 @@ static struct file_operations spidev_fops = {
 	 */
 	.write =	spidev_write,
 	.read =		spidev_read,
-	.ioctl =	spidev_ioctl,
+	.unlocked_ioctl = spidev_ioctl,
 	.open =		spidev_open,
 	.release =	spidev_release,
 };

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
