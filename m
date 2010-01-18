From: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 3/6] SPI: S3C64XX: Move src_clk to local
	driver data
Date: Mon, 18 Jan 2010 18:50:12 +0900
Message-ID: <1263808215-16544-3-git-send-email-jassisinghbrar@gmail.com>
References: <1263808215-16544-1-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-2-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1263808215-16544-2-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

The pointer to SPI rate source clock had better be the member of
driver local data structure rather than platform specific.
Also, remove definitions of variable 'sci' that are rendered
useless as a consequence.

Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi_s3c64xx.c |   36 +++++++++++++++++-------------------
 1 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 6d03d8f..3acf381 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -137,6 +137,7 @@
 /**
  * struct s3c64xx_spi_driver_data - Runtime info holder for SPI driver.
  * @clk: Pointer to the spi clock.
+ * @src_clk: Pointer to the clock used to generate SPI signals.
  * @master: Pointer to the SPI Protocol master.
  * @workqueue: Work queue for the SPI xfer requests.
  * @cntrlr_info: Platform specific data for the controller this driver manages.
@@ -157,6 +158,7 @@
 struct s3c64xx_spi_driver_data {
 	void __iomem                    *regs;
 	struct clk                      *clk;
+	struct clk                      *src_clk;
 	struct platform_device          *pdev;
 	struct spi_master               *master;
 	struct workqueue_struct	        *workqueue;
@@ -389,7 +391,6 @@ static inline void disable_cs(struct s3c64xx_spi_driver_data *sdd,
 
 static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 {
-	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	u32 val;
 
@@ -435,7 +436,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	/* Configure Clock */
 	val = readl(regs + S3C64XX_SPI_CLK_CFG);
 	val &= ~S3C64XX_SPI_PSR_MASK;
-	val |= ((clk_get_rate(sci->src_clk) / sdd->cur_speed / 2 - 1)
+	val |= ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / 2 - 1)
 			& S3C64XX_SPI_PSR_MASK);
 	writel(val, regs + S3C64XX_SPI_CLK_CFG);
 
@@ -831,17 +832,17 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	}
 
 	/* Check if we can provide the requested rate */
-	speed = clk_get_rate(sci->src_clk) / 2 / (0 + 1); /* Max possible */
+	speed = clk_get_rate(sdd->src_clk) / 2 / (0 + 1); /* Max possible */
 
 	if (spi->max_speed_hz > speed)
 		spi->max_speed_hz = speed;
 
-	psr = clk_get_rate(sci->src_clk) / 2 / spi->max_speed_hz - 1;
+	psr = clk_get_rate(sdd->src_clk) / 2 / spi->max_speed_hz - 1;
 	psr &= S3C64XX_SPI_PSR_MASK;
 	if (psr == S3C64XX_SPI_PSR_MASK)
 		psr--;
 
-	speed = clk_get_rate(sci->src_clk) / 2 / (psr + 1);
+	speed = clk_get_rate(sdd->src_clk) / 2 / (psr + 1);
 	if (spi->max_speed_hz < speed) {
 		if (psr+1 < S3C64XX_SPI_PSR_MASK) {
 			psr++;
@@ -851,7 +852,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 		}
 	}
 
-	speed = clk_get_rate(sci->src_clk) / 2 / (psr + 1);
+	speed = clk_get_rate(sdd->src_clk) / 2 / (psr + 1);
 	if (spi->max_speed_hz >= speed)
 		spi->max_speed_hz = speed;
 	else
@@ -1000,15 +1001,15 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
-	sci->src_clk = clk_get(&pdev->dev, sci->src_clk_name);
-	if (IS_ERR(sci->src_clk)) {
+	sdd->src_clk = clk_get(&pdev->dev, sci->src_clk_name);
+	if (IS_ERR(sdd->src_clk)) {
 		dev_err(&pdev->dev,
 			"Unable to acquire clock '%s'\n", sci->src_clk_name);
-		ret = PTR_ERR(sci->src_clk);
+		ret = PTR_ERR(sdd->src_clk);
 		goto err5;
 	}
 
-	if (clk_enable(sci->src_clk)) {
+	if (clk_enable(sdd->src_clk)) {
 		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n",
 							sci->src_clk_name);
 		ret = -EBUSY;
@@ -1050,9 +1051,9 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 err8:
 	destroy_workqueue(sdd->workqueue);
 err7:
-	clk_disable(sci->src_clk);
+	clk_disable(sdd->src_clk);
 err6:
-	clk_put(sci->src_clk);
+	clk_put(sdd->src_clk);
 err5:
 	clk_disable(sdd->clk);
 err4:
@@ -1073,7 +1074,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	struct resource	*mem_res;
 	unsigned long flags;
 
@@ -1088,8 +1088,8 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	destroy_workqueue(sdd->workqueue);
 
-	clk_disable(sci->src_clk);
-	clk_put(sci->src_clk);
+	clk_disable(sdd->src_clk);
+	clk_put(sdd->src_clk);
 
 	clk_disable(sdd->clk);
 	clk_put(sdd->clk);
@@ -1110,8 +1110,6 @@ static int s3c64xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
-	struct s3c64xx_spi_csinfo *cs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sdd->lock, flags);
@@ -1122,7 +1120,7 @@ static int s3c64xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
 		msleep(10);
 
 	/* Disable the clock */
-	clk_disable(sci->src_clk);
+	clk_disable(sdd->src_clk);
 	clk_disable(sdd->clk);
 
 	sdd->cur_speed = 0; /* Output Clock is stopped */
@@ -1140,7 +1138,7 @@ static int s3c64xx_spi_resume(struct platform_device *pdev)
 	sci->cfg_gpio(pdev);
 
 	/* Enable the clock */
-	clk_enable(sci->src_clk);
+	clk_enable(sdd->src_clk);
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
