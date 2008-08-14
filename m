From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.27-rc3] spi: bugfix spi_add_device()
	with duplicate chipselects
Date: Thu, 14 Aug 2008 02:15:13 -0700
Message-ID: <200808140215.13641.david-b@pacbell.net>
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

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

When reviewing a recent patch I noticed a potential trouble spot in
the registration of new SPI devices.  The SPI master driver is told to
set the device up before adding it to the driver model, so that it's
always properly set up when probe() is called.  (This is important,
because in the case of inverted chipselects, this device can make the
bus misbehave until it's properly deselected.  It's got to be set up
even if no driver binds to the device.)

The trouble spot is that it doesn't first verify that no other device
has been added using that chipselect.  If such a device has been added,
its configuration gets trashed.  (Fortunately this has not been a
common error!)

The fix here adds an explicit check, and a mutex to protect the relevant
critical region.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi.c |   41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

--- a/drivers/spi/spi.c	2008-08-06 18:22:57.000000000 -0700
+++ b/drivers/spi/spi.c	2008-08-06 18:32:57.000000000 -0700
@@ -219,6 +219,8 @@ struct spi_device *spi_alloc_device(stru
 }
 EXPORT_SYMBOL_GPL(spi_alloc_device);
 
+static DEFINE_MUTEX(spi_add_lock);
+
 /**
  * spi_add_device - Add spi_device allocated with spi_alloc_device
  * @spi: spi_device to register
@@ -226,7 +228,7 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
  * Companion function to spi_alloc_device.  Devices allocated with
  * spi_alloc_device can be added onto the spi bus with this function.
  *
- * Returns 0 on success; non-zero on failure
+ * Returns 0 on success; negative errno on failure
  */
 int spi_add_device(struct spi_device *spi)
 {
@@ -246,26 +248,43 @@ int spi_add_device(struct spi_device *sp
 			"%s.%u", spi->master->dev.bus_id,
 			spi->chip_select);
 
-	/* drivers may modify this initial i/o setup */
+
+	/* We need to make sure there's no other device with this
+	 * chipselect **BEFORE** we call setup(), else we'll trash
+	 * its configuration.  Lock against concurrent add() calls.
+	 */
+	mutex_lock(&spi_add_lock);
+
+	if (bus_find_device_by_name(&spi_bus_type, NULL, spi->dev.bus_id)
+			!= NULL) {
+		dev_err(dev, "chipselect %d already in use\n",
+				spi->chip_select);
+		status = -EBUSY;
+		goto done;
+	}
+
+	/* Drivers may modify this initial i/o setup, but will
+	 * normally rely on the device being setup.  Devices
+	 * using SPI_CS_HIGH can't coexist well otherwise...
+	 */
 	status = spi->master->setup(spi);
 	if (status < 0) {
 		dev_err(dev, "can't %s %s, status %d\n",
 				"setup", spi->dev.bus_id, status);
-		return status;
+		goto done;
 	}
 
-	/* driver core catches callers that misbehave by defining
-	 * devices that already exist.
-	 */
+	/* Device may be bound to an active driver when this returns */
 	status = device_add(&spi->dev);
-	if (status < 0) {
+	if (status < 0)
 		dev_err(dev, "can't %s %s, status %d\n",
 				"add", spi->dev.bus_id, status);
-		return status;
-	}
+	else
+		dev_dbg(dev, "registered child %s\n", spi->dev.bus_id);
 
-	dev_dbg(dev, "registered child %s\n", spi->dev.bus_id);
-	return 0;
+done:
+	mutex_unlock(&spi_add_lock);
+	return status;
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
