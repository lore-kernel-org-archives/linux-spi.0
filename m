From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 2/2] spi: atmel: add PM support to SAMA5D2
Date: Wed, 12 Apr 2017 09:05:20 +0200
Message-ID: <20170412070520.29621-2-quentin.schulz@free-electrons.com>
References: <20170412070520.29621-1-quentin.schulz@free-electrons.com>
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
To: nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170412070520.29621-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This adds PM support to the ATMEL SAMA5D2 Xplained.

When suspending, VDDCore is shut down and the SPI registers are lost.
Thus, the SPI controller needs to be re-initialized after resuming from
a system suspend.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 247d920..1eb83c9 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1702,8 +1702,17 @@ static int atmel_spi_suspend(struct device *dev)
 static int atmel_spi_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
+	struct atmel_spi *as = spi_master_get_devdata(master);
 	int ret;
 
+	ret = clk_prepare_enable(as->clk);
+	if (ret)
+		return ret;
+
+	atmel_spi_init(as);
+
+	clk_disable_unprepare(as->clk);
+
 	if (!pm_runtime_suspended(dev)) {
 		ret = atmel_spi_runtime_resume(dev);
 		if (ret)
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
