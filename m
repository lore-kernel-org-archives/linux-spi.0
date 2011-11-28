From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH/RFC] spi: Fix device unregistration when unregistering the bus
	master
Date: Mon, 28 Nov 2011 14:23:24 +0100
Message-ID: <1322486604-27808-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Device are added as children of the bus master's parent device, but
spi_unregister_master() looks for devices to unregister in the bus
master's children. This results in the child devices not being
unregistered.

Fix this by iterating over the bus master's parent device when
unregistering the master.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/spi/spi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Hi,

I came across this issue when developing an SPI master driver for a platform
device. Board code registers SPI board information for a flash device, an SPI
device was created when I loaded my SPI master driver, but it stayed there when
the SPI master driver was removed.

SPI master unregistration has been patched a couple of times:

- 97dbf37d ("drivers/spi/spi.c: don't release the spi device twice")
- 3486008 ("spi: free children in spi_unregister_master, not siblings")
- 2b9603a0 ("spi: enable spi_board_info to be registered after spi_master")

I'm not too familiar with the way the SPI subsystem plugs its devices in the
Linux device model, so I'm not sure what the right fix is. An alternative would
be to register the SPI devices as children of the SPI master, not as siblings.

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2e13a14..081e0a1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -638,7 +638,8 @@ EXPORT_SYMBOL_GPL(spi_register_master);
 
 static int __unregister(struct device *dev, void *null)
 {
-	spi_unregister_device(to_spi_device(dev));
+	if (dev->bus == &spi_bus_type)
+		spi_unregister_device(to_spi_device(dev));
 	return 0;
 }
 
@@ -660,7 +661,7 @@ void spi_unregister_master(struct spi_master *master)
 	list_del(&master->list);
 	mutex_unlock(&board_lock);
 
-	dummy = device_for_each_child(&master->dev, NULL, __unregister);
+	dummy = device_for_each_child(master->dev.parent, NULL, __unregister);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
-- 
Regards,

Laurent Pinchart


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
