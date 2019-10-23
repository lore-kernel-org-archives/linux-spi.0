From: Luhua Xu <luhua.xu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/1] spi: mediatek: add power control when set_cs
Date: Wed, 23 Oct 2019 08:38:42 -0400
Message-ID: <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, luhua.xu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
 linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1571834322-1121-1-git-send-email-luhua.xu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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

From: "luhua.xu" <luhua.xu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Use runtime PM to power spi when set_cs
As set_cs may be called from interrupt context,
set runtime PM IRQ safe for spi.

Signed-off-by: luhua.xu <luhua.xu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6888a4d..039b67d 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -262,8 +262,16 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	u32 reg_val;
+	int ret;
 	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
 
+	ret = pm_runtime_get_sync(spi->master->dev.parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(spi->master->dev.parent);
+		dev_err(&spi->dev, "failed to power device(%d)\n", ret);
+		return;
+	}
+
 	reg_val = readl(mdata->base + SPI_CMD_REG);
 	if (!enable) {
 		reg_val |= SPI_CMD_PAUSE_EN;
@@ -274,6 +282,9 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 		mdata->state = MTK_SPI_IDLE;
 		mtk_spi_reset(mdata);
 	}
+
+	pm_runtime_mark_last_busy(spi->master->dev.parent);
+	pm_runtime_put_autosuspend(spi->master->dev.parent);
 }
 
 static void mtk_spi_prepare_transfer(struct spi_master *master,
@@ -749,6 +760,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(mdata->spi_clk);
 
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
-- 
2.6.4
