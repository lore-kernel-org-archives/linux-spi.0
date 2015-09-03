From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4 RESEND v2] spi: s3c64xx: replace clock disabling with
 runtime PM suspend call in remove function
Date: Thu, 03 Sep 2015 22:40:53 +0200
Message-ID: <55E8B055.5040102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Simplify s3c64xx_spi_remove by replacing the clock disabling with calling
runtime PM suspend which does the same.
Waking up the device if it was suspended wouldn't be strictly needed
for this driver but using pm_runtime_get_sync is cleaner and makes
s3c64xx_spi_remove more consistent with the runtime PM handling in
s3c64xx_spi_setup.

pm_runtime_force_suspend does most of the work for us:
disabling the clocks, disabling runtime PM and setting it to
"suspended" state.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Changed:
- Added to the patch set
v2:
- Don't use runtime_pm_force_suspend. Technically it works but it's not
  intuitive as we don't intend to suspend here.

 drivers/spi/spi-s3c64xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4e5931c..dee82e1 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1225,7 +1225,7 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
@@ -1233,6 +1233,10 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(sdd->clk);
 
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
