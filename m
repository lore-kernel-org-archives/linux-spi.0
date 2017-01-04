From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch V1 1/2] spi: fsl-lpspi: fix indentation error
Date: Wed, 4 Jan 2017 17:38:16 +0800
Message-ID: <1483522697-6691-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch fixes the indentation error in spi-fsl-lpspi.c.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 52551f6..8ec8f55 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -512,9 +512,9 @@ static int fsl_lpspi_remove(struct platform_device *pdev)
 
 static struct platform_driver fsl_lpspi_driver = {
 	.driver = {
-		   .name = DRIVER_NAME,
-		   .of_match_table = fsl_lpspi_dt_ids,
-		   },
+		.name = DRIVER_NAME,
+		.of_match_table = fsl_lpspi_dt_ids,
+	},
 	.probe = fsl_lpspi_probe,
 	.remove = fsl_lpspi_remove,
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
