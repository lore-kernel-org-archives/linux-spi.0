From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24-rc4] spi core stops updating
	dev->power.power_state
Date: Tue, 4 Dec 2007 11:59:42 -0800
Message-ID: <200712041159.43712.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Don't update dev->power.power_state any more in the SPI core.  The
only reason to update this scheduled-to-be-removed field was to make
the already-removed /sys/devices/.../power/state files work better.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

--- pstate.orig/drivers/spi/spi.c	2007-12-04 09:36:40.000000000 -0800
+++ pstate/drivers/spi/spi.c	2007-12-04 11:11:33.000000000 -0800
@@ -77,39 +77,33 @@ static int spi_uevent(struct device *dev
 
 #ifdef	CONFIG_PM
 
-/*
- * NOTE:  the suspend() method for an spi_master controller driver
- * should verify that all its child devices are marked as suspended;
- * suspend requests delivered through sysfs power/state files don't
- * enforce such constraints.
- */
 static int spi_suspend(struct device *dev, pm_message_t message)
 {
-	int			value;
+	int			value = 0;
 	struct spi_driver	*drv = to_spi_driver(dev->driver);
 
-	if (!drv || !drv->suspend)
-		return 0;
-
 	/* suspend will stop irqs and dma; no more i/o */
-	value = drv->suspend(to_spi_device(dev), message);
-	if (value == 0)
-		dev->power.power_state = message;
+	if (drv) {
+		if (drv->suspend)
+			value = drv->suspend(to_spi_device(dev), message);
+		else
+			dev_dbg(dev, "... can't suspend\n");
+	}
 	return value;
 }
 
 static int spi_resume(struct device *dev)
 {
-	int			value;
+	int			value = 0;
 	struct spi_driver	*drv = to_spi_driver(dev->driver);
 
-	if (!drv || !drv->resume)
-		return 0;
-
 	/* resume may restart the i/o queue */
-	value = drv->resume(to_spi_device(dev));
-	if (value == 0)
-		dev->power.power_state = PMSG_ON;
+	if (drv) {
+		if (drv->resume)
+			value = drv->resume(to_spi_device(dev));
+		else
+			dev_dbg(dev, "... can't resume\n");
+	}
 	return value;
 }
 

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
