From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] spi: orion: Use module_platform_driver()
Date: Mon,  4 Feb 2013 09:26:26 -0300
Message-ID: <1359980786-4606-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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

This patch reduces and simplifies initalization code by
using module_platform_driver().
With this change it's necessary to remove the __init annotation
to avoid section mismatch warnings.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-orion.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index b7e7182..d8cbf20 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -396,7 +396,7 @@ static int orion_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int __init orion_spi_probe(struct platform_device *pdev)
+static int orion_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct orion_spi *spi;
@@ -513,20 +513,11 @@ static struct platform_driver orion_spi_driver = {
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(orion_spi_of_match_table),
 	},
+	.probe		= orion_spi_probe,
 	.remove		= __exit_p(orion_spi_remove),
 };
 
-static int __init orion_spi_init(void)
-{
-	return platform_driver_probe(&orion_spi_driver, orion_spi_probe);
-}
-module_init(orion_spi_init);
-
-static void __exit orion_spi_exit(void)
-{
-	platform_driver_unregister(&orion_spi_driver);
-}
-module_exit(orion_spi_exit);
+module_platform_driver(orion_spi_driver);
 
 MODULE_DESCRIPTION("Orion SPI driver");
 MODULE_AUTHOR("Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>");
-- 
1.7.8.6


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
