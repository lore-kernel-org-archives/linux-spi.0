From: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 2/6] SPI: S3C64XX: Differentiate ip and
	rate clock
Date: Mon, 18 Jan 2010 18:50:11 +0900
Message-ID: <1263808215-16544-2-git-send-email-jassisinghbrar@gmail.com>
References: <1263808215-16544-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1263808215-16544-1-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

The instance of SPI clock for controller and that used for generating
signals ought to be independently handled.

Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi_s3c64xx.c |   28 ++++++++--------------------
 1 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index ad93d5d..6d03d8f 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -1000,10 +1000,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
-	if (sci->src_clk_nr == S3C64XX_SPI_SRCCLK_PCLK)
-		sci->src_clk = sdd->clk;
-	else
-		sci->src_clk = clk_get(&pdev->dev, sci->src_clk_name);
+	sci->src_clk = clk_get(&pdev->dev, sci->src_clk_name);
 	if (IS_ERR(sci->src_clk)) {
 		dev_err(&pdev->dev,
 			"Unable to acquire clock '%s'\n", sci->src_clk_name);
@@ -1011,7 +1008,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err5;
 	}
 
-	if (sci->src_clk != sdd->clk && clk_enable(sci->src_clk)) {
+	if (clk_enable(sci->src_clk)) {
 		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n",
 							sci->src_clk_name);
 		ret = -EBUSY;
@@ -1053,11 +1050,9 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 err8:
 	destroy_workqueue(sdd->workqueue);
 err7:
-	if (sci->src_clk != sdd->clk)
-		clk_disable(sci->src_clk);
+	clk_disable(sci->src_clk);
 err6:
-	if (sci->src_clk != sdd->clk)
-		clk_put(sci->src_clk);
+	clk_put(sci->src_clk);
 err5:
 	clk_disable(sdd->clk);
 err4:
@@ -1093,11 +1088,8 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	destroy_workqueue(sdd->workqueue);
 
-	if (sci->src_clk != sdd->clk)
-		clk_disable(sci->src_clk);
-
-	if (sci->src_clk != sdd->clk)
-		clk_put(sci->src_clk);
+	clk_disable(sci->src_clk);
+	clk_put(sci->src_clk);
 
 	clk_disable(sdd->clk);
 	clk_put(sdd->clk);
@@ -1130,9 +1122,7 @@ static int s3c64xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
 		msleep(10);
 
 	/* Disable the clock */
-	if (sci->src_clk != sdd->clk)
-		clk_disable(sci->src_clk);
-
+	clk_disable(sci->src_clk);
 	clk_disable(sdd->clk);
 
 	sdd->cur_speed = 0; /* Output Clock is stopped */
@@ -1150,9 +1140,7 @@ static int s3c64xx_spi_resume(struct platform_device *pdev)
 	sci->cfg_gpio(pdev);
 
 	/* Enable the clock */
-	if (sci->src_clk != sdd->clk)
-		clk_enable(sci->src_clk);
-
+	clk_enable(sci->src_clk);
 	clk_enable(sdd->clk);
 
 	s3c64xx_spi_hwinit(sdd, pdev->id);
-- 
1.6.2.5


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
