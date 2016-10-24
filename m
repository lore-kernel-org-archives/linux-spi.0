From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: support DMA for imx35" to the spi tree
Date: Mon, 24 Oct 2016 19:05:23 +0100
Message-ID: <E1byjch-0001nl-Sj@debutante>
References: <1476916945-2744-1-git-send-email-martin@kaiser.cx>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        s.hauer@pengutronix.de
To: Martin Kaiser <martin@kaiser.cx>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476916945-2744-1-git-send-email-martin@kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: support DMA for imx35

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

>From 2dd33f9cec90499029fd49ffae2922c3f9ccad11 Mon Sep 17 00:00:00 2001
From: Martin Kaiser <martin@kaiser.cx>
Date: Thu, 20 Oct 2016 00:42:25 +0200
Subject: [PATCH] spi: imx: support DMA for imx35

Support DMA transfers on imx35 and compatible chipsets (imx31, imx25).

If DMA can be used, set the start mode control (SMC) bit to start the
SPI burst as soon as data is written into the tx fifo. Configure DMA
requests when the fifo is half empty during tx or half full during rx.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index deb782f6556c..08124b29665e 100644
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
+	}
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
2.8.1
