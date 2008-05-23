From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.23-rc3+] spidev: BKL removal
Date: Thu, 22 May 2008 19:29:07 -0700
Message-ID: <200805221929.08050.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>

Another step to removing ->ioctl and to removing the BKL

Signed-off-by: Alan Cox <alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
[ dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org -- take final step; BKL not needed ]
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Goes on top of the two patches addressing oopsing in "rmmod spi_master".

 drivers/spi/spidev.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/drivers/spi/spidev.c	2008-05-22 13:40:36.000000000 -0700
+++ b/drivers/spi/spidev.c	2008-05-22 18:33:51.000000000 -0700
@@ -229,7 +229,6 @@ static int spidev_message(struct spidev_
 	 * We walk the array of user-provided transfers, using each one
 	 * to initialize a kernel version of the same transfer.
 	 */
-	mutex_lock(&spidev->buf_lock);
 	buf = spidev->buffer;
 	total = 0;
 	for (n = n_xfers, k_tmp = k_xfers, u_tmp = u_xfers;
@@ -297,14 +296,12 @@ static int spidev_message(struct spidev_
 	status = total;
 
 done:
-	mutex_unlock(&spidev->buf_lock);
 	kfree(k_xfers);
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
@@ -342,6 +339,14 @@ spidev_ioctl(struct inode *inode, struct
 	if (spi == NULL)
 		return -ESHUTDOWN;
 
+	/* use the buffer lock here for triple duty:
+	 *  - prevent I/O (from us) so calling spi_setup() is safe;
+	 *  - prevent concurrent SPI_IOC_WR_* from morphing
+	 *    data fields while SPI_IOC_RD_* reads them;
+	 *  - SPI_IOC_MESSAGE needs the buffer locked "normally".
+	 */
+	mutex_lock(&spidev->buf_lock);
+
 	switch (cmd) {
 	/* read requests */
 	case SPI_IOC_RD_MODE:
@@ -457,6 +462,8 @@ spidev_ioctl(struct inode *inode, struct
 		kfree(ioc);
 		break;
 	}
+
+	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
 	return retval;
 }
@@ -532,7 +539,7 @@ static struct file_operations spidev_fop
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
