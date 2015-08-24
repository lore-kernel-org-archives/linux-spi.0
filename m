From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 4/4] spi: mediatek: replace *_time name
Date: Mon, 24 Aug 2015 11:45:18 +0800
Message-ID: <1440387918-22191-5-git-send-email-leilk.liu@mediatek.com>
References: <1440387918-22191-1-git-send-email-leilk.liu@mediatek.com>
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
In-Reply-To: <1440387918-22191-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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

This patch replaces *_time name in mtk_spi_prepare_transfer().

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index e14f583..eaadc7e 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -238,8 +238,7 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 static void mtk_spi_prepare_transfer(struct spi_master *master,
 				     struct spi_transfer *xfer)
 {
-	u32 spi_clk_hz, div, high_time, low_time, holdtime,
-	    setuptime, cs_idletime, reg_val = 0;
+	u32 spi_clk_hz, div, sck_time, cs_time, reg_val = 0;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	spi_clk_hz = clk_get_rate(mdata->spi_clk);
@@ -248,21 +247,18 @@ static void mtk_spi_prepare_transfer(struct spi_master *master,
 	else
 		div = 1;
 
-	high_time = (div + 1) / 2;
-	low_time = (div + 1) / 2;
-	holdtime = (div + 1) / 2 * 2;
-	setuptime = (div + 1) / 2 * 2;
-	cs_idletime = (div + 1) / 2 * 2;
+	sck_time = (div + 1) / 2;
+	cs_time = sck_time * 2;
 
-	reg_val |= (((high_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
-	reg_val |= (((low_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
-	reg_val |= (((holdtime - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
-	reg_val |= (((setuptime - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
+	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
+	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
+	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
+	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
 	writel(reg_val, mdata->base + SPI_CFG0_REG);
 
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
 	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
-	reg_val |= (((cs_idletime - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
+	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
 }
 
-- 
1.8.1.1.dirty
