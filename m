From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: [PATCH 1/1] spi: fsl-dspi: Remove probe info message
Date: Thu, 25 Sep 2014 13:32:24 +0200
Message-ID: <1411644744-29371-1-git-send-email-alexander.stein@systec-electronic.com>
Cc: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove the probe info message which also has wrong output. No need to add
KERN_INFO to pr_info. Output was:
6Freescale DSPI master initialized

Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 5021ddf..110657f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -535,7 +535,6 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	pr_info(KERN_INFO "Freescale DSPI master initialized\n");
 	return ret;
 
 out_clk_put:
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
