From: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-dspi: ensure non-zero return on error path
Date: Mon, 22 May 2017 16:19:20 +0300
Message-ID: <20170522131920.4828-1-nikita.yoush@cogentembedded.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Chris Healy <Chris.Healy-c8ZVq/bFV1I@public.gmane.org>,
        Jeff White <Jeff.White-c8ZVq/bFV1I@public.gmane.org>,
        Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Propagate error return from dspi_request_dma() into probe routine's
return.

Signed-off-by: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 15201645bdc4..d89127f4a46d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1032,7 +1032,8 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_master_put;
 
 	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
-		if (dspi_request_dma(dspi, res->start)) {
+		ret = dspi_request_dma(dspi, res->start);
+		if (ret < 0) {
 			dev_err(&pdev->dev, "can't get dma channels\n");
 			goto out_clk_put;
 		}
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
