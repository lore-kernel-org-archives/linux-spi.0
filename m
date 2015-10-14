From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/5] spi: mediatek: remove mtk_spi_config
Date: Wed, 14 Oct 2015 11:23:32 +0800
Message-ID: <1444793015-30359-3-git-send-email-leilk.liu@mediatek.com>
References: <1444793015-30359-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1444793015-30359-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

mtk_spi_config() and mtk_spi_prepare_message() both initialize
spi register, so remove mtk_spi_config() and init all register
in mtk_spi_prepare_message().

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 59 +++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index ecb6c58..7bd84c8 100755
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -131,10 +131,34 @@ static void mtk_spi_reset(struct mtk_spi *mdata)
 	writel(reg_val, mdata->base + SPI_CMD_REG);
 }
 
-static void mtk_spi_config(struct mtk_spi *mdata,
-			   struct mtk_chip_config *chip_config)
+static int mtk_spi_prepare_message(struct spi_master *master,
+				   struct spi_message *msg)
 {
+	u16 cpha, cpol;
 	u32 reg_val;
+	struct mtk_chip_config *chip_config;
+	struct spi_device *spi = msg->spi;
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	cpha = spi->mode & SPI_CPHA ? 1 : 0;
+	cpol = spi->mode & SPI_CPOL ? 1 : 0;
+
+	chip_config = spi->controller_data;
+	if (!chip_config) {
+		chip_config = (void *)&mtk_default_chip_info;
+		spi->controller_data = chip_config;
+	}
+
+	reg_val = readl(mdata->base + SPI_CMD_REG);
+	if (cpha)
+		reg_val |= SPI_CMD_CPHA;
+	else
+		reg_val &= ~SPI_CMD_CPHA;
+	if (cpol)
+		reg_val |= SPI_CMD_CPOL;
+	else
+		reg_val &= ~SPI_CMD_CPOL;
+	writel(reg_val, mdata->base + SPI_CMD_REG);
 
 	reg_val = readl(mdata->base + SPI_CMD_REG);
 
@@ -171,37 +195,6 @@ static void mtk_spi_config(struct mtk_spi *mdata,
 	/* pad select */
 	if (mdata->dev_comp->need_pad_sel)
 		writel(mdata->pad_sel, mdata->base + SPI_PAD_SEL_REG);
-}
-
-static int mtk_spi_prepare_message(struct spi_master *master,
-				   struct spi_message *msg)
-{
-	u32 reg_val;
-	u8 cpha, cpol;
-	struct mtk_chip_config *chip_config;
-	struct spi_device *spi = msg->spi;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
-
-	cpha = spi->mode & SPI_CPHA ? 1 : 0;
-	cpol = spi->mode & SPI_CPOL ? 1 : 0;
-
-	reg_val = readl(mdata->base + SPI_CMD_REG);
-	if (cpha)
-		reg_val |= SPI_CMD_CPHA;
-	else
-		reg_val &= ~SPI_CMD_CPHA;
-	if (cpol)
-		reg_val |= SPI_CMD_CPOL;
-	else
-		reg_val &= ~SPI_CMD_CPOL;
-	writel(reg_val, mdata->base + SPI_CMD_REG);
-
-	chip_config = spi->controller_data;
-	if (!chip_config) {
-		chip_config = (void *)&mtk_default_chip_info;
-		spi->controller_data = chip_config;
-	}
-	mtk_spi_config(mdata, chip_config);
 
 	return 0;
 }
-- 
1.8.1.1.dirty
