From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH 1/3] spi/stmp: Fix device remove function
Date: Thu, 23 Aug 2012 20:08:47 -0700
Message-ID: <1345777729-19342-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
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

The call sequence spi_alloc_master/spi_register_master/spi_unregister_master
is complete; it reduces the device reference count to zero, which results in
device memory being freed. The remove function accesses the freed memory after
the call to spi_unregister_master(), _and_ it calls spi_master_put on the freed
memory.

Acquire a reference to the SPI master device and release it after cleanup is
complete (with the existing spi_master_put) to solve the problem.

Also, the device subsystem ensures that the remove function is only called once,
and resets device driver data to NULL. Remove the respective check and drop the
unnecessaary call to platform_set_drvdata().

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
Note that this driver is impossible to build, since it depends on ARCH_STMP3XXX
which is not defined anywhere.

 drivers/spi/spi-stmp.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-stmp.c b/drivers/spi/spi-stmp.c
index 58e3852..911e904 100644
--- a/drivers/spi/spi-stmp.c
+++ b/drivers/spi/spi-stmp.c
@@ -594,9 +594,7 @@ static int __devexit stmp_spi_remove(struct platform_device *dev)
 	struct stmp_spi *ss;
 	struct spi_master *master;
 
-	master = platform_get_drvdata(dev);
-	if (master == NULL)
-		goto out0;
+	master = spi_master_get(platform_get_drvdata(dev));
 	ss = spi_master_get_devdata(master);
 
 	spi_unregister_master(master);
@@ -609,8 +607,6 @@ static int __devexit stmp_spi_remove(struct platform_device *dev)
 	destroy_workqueue(ss->workqueue);
 	iounmap(ss->regs);
 	spi_master_put(master);
-	platform_set_drvdata(dev, NULL);
-out0:
 	return 0;
 }
 
-- 
1.7.9.7


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
