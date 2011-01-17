From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH] SPI: Fix unregistering of the SPI master and SPI devices
Date: Mon, 17 Jan 2011 17:00:34 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1101171659550.16051@axis700.grange>
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

The actual SPI master device instance and SPI devices on the bus are all
children of the same parent, typically, the SPI host platform device. Not
taking this into consideration leads to SPI devices never being unregistered.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/spi/spi.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 34bb17f..0fa6c6c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -636,9 +636,13 @@ done:
 EXPORT_SYMBOL_GPL(spi_register_master);
 
 
-static int __unregister(struct device *dev, void *null)
+static int __unregister(struct device *dev, void *data)
 {
-	spi_unregister_device(to_spi_device(dev));
+	struct spi_master *master = data;
+
+	if (&master->dev != dev)
+		spi_unregister_device(to_spi_device(dev));
+
 	return 0;
 }
 
@@ -660,7 +664,7 @@ void spi_unregister_master(struct spi_master *master)
 	list_del(&master->list);
 	mutex_unlock(&board_lock);
 
-	dummy = device_for_each_child(&master->dev, NULL, __unregister);
+	dummy = device_for_each_child(master->dev.parent, master, __unregister);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
-- 
1.7.2.3


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
