From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: cadence: change sequence of calling runtime_enable
Date: Tue,  8 Aug 2017 10:59:33 +0200
Message-ID: <61b5819082ab2128754f37b7a3440a03f7a90248.1502182771.git.michal.simek@xilinx.com>
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Naga Sureshkumar Relli <naga.sureshkumar.relli-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

call pm_runtime_enable after set_active other wise it will
enable clock always.

Signed-off-by: Naga Sureshkumar Relli <nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---

 drivers/spi/spi-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index cdee5366cda4..5c9516ae4942 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -576,10 +576,10 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto clk_dis_apb;
 	}
 
-	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 
 	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
 	if (ret < 0)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
