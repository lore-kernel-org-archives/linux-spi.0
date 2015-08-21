From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/4 RESEND v2] spi: s3c64xx: clean up runtime PM if driver
 registration fails
Date: Fri, 21 Aug 2015 19:31:42 +0200
Message-ID: <55D7607E.8050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fix missing runtime PM cleanup if driver registration fails.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
Changed:
- Separated fix from added functionality
v2:
- Added "Reviewed-by"

 drivers/spi/spi-s3c64xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index cd1cfac..8a6ab88 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1186,7 +1186,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot register SPI master: %d\n", ret);
-		goto err3;
+		goto err4;
 	}
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
@@ -1197,6 +1197,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
+err4:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 err3:
 	clk_disable_unprepare(sdd->src_clk);
 err2:
-- 
2.5.0
