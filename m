From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: use BIT() to instead of SPI_CMD_*_OFFSET" to the spi tree
Date: Thu, 20 Aug 2015 11:34:32 -0700
Message-ID: <E1ZSUfY-00008D-Uh@finisterre>
References: <1440062349-25513-4-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440062349-25513-4-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: use BIT() to instead of SPI_CMD_*_OFFSET

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

>From a71d6ea6d3ec3e8ba4220370f29531903e3bc153 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Thu, 20 Aug 2015 17:19:08 +0800
Subject: [PATCH] spi: mediatek: use BIT() to instead of SPI_CMD_*_OFFSET

This patch removes SPI_CMD_*_OFFSET defines, and uses the BIT(x)
defines instead.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 55d1c3e..516b4ed 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -48,15 +48,8 @@
 #define SPI_CFG1_PACKET_LOOP_MASK         0xff00
 #define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
 
-#define SPI_CMD_ACT_OFFSET                0
-#define SPI_CMD_RESUME_OFFSET             1
-#define SPI_CMD_CPHA_OFFSET               8
-#define SPI_CMD_CPOL_OFFSET               9
-#define SPI_CMD_TXMSBF_OFFSET             12
-#define SPI_CMD_RXMSBF_OFFSET             13
-#define SPI_CMD_RX_ENDIAN_OFFSET          14
-#define SPI_CMD_TX_ENDIAN_OFFSET          15
-
+#define SPI_CMD_ACT                  BIT(0)
+#define SPI_CMD_RESUME               BIT(1)
 #define SPI_CMD_RST                  BIT(2)
 #define SPI_CMD_PAUSE_EN             BIT(4)
 #define SPI_CMD_DEASSERT             BIT(5)
@@ -143,9 +136,14 @@ static void mtk_spi_config(struct mtk_spi *mdata,
 	reg_val = readl(mdata->base + SPI_CMD_REG);
 
 	/* set the mlsbx and mlsbtx */
-	reg_val &= ~(SPI_CMD_TXMSBF | SPI_CMD_RXMSBF);
-	reg_val |= (chip_config->tx_mlsb << SPI_CMD_TXMSBF_OFFSET);
-	reg_val |= (chip_config->rx_mlsb << SPI_CMD_RXMSBF_OFFSET);
+	if (chip_config->tx_mlsb)
+		reg_val |= SPI_CMD_TXMSBF;
+	else
+		reg_val &= ~SPI_CMD_TXMSBF;
+	if (chip_config->rx_mlsb)
+		reg_val |= SPI_CMD_RXMSBF;
+	else
+		reg_val &= ~SPI_CMD_RXMSBF;
 
 	/* set the tx/rx endian */
 #ifdef __LITTLE_ENDIAN
@@ -201,9 +199,14 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 	cpol = spi->mode & SPI_CPOL ? 1 : 0;
 
 	reg_val = readl(mdata->base + SPI_CMD_REG);
-	reg_val &= ~(SPI_CMD_CPHA | SPI_CMD_CPOL);
-	reg_val |= (cpha << SPI_CMD_CPHA_OFFSET);
-	reg_val |= (cpol << SPI_CMD_CPOL_OFFSET);
+	if (cpha)
+		reg_val |= SPI_CMD_CPHA;
+	else
+		reg_val &= ~SPI_CMD_CPHA;
+	if (cpol)
+		reg_val |= SPI_CMD_CPOL;
+	else
+		reg_val &= ~SPI_CMD_CPOL;
 	writel(reg_val, mdata->base + SPI_CMD_REG);
 
 	chip_config = spi->controller_data;
@@ -282,9 +285,9 @@ static void mtk_spi_enable_transfer(struct spi_master *master)
 
 	cmd = readl(mdata->base + SPI_CMD_REG);
 	if (mdata->state == MTK_SPI_IDLE)
-		cmd |= 1 << SPI_CMD_ACT_OFFSET;
+		cmd |= SPI_CMD_ACT;
 	else
-		cmd |= 1 << SPI_CMD_RESUME_OFFSET;
+		cmd |= SPI_CMD_RESUME;
 	writel(cmd, mdata->base + SPI_CMD_REG);
 }
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
