From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/fsl-espi: Correct the maximum transaction length" to the spi tree
Date: Fri, 22 Jan 2016 18:27:09 +0000
Message-ID: <E1aMgQP-0004IK-KG@debutante>
References: <1453460307-9768-1-git-send-email-Zhiqiang.Hou@freescale.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453460307-9768-1-git-send-email-Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/fsl-espi: Correct the maximum transaction length

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5cfa1e4e0deced0cccedb4b30facb8a8e68e209b Mon Sep 17 00:00:00 2001
From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Date: Fri, 22 Jan 2016 18:58:26 +0800
Subject: [PATCH] spi/fsl-espi: Correct the maximum transaction length

The maximum length during one transcation is 64KiB.

Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 7fd6a4c009d2..7cb0c1921495 100644
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
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
