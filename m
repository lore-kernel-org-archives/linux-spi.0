From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/3] spi: s3c64xx: simplify suspend/resume handlers
Date: Tue, 18 Aug 2015 23:08:09 +0200
Message-ID: <55D39EB9.2090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The runtime PM handlers take care of enabling / disabling the clock.
Therefore use them to simplify the suspend / resume handlers.

pm_runtime_suspend/resume internally check whether suspending/resuming
is possible and return 1 in case PM state is suspended/active already.

Currently there also seems to be a bug in the resume handler
as suspend as well as resume check for !pm_runtime_disabled(dev).

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 15a6de1..78a6f04 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1242,10 +1242,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_suspended(dev)) {
-		clk_disable_unprepare(sdd->clk);
-		clk_disable_unprepare(sdd->src_clk);
-	}
+	ret = pm_runtime_suspend(dev);
+	if (ret < 0)
+		return ret;
 
 	sdd->cur_speed = 0; /* Output Clock is stopped */
 
@@ -1257,14 +1256,14 @@ static int s3c64xx_spi_resume(struct device *dev)
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
+	ret = pm_runtime_resume(dev);
+	if (ret < 0)
+		return ret;
 
 	s3c64xx_spi_hwinit(sdd, sdd->port_id);
 
-- 
2.5.0
