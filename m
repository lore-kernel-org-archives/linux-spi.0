From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: medaitek: revise quirks compatibility style" to the spi tree
Date: Thu, 20 Aug 2015 11:34:33 -0700
Message-ID: <E1ZSUfZ-00008j-Tx@finisterre>
References: <1440062349-25513-3-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440062349-25513-3-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: medaitek: revise quirks compatibility style

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

>From af57937e862370c14b7d71d15d969593ffca1ba8 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Thu, 20 Aug 2015 17:19:07 +0800
Subject: [PATCH] spi: medaitek: revise quirks compatibility style

The quirks are true/false, so define these as bool.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 2eda2d1..55d1c3e 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -71,10 +71,6 @@
 #define SPI_CMD_FINISH_IE            BIT(16)
 #define SPI_CMD_PAUSE_IE             BIT(17)
 
-#define MTK_SPI_QUIRK_PAD_SELECT 1
-/* Must explicitly send dummy Tx bytes to do Rx only transfer */
-#define MTK_SPI_QUIRK_MUST_TX 1
-
 #define MT8173_SPI_MAX_PAD_SEL 3
 
 #define MTK_SPI_IDLE 0
@@ -84,8 +80,9 @@
 #define MTK_SPI_PACKET_SIZE 1024
 
 struct mtk_spi_compatible {
-	u32 need_pad_sel;
-	u32 must_tx;
+	bool need_pad_sel;
+	/* Must explicitly send dummy Tx bytes to do Rx only transfer */
+	bool must_tx;
 };
 
 struct mtk_spi {
@@ -100,19 +97,11 @@ struct mtk_spi {
 	const struct mtk_spi_compatible *dev_comp;
 };
 
-static const struct mtk_spi_compatible mt6589_compat = {
-	.need_pad_sel = 0,
-	.must_tx = 0,
-};
-
-static const struct mtk_spi_compatible mt8135_compat = {
-	.need_pad_sel = 0,
-	.must_tx = 0,
-};
-
+static const struct mtk_spi_compatible mt6589_compat;
+static const struct mtk_spi_compatible mt8135_compat;
 static const struct mtk_spi_compatible mt8173_compat = {
-	.need_pad_sel = MTK_SPI_QUIRK_PAD_SELECT,
-	.must_tx = MTK_SPI_QUIRK_MUST_TX,
+	.need_pad_sel = true,
+	.must_tx = true,
 };
 
 /*
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
