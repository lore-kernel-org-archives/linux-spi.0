From: Zhiqiang Hou <Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 1/2] spi/fsl-espi: Correct the maximum transaction length
Date: Fri, 22 Jan 2016 18:58:26 +0800
Message-ID: <1453460307-9768-1-git-send-email-Zhiqiang.Hou@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

The maximum length during one transcation is 64KiB.

Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 7fd6a4c..7cb0c19 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -84,7 +84,7 @@ struct fsl_espi_transfer {
 /* SPCOM register values */
 #define SPCOM_CS(x)		((x) << 30)
 #define SPCOM_TRANLEN(x)	((x) << 0)
-#define	SPCOM_TRANLEN_MAX	0xFFFF	/* Max transaction length */
+#define	SPCOM_TRANLEN_MAX	0x10000	/* Max transaction length */
 
 #define AUTOSUSPEND_TIMEOUT 2000
 
@@ -233,7 +233,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	reinit_completion(&mpc8xxx_spi->done);
 
 	/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
-	if ((t->len - 1) > SPCOM_TRANLEN_MAX) {
+	if (t->len > SPCOM_TRANLEN_MAX) {
 		dev_err(mpc8xxx_spi->dev, "Transaction length (%d)"
 				" beyond the SPCOM[TRANLEN] field\n", t->len);
 		return -EINVAL;
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
