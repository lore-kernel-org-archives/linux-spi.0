From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/2] spi: pxa2xx: add missed break
Date: Mon,  2 Jan 2017 13:44:28 +0200
Message-ID: <20170102114429.128094-1-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The commit 7c7289a40425 ("spi: pxa2xx: Default thresholds to PXA
configuration") while splitting up CE4100 code obviously missed a break
condition in one chunk. Add it here.

Looks like we have no active user of CE4100, though better to fix this later
than never.

Fixes: commit 7c7289a40425 ("spi: pxa2xx: Default thresholds to PXA configuration")
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dd7b5b47291d..d6239fa718be 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1690,6 +1690,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		pxa2xx_spi_write(drv_data, SSCR1, tmp);
 		tmp = SSCR0_SCR(2) | SSCR0_Motorola | SSCR0_DataSize(8);
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
+		break;
 	default:
 		tmp = SSCR1_RxTresh(RX_THRESH_DFLT) |
 		      SSCR1_TxTresh(TX_THRESH_DFLT);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
