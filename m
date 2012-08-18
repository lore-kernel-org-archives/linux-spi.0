From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH 3/4] spi/mpc52xx-psc: Avoid access to freed memory in device
	remove function
Date: Sat, 18 Aug 2012 09:29:23 -0700
Message-ID: <1345307364-4914-3-git-send-email-linux@roeck-us.net>
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

The call to spi_unregister_master() in the device remove function frees device
memory, and with it any device local data. However, device local data is still
accessed after the call to spi_unregister_master().

Acquire a reference to the SPI master device and release it after cleanup is
complete to solve the problem.

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/spi/spi-mpc52xx-psc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 6604715..bd47d26 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -481,7 +481,7 @@ static int __devinit mpc52xx_psc_spi_of_probe(struct platform_device *op)
 
 static int __devexit mpc52xx_psc_spi_of_remove(struct platform_device *op)
 {
-	struct spi_master *master = dev_get_drvdata(&op->dev);
+	struct spi_master *master = spi_master_get(dev_get_drvdata(&op->dev));
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);
 
 	flush_workqueue(mps->workqueue);
@@ -490,6 +490,7 @@ static int __devexit mpc52xx_psc_spi_of_remove(struct platform_device *op)
 	free_irq(mps->irq, mps);
 	if (mps->psc)
 		iounmap(mps->psc);
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
