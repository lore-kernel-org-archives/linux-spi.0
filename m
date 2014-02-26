From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/3] spi: fsl-dspi: Use SIMPLE_DEV_PM_OPS macro
Date: Wed, 26 Feb 2014 10:30:14 +0900
Message-ID: <003901cf3292$4cb09a50$e611cef0$%han@samsung.com>
References: <003801cf3292$0b03b4c0$210b1e40$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Chao Fu' <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	'Xiubo Li' <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <003801cf3292$0b03b4c0$210b1e40$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 42ede0d..7f0dddb 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -437,9 +437,7 @@ static int dspi_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-static const struct dev_pm_ops dspi_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(dspi_suspend, dspi_resume)
-};
+static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
 
 static struct regmap_config dspi_regmap_config = {
 	.reg_bits = 32,
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
