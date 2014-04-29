From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/7] spi: pxa2xx: remove unnecessary OOM messages
Date: Tue, 29 Apr 2014 17:19:38 +0900
Message-ID: <002601cf6383$c36eae30$4a4c0a90$%han@samsung.com>
References: <002401cf6383$7e9ce1f0$7bd6a5d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Mika Westerberg' <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002401cf6383$7e9ce1f0$7bd6a5d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d0fc8e0..65df9b1 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -885,11 +885,8 @@ static int setup(struct spi_device *spi)
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
 		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
-		if (!chip) {
-			dev_err(&spi->dev,
-				"failed setup: can't allocate chip data\n");
+		if (!chip)
 			return -ENOMEM;
-		}
 
 		if (drv_data->ssp_type == CE4100_SSP) {
 			if (spi->chip_select > 4) {
@@ -1036,11 +1033,8 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 		return NULL;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(&pdev->dev,
-			"failed to allocate memory for platform data\n");
+	if (!pdata)
 		return NULL;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
