From: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: [PATCH] spi: omap2-mcspi: remove redundant check for error status
Date: Thu, 25 May 2017 17:51:34 +0100
Message-ID: <20170525165134.18103-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

The check to see if status is less than zero is actually redundant
as all previous places where it is -ve have already branched to the
exit paths, so it is never less than zero at the check.

Detected by CoverityScan, CID#1357119 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 7275223dbcd4..e048268d8ba2 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1412,9 +1412,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		sprintf(mcspi->dma_channels[i].dma_tx_ch_name, "tx%d", i);
 	}
 
-	if (status < 0)
-		goto free_master;
-
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_enable(&pdev->dev);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
