From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/3] spi: s3c64xx: simplify suspend / resume handlers
Date: Wed, 19 Aug 2015 22:00:09 +0200
Message-ID: <55D4E049.3090009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The runtime PM suspend / resume handlers take care of the enabling/
disabling the clocks already.
Therefore replace the duplicated clock handling with
pm_runtime_force_suspend/resume.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8365c88..56155bd 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1244,10 +1244,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_suspended(dev)) {
-		clk_disable_unprepare(sdd->clk);
-		clk_disable_unprepare(sdd->src_clk);
-	}
+	ret = pm_runtime_force_suspend(dev);
+	if (ret < 0)
+		return ret;
 
 	sdd->cur_speed = 0; /* Output Clock is stopped */
 
@@ -1259,14 +1258,14 @@ static int s3c64xx_spi_resume(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
+	int ret;
 
 	if (sci->cfg_gpio)
 		sci->cfg_gpio();
 
-	if (!pm_runtime_suspended(dev)) {
-		clk_prepare_enable(sdd->src_clk);
-		clk_prepare_enable(sdd->clk);
-	}
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0)
+		return ret;
 
 	s3c64xx_spi_hwinit(sdd, sdd->port_id);
 
-- 
2.5.0
