From: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 5/6] spi/ath79: avoid multiple initialization of the SPI
	controller
Date: Thu, 27 Dec 2012 10:42:28 +0100
Message-ID: <1356601349-23617-6-git-send-email-juhosg@openwrt.org>
References: <1356601349-23617-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356601349-23617-1-git-send-email-juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Currently we are initializing the SPI controller in
the chip select line function, and that function is
called once for each SPI device on the bus. If a
board has multiple SPI devices, the controller will
be initialized multiple times.

Introduce ath79_spi_{en,dis}able helper functions,
and call those from probe/response in order to avoid
the mutliple initialization of the controller.

Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-ath79.c |   41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 19d539e..842acd8 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -96,16 +96,8 @@ static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
 
 }
 
-static int ath79_spi_setup_cs(struct spi_device *spi)
+static void ath79_spi_enable(struct ath79_spi *sp)
 {
-	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
-	struct ath79_spi_controller_data *cdata;
-	int status;
-
-	cdata = spi->controller_data;
-	if (spi->chip_select && !cdata)
-		return -EINVAL;
-
 	/* enable GPIO mode */
 	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, AR71XX_SPI_FS_GPIO);
 
@@ -115,6 +107,24 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 
 	/* TODO: setup speed? */
 	ath79_spi_wr(sp, AR71XX_SPI_REG_CTRL, 0x43);
+}
+
+static void ath79_spi_disable(struct ath79_spi *sp)
+{
+	/* restore CTRL register */
+	ath79_spi_wr(sp, AR71XX_SPI_REG_CTRL, sp->reg_ctrl);
+	/* disable GPIO mode */
+	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, 0);
+}
+
+static int ath79_spi_setup_cs(struct spi_device *spi)
+{
+	struct ath79_spi_controller_data *cdata;
+	int status;
+
+	cdata = spi->controller_data;
+	if (spi->chip_select && !cdata)
+		return -EINVAL;
 
 	status = 0;
 	if (spi->chip_select) {
@@ -135,17 +145,10 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 
 static void ath79_spi_cleanup_cs(struct spi_device *spi)
 {
-	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
-
 	if (spi->chip_select) {
 		struct ath79_spi_controller_data *cdata = spi->controller_data;
 		gpio_free(cdata->gpio);
 	}
-
-	/* restore CTRL register */
-	ath79_spi_wr(sp, AR71XX_SPI_REG_CTRL, sp->reg_ctrl);
-	/* disable GPIO mode */
-	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, 0);
 }
 
 static int ath79_spi_setup(struct spi_device *spi)
@@ -268,12 +271,15 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "register read/write delay is %u nsecs\n",
 		sp->rrw_delay);
 
+	ath79_spi_enable(sp);
 	ret = spi_bitbang_start(&sp->bitbang);
 	if (ret)
-		goto err_clk_disable;
+		goto err_disable;
 
 	return 0;
 
+err_disable:
+	ath79_spi_disable(sp);
 err_clk_disable:
 	clk_disable(sp->clk);
 err_clk_put:
@@ -292,6 +298,7 @@ static int ath79_spi_remove(struct platform_device *pdev)
 	struct ath79_spi *sp = platform_get_drvdata(pdev);
 
 	spi_bitbang_stop(&sp->bitbang);
+	ath79_spi_disable(sp);
 	clk_disable(sp->clk);
 	clk_put(sp->clk);
 	iounmap(sp->base);
-- 
1.7.10


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
