From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: spi-tle62x0: Use module_spi_driver macro
Date: Tue,  4 Sep 2012 16:58:35 +0530
Message-ID: <1346758115-13150-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
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

module_spi_driver eliminates module_init and module_exit
calls and makes the code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-tle62x0.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
index 0ce5c12..2442102 100644
--- a/drivers/spi/spi-tle62x0.c
+++ b/drivers/spi/spi-tle62x0.c
@@ -316,18 +316,7 @@ static struct spi_driver tle62x0_driver = {
 	.remove		= __devexit_p(tle62x0_remove),
 };
 
-static __init int tle62x0_init(void)
-{
-	return spi_register_driver(&tle62x0_driver);
-}
-
-static __exit void tle62x0_exit(void)
-{
-	spi_unregister_driver(&tle62x0_driver);
-}
-
-module_init(tle62x0_init);
-module_exit(tle62x0_exit);
+module_spi_driver(tle62x0_driver);
 
 MODULE_AUTHOR("Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>");
 MODULE_DESCRIPTION("TLE62x0 SPI driver");
-- 
1.7.4.1


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
