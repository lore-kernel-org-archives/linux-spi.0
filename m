From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [RFC PATCH] spi/bcm63xx: Ensure that memory is freed only after it is
	no longer used
Date: Fri, 10 Aug 2012 13:56:27 -0700
Message-ID: <1344632187-9603-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
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

The call to spi_unregister_master() in the device remove function frees device
memory, and with it any device local data. However, device local data is still
accessed after the call to spi_unregister_master().

Acquire a reference to the SPI device and release it after cleanup is complete
to solve the problem.

Cc: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
Several drivers have this problem, and I am trying to find a common fix.

This solution is modeled after the approach used in spi-txx9spi:txx9spi_remove.
The other possible fix would be to move spi_unregister_master() to the end of
bcm63xx_spi_remove(), but I am not sure if it is a good idea to clean up
before the call to spi_unregister_master().

 drivers/spi/spi-bcm63xx.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 6e25ef1..ea0aaa3 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -438,7 +438,7 @@ out:
 
 static int __devexit bcm63xx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
 
 	spi_unregister_master(master);
@@ -452,6 +452,8 @@ static int __devexit bcm63xx_spi_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, 0);
 
+	spi_master_put(master);
+
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
