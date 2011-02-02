From: Unknown <unknown@unknown.invalid>
Subject: [PATCH] spi: spidev: Add 32 bit compat ioctl()
Date: Wed,  2 Feb 2011 11:56:16 +0100
Message-ID: <35368.5833550573$1296644544@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,
	Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
From: y
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>

Add the compat_ioctl for operations on /dev/spi* so that 32 bit
userspace applications can access SPI. As far as I can see all data
structure are already prepared for that, so no additional conversion has
to be done.

My use case is MIPS with N32 userspace ABI and toolchain, and that was
also the platform where I tested it successfully (Cavium Octeon).

Signed-off-by: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
---
 drivers/spi/spidev.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 4e6245e..95c3f10 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -471,6 +471,14 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return retval;
 }
 
+#ifdef CONFIG_COMPAT
+static long
+spidev_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	return spidev_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif /* CONFIG_COMPAT */
+
 static int spidev_open(struct inode *inode, struct file *filp)
 {
 	struct spidev_data	*spidev;
@@ -543,6 +551,9 @@ static const struct file_operations spidev_fops = {
 	.write =	spidev_write,
 	.read =		spidev_read,
 	.unlocked_ioctl = spidev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = spidev_compat_ioctl,
+#endif
 	.open =		spidev_open,
 	.release =	spidev_release,
 	.llseek =	no_llseek,
-- 
1.7.1


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
