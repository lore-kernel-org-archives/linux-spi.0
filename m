From: Jun Chen <jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Add the flag indicate to registe new device as
	children of master or not.
Date: Tue, 18 Dec 2012 11:29:34 -0500
Message-ID: <1355848174.1435.25.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bi Chao <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Because there are two aim when allocating the new device, one is for children of master,
other is for master. So this patch add one flag to indicate different purpose.

Signed-off-by: Bi Chao <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Chen Jun <jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c       |   16 +++++++++++-----
 include/linux/spi/spi.h |    3 ++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 718cc1f..06f69ce 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -300,6 +300,8 @@ static DEFINE_MUTEX(board_lock);
 /**
  * spi_alloc_device - Allocate a new SPI device
  * @master: Controller to which device is connected
+ * device_was_children_of_master is flag which the device is registed
+ * as the children of the bus
  * Context: can sleep
  *
  * Allows a driver to allocate and initialize a spi_device without
@@ -314,7 +316,8 @@ static DEFINE_MUTEX(board_lock);
  *
  * Returns a pointer to the new device, or NULL.
  */
-struct spi_device *spi_alloc_device(struct spi_master *master)
+struct spi_device *spi_alloc_device(struct spi_master *master,
+				bool device_was_children_of_master)
 {
 	struct spi_device	*spi;
 	struct device		*dev = master->dev.parent;
@@ -330,7 +333,10 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
 	}
 
 	spi->master = master;
-	spi->dev.parent = &master->dev;
+	if (device_was_children_of_master == true)
+		spi->dev.parent = &master->dev;
+	else
+		spi->dev.parent = dev;
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
 	device_initialize(&spi->dev);
@@ -434,7 +440,7 @@ struct spi_device *spi_new_device(struct spi_master *master,
 	 * suggests syslogged diagnostics are best here (ugh).
 	 */
 
-	proxy = spi_alloc_device(master);
+	proxy = spi_alloc_device(master, false);
 	if (!proxy)
 		return NULL;
 
@@ -827,7 +833,7 @@ static void of_register_spi_devices(struct spi_master *master)
 
 	for_each_available_child_of_node(master->dev.of_node, nc) {
 		/* Alloc an spi_device */
-		spi = spi_alloc_device(master);
+		spi = spi_alloc_device(master, true);
 		if (!spi) {
 			dev_err(&master->dev, "spi_device alloc error for %s\n",
 				nc->full_name);
@@ -939,7 +945,7 @@ static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
 	if (acpi_bus_get_status(adev) || !adev->status.present)
 		return AE_OK;
 
-	spi = spi_alloc_device(master);
+	spi = spi_alloc_device(master, false);
 	if (!spi) {
 		dev_err(&master->dev, "failed to allocate SPI device for %s\n",
 			dev_name(&adev->dev));
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fa702ae..43d2f8e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -838,7 +838,8 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
  * be defined using the board info.
  */
 extern struct spi_device *
-spi_alloc_device(struct spi_master *master);
+spi_alloc_device(struct spi_master *master,
+				bool device_was_children_of_master);
 
 extern int
 spi_add_device(struct spi_device *spi);
-- 
1.7.4.1




------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
