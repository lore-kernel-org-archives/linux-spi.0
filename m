From: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
Subject: [PATCH] spi: imx: support DMA for imx35
Date: Wed, 19 Oct 2016 23:38:24 +0200
Message-ID: <1476913104-2405-1-git-send-email-martin@kaiser.cx>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Support DMA transfers on imx35 and compatible chipsets (imx31, imx25).

If DMA can be used, set the start mode control (SMC) bit to start the
SPI burst as soon as data is written into the tx fifo. Configure DMA
requests when the fifo is half empty during tx or half full during rx.

Signed-off-by: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
---
 drivers/spi/spi-imx.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index deb782f..e9e0938 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -442,6 +442,7 @@ static void mx51_ecspi_reset(struct spi_imx_data *spi_imx)
 #define MX31_CSPICTRL_ENABLE	(1 << 0)
 #define MX31_CSPICTRL_MASTER	(1 << 1)
 #define MX31_CSPICTRL_XCH	(1 << 2)
+#define MX31_CSPICTRL_SMC	(1 << 3)
 #define MX31_CSPICTRL_POL	(1 << 4)
 #define MX31_CSPICTRL_PHA	(1 << 5)
 #define MX31_CSPICTRL_SSCTL	(1 << 6)
@@ -452,6 +453,10 @@ static void mx51_ecspi_reset(struct spi_imx_data *spi_imx)
 #define MX35_CSPICTRL_CS_SHIFT	12
 #define MX31_CSPICTRL_DR_SHIFT	16
 
+#define MX31_CSPI_DMAREG	0x10
+#define MX31_DMAREG_RH_DEN	(1<<4)
+#define MX31_DMAREG_TH_DEN	(1<<1)
+
 #define MX31_CSPISTATUS		0x14
 #define MX31_STATUS_RR		(1 << 3)
 
@@ -511,6 +516,9 @@ static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
 			(is_imx35_cspi(spi_imx) ? MX35_CSPICTRL_CS_SHIFT :
 						  MX31_CSPICTRL_CS_SHIFT);
 
+	if (spi_imx->usedma)
+		reg |= MX31_CSPICTRL_SMC;
+
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
 	reg = readl(spi_imx->base + MX31_CSPI_TESTREG);
@@ -520,6 +528,13 @@ static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
 		reg &= ~MX31_TEST_LBC;
 	writel(reg, spi_imx->base + MX31_CSPI_TESTREG);
 
+	if (spi_imx->usedma) {
+		/* configure DMA requests when RXFIFO is half full and
+		   when TXFIFO is half empty */
+		writel(MX31_DMAREG_RH_DEN | MX31_DMAREG_TH_DEN,
+			spi_imx->base + MX31_CSPI_DMAREG);
+   }
+
 	return 0;
 }
 
@@ -1244,10 +1259,10 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
 	/*
-	 * Only validated on i.mx6 now, can remove the constrain if validated on
-	 * other chips.
+	 * Only validated on i.mx35 and i.mx6 now, can remove the constraint
+	 * if validated on other chips.
 	 */
-	if (is_imx51_ecspi(spi_imx)) {
+	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx)) {
 		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
 		if (ret == -EPROBE_DEFER)
 			goto out_clk_put;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
