From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] dw_spi_mmio code style fixups
Date: Thu, 21 Jan 2010 10:17:33 -0500
Message-ID: <20100121151659.6622.46967.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

Minor code style cleanups following comments by Wolfram Sang

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/dw_spi_mmio.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/dw_spi_mmio.c b/drivers/spi/dw_spi_mmio.c
index 26c4b49..e35b45a 100644
--- a/drivers/spi/dw_spi_mmio.c
+++ b/drivers/spi/dw_spi_mmio.c
@@ -17,8 +17,8 @@
 #define DRIVER_NAME "dw_spi_mmio"
 
 struct dw_spi_mmio {
-	struct dw_spi	dws;
-	struct clk		*clk;
+	struct dw_spi  dws;
+	struct clk     *clk;
 };
 
 static int __devinit dw_spi_mmio_probe(struct platform_device *pdev)
@@ -134,13 +134,12 @@ static int __init dw_spi_mmio_init(void)
 {
 	return platform_driver_probe(&dw_spi_mmio_driver, dw_spi_mmio_probe);
 }
+module_init(dw_spi_mmio_init);
 
 static void __exit dw_spi_mmio_exit(void)
 {
 	platform_driver_unregister(&dw_spi_mmio_driver);
 }
-
-module_init(dw_spi_mmio_init);
 module_exit(dw_spi_mmio_exit);
 
 MODULE_AUTHOR("Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>");


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
