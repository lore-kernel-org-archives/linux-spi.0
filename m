From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH RESEND] spi/imx: simplify error handling to free gpios
Date: Tue, 10 Jan 2012 15:27:36 +0800
Message-ID: <1326180456.4956.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

Simplify the error handling by moving the code to free gpios in one place.

Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c6e697f..31054e3 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -793,13 +793,8 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 
 		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
 		if (ret) {
-			while (i > 0) {
-				i--;
-				if (spi_imx->chipselect[i] >= 0)
-					gpio_free(spi_imx->chipselect[i]);
-			}
 			dev_err(&pdev->dev, "can't get cs gpios\n");
-			goto out_master_put;
+			goto out_gpio_free;
 		}
 	}
 
@@ -881,10 +876,10 @@ out_iounmap:
 out_release_mem:
 	release_mem_region(res->start, resource_size(res));
 out_gpio_free:
-	for (i = 0; i < master->num_chipselect; i++)
+	while (--i >= 0) {
 		if (spi_imx->chipselect[i] >= 0)
 			gpio_free(spi_imx->chipselect[i]);
-out_master_put:
+	}
 	spi_master_put(master);
 	kfree(master);
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.5.4




------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
