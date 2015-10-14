From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 3/5] spi: mediatek: handle controller_data in mtk_spi_setup
Date: Wed, 14 Oct 2015 11:23:33 +0800
Message-ID: <1444793015-30359-4-git-send-email-leilk.liu@mediatek.com>
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

controller_data is related with device, so move to master->setup
function.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 7bd84c8..406695a 100755
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -136,19 +136,13 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 {
 	u16 cpha, cpol;
 	u32 reg_val;
-	struct mtk_chip_config *chip_config;
 	struct spi_device *spi = msg->spi;
+	struct mtk_chip_config *chip_config = spi->controller_data;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	cpha = spi->mode & SPI_CPHA ? 1 : 0;
 	cpol = spi->mode & SPI_CPOL ? 1 : 0;
 
-	chip_config = spi->controller_data;
-	if (!chip_config) {
-		chip_config = (void *)&mtk_default_chip_info;
-		spi->controller_data = chip_config;
-	}
-
 	reg_val = readl(mdata->base + SPI_CMD_REG);
 	if (cpha)
 		reg_val |= SPI_CMD_CPHA;
@@ -406,6 +400,16 @@ static bool mtk_spi_can_dma(struct spi_master *master,
 	return xfer->len > MTK_SPI_MAX_FIFO_SIZE;
 }
 
+static int mtk_spi_setup(struct spi_device *spi)
+{
+	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
+
+	if (!spi->controller_data)
+		spi->controller_data = (void *)&mtk_default_chip_info;
+
+	return 0;
+}
+
 static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 {
 	u32 cmd, reg_val, cnt;
@@ -493,6 +497,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	master->prepare_message = mtk_spi_prepare_message;
 	master->transfer_one = mtk_spi_transfer_one;
 	master->can_dma = mtk_spi_can_dma;
+	master->setup = mtk_spi_setup;
 
 	of_id = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
 	if (!of_id) {
-- 
1.8.1.1.dirty
