From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: make some register defines simpler" to the spi tree
Date: Fri, 26 Feb 2016 11:47:58 +0900
Message-ID: <E1aZ8Ri-0006Yt-16@finisterre>
References: <1455715739-25161-11-git-send-email-s.hauer@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455715739-25161-11-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: make some register defines simpler

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

>From d629c2a0051f27cc17ac9dc36bbeef8174b48aae Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Wed, 24 Feb 2016 09:20:31 +0100
Subject: [PATCH] spi: imx: make some register defines simpler

The watermark levels in the DMA register are write only, the driver
should never have to read them back from the hardware. Replace the
current _MASK and _OFFSET defines with defines taking the watermark
level directly.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 287ec0cb6992..96e32d409820 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -256,12 +256,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_INT_RREN		(1 <<  3)
 
 #define MX51_ECSPI_DMA      0x14
-#define MX51_ECSPI_DMA_TX_WML_OFFSET	0
-#define MX51_ECSPI_DMA_TX_WML_MASK	0x3F
-#define MX51_ECSPI_DMA_RX_WML_OFFSET	16
-#define MX51_ECSPI_DMA_RX_WML_MASK	(0x3F << 16)
-#define MX51_ECSPI_DMA_RXT_WML_OFFSET	24
-#define MX51_ECSPI_DMA_RXT_WML_MASK	(0x3F << 24)
+#define MX51_ECSPI_DMA_TX_WML(wml)	((wml) & 0x3f)
+#define MX51_ECSPI_DMA_RX_WML(wml)	(((wml) & 0x3f) << 16)
+#define MX51_ECSPI_DMA_RXT_WML(wml)	(((wml) & 0x3f) << 24)
 
 #define MX51_ECSPI_DMA_TEDEN		(1 << 7)
 #define MX51_ECSPI_DMA_RXDEN		(1 << 23)
@@ -408,9 +405,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	 * and enable DMA request.
 	 */
 
-	writel(spi_imx->wml << MX51_ECSPI_DMA_RX_WML_OFFSET |
-		spi_imx->wml << MX51_ECSPI_DMA_TX_WML_OFFSET |
-		spi_imx->wml << MX51_ECSPI_DMA_RXT_WML_OFFSET |
+	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
 
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
