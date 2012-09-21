From: Bastian Hecht <hechtb-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH 1/4] spi: sh-msiof: Remove unneeded clock name
Date: Fri, 21 Sep 2012 13:00:46 +0200
Message-ID: <1348225249-1294-1-git-send-email-hechtb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
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

clk_get() no longer needs a character string for associating the right
clock as this is done via the device struct now.

Signed-off-by: Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1f466bc..96358d0 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -597,7 +597,6 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	struct resource	*r;
 	struct spi_master *master;
 	struct sh_msiof_spi_priv *p;
-	char clk_name[16];
 	int i;
 	int ret;
 
@@ -614,10 +613,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	p->info = pdev->dev.platform_data;
 	init_completion(&p->done);
 
-	snprintf(clk_name, sizeof(clk_name), "msiof%d", pdev->id);
-	p->clk = clk_get(&pdev->dev, clk_name);
+	p->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(p->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		dev_err(&pdev->dev, "cannot get clock\n");
 		ret = PTR_ERR(p->clk);
 		goto err1;
 	}
-- 
1.7.5.4


------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
