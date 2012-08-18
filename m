From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH 2/4] spi/mpc52xx: Fix device remove function
Date: Sat, 18 Aug 2012 09:29:22 -0700
Message-ID: <1345307364-4914-2-git-send-email-linux@roeck-us.net>
References: <1345307364-4914-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1345307364-4914-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The call sequence spi_alloc_master/spi_register_master/spi_unregister_master is
complete; it reduces the device reference count to zero, which results in
device memory being freed. An extra call to spi_master_put is unnecessary
and results in an access to free memory.

At the same time, since the call to spi_unregister_master results in device
memory being freed, it must no longer be accessed afterwards.

To fix both problems, call spi_master_get to get an extra reference to the
device, and call spi_master_put only after the last access to device data.

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/spi/spi-mpc52xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index a749589..0454106 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -529,7 +529,7 @@ static int __devinit mpc52xx_spi_probe(struct platform_device *op)
 
 static int __devexit mpc52xx_spi_remove(struct platform_device *op)
 {
-	struct spi_master *master = dev_get_drvdata(&op->dev);
+	struct spi_master *master = spi_master_get(dev_get_drvdata(&op->dev));
 	struct mpc52xx_spi *ms = spi_master_get_devdata(master);
 	int i;
 
@@ -541,8 +541,8 @@ static int __devexit mpc52xx_spi_remove(struct platform_device *op)
 
 	kfree(ms->gpio_cs);
 	spi_unregister_master(master);
-	spi_master_put(master);
 	iounmap(ms->regs);
+	spi_master_put(master);
 
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
