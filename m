From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/3] spi: cadence: Make of_device_id array const
Date: Tue, 03 Jun 2014 21:01:40 +0900
Message-ID: <001e01cf7f23$946c4460$bd44cd20$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Harini Katakam' <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Make of_device_id array const, because all OF functions handle
it as const.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-cadence.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index bb75897..98b763b 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -647,7 +647,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cdns_spi_dev_pm_ops, cdns_spi_suspend,
 			 cdns_spi_resume);
 
-static struct of_device_id cdns_spi_of_match[] = {
+static const struct of_device_id cdns_spi_of_match[] = {
 	{ .compatible = "xlnx,zynq-spi-r1p6" },
 	{ .compatible = "cdns,spi-r1p6" },
 	{ /* end of table */ }
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
