From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: bcm-qspi: fix build error
Date: Sun, 18 Sep 2016 19:33:34 +0100
Message-ID: <1474223614-18406-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

While building m68k allmodconfig, the build was failing with the error:

drivers/spi/spi-bcm-qspi.c:1300:13:
error: 'bcm_qspi_suspend' undeclared here (not in a function)
  .suspend = bcm_qspi_suspend,

drivers/spi/spi-bcm-qspi.c:1301:13:
error: 'bcm_qspi_resume' undeclared here (not in a function)
  .resume  = bcm_qspi_resume,

bcm_qspi_suspend() and bcm_qspi_resume() are only defined when
CONFIG_PM_SLEEP is defined. Use the macro SET_SYSTEM_SLEEP_PM_OPS to
use it only when CONFIG_PM_SLEEP is defined.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---

m68k build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/160355865

 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 8fff43e..f06a3824 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1297,8 +1297,8 @@ static int bcm_qspi_resume(struct device *dev)
 #endif /* CONFIG_PM_SLEEP */
 
 const struct dev_pm_ops bcm_qspi_pm_ops = {
-	.suspend = bcm_qspi_suspend,
-	.resume  = bcm_qspi_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(bcm_qspi_suspend,
+				bcm_qspi_resume)
 };
 /* pm_ops to be called by SoC specific platform driver */
 EXPORT_SYMBOL_GPL(bcm_qspi_pm_ops);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
