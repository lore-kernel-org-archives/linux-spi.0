From: Hou Zhiqiang <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] spi/fsl-espi: fix the return value judgment of irq_of_parse_and_map.
Date: Wed, 11 Dec 2013 13:09:40 +0800
Message-ID: <1386738580-9930-1-git-send-email-b48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Hou Zhiqiang <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Hou Zhiqiang <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 80d8f40..8106006 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -705,7 +705,7 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 		goto err;
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (!ret) {
+	if (!irq) {
 		ret = -EINVAL;
 		goto err;
 	}
-- 
1.8.4.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
