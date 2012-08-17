From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH 2/2] spi/coldfire-qspi: Drop extra calls to spi_master_get in
	suspend/resume functions
Date: Thu, 16 Aug 2012 20:26:00 -0700
Message-ID: <1345173960-6138-2-git-send-email-linux@roeck-us.net>
References: <1345173960-6138-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1345173960-6138-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Suspend and resume functions call spi_master_get() without matching
spi_master_put(). The extra references are unnecessary and cause
subsequent module unload attempts to fail, so drop the calls.

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/spi/spi-coldfire-qspi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 1a30b47..764bfee 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -540,7 +540,7 @@ static int __devexit mcfqspi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int mcfqspi_suspend(struct device *dev)
 {
-	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
 
 	spi_master_suspend(master);
@@ -552,7 +552,7 @@ static int mcfqspi_suspend(struct device *dev)
 
 static int mcfqspi_resume(struct device *dev)
 {
-	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
 
 	spi_master_resume(master);
-- 
1.7.9.7


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
