From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch V1 1/2] spi: fsl-lpspi: use GPL as module license
Date: Fri, 2 Dec 2016 11:50:00 +0800
Message-ID: <1480650601-12810-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

At the beginning of lpspi driver, it is claimed that the dirver
is under the terms of the GNU General Public License, either
version 2 of the License. While at the end I only declared GPL V2.

This patch make the license consistent.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 71eca6e..c4a4e262 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -519,4 +519,4 @@ static int fsl_lpspi_remove(struct platform_device *pdev)
 
 MODULE_DESCRIPTION("LPSPI Master Controller driver");
 MODULE_AUTHOR("Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
