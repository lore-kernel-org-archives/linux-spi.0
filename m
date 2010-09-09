From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] SPI: S3C64XX: Consider the clk_from_cmu flag
Date: Thu,  9 Sep 2010 16:19:04 +0900
Message-ID: <1284016744-21655-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Newer SoCs have the SPI clock scaling control in platform's
clock management unit. Inorder for such SoCs to work, we need
to check the flag clk_from_cmu before making any clock changes.

Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    3 +
 drivers/spi/spi_s3c64xx.c                        |   94 +++++++++++++---------
 2 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index 55852f4..76fce2a 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -32,6 +32,8 @@ struct s3c64xx_spi_csinfo {
  * struct s3c64xx_spi_info - SPI Controller defining structure
  * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
  * @src_clk_name: Platform name of the corresponding clock.
+ * @clk_from_cmu: If the SPI clock/prescalar control block is present
+ *     by the platform's clock-management-unit and not in SPI controller.
  * @num_cs: Number of CS this controller emulates.
  * @cfg_gpio: Configure pins for this SPI controller.
  * @fifo_lvl_mask: All tx fifo_lvl fields start at offset-6
@@ -41,6 +43,7 @@ struct s3c64xx_spi_csinfo {
 struct s3c64xx_spi_info {
 	int src_clk_nr;
 	char *src_clk_name;
+	bool clk_from_cmu;
 
 	int num_cs;
 
diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 3ff335d..9343351 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -429,13 +429,18 @@ static inline void disable_cs(struct s3c64xx_spi_driver_data *sdd,
 
 static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 {
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	u32 val;
 
 	/* Disable Clock */
-	val = readl(regs + S3C64XX_SPI_CLK_CFG);
-	val &= ~S3C64XX_SPI_ENCLK_ENABLE;
-	writel(val, regs + S3C64XX_SPI_CLK_CFG);
+	if (sci->clk_from_cmu) {
+		clk_disable(sdd->src_clk);
+	} else {
+		val = readl(regs + S3C64XX_SPI_CLK_CFG);
+		val &= ~S3C64XX_SPI_ENCLK_ENABLE;
+		writel(val, regs + S3C64XX_SPI_CLK_CFG);
+	}
 
 	/* Set Polarity and Phase */
 	val = readl(regs + S3C64XX_SPI_CH_CFG);
@@ -473,17 +478,25 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
-	/* Configure Clock */
-	val = readl(regs + S3C64XX_SPI_CLK_CFG);
-	val &= ~S3C64XX_SPI_PSR_MASK;
-	val |= ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / 2 - 1)
-			& S3C64XX_SPI_PSR_MASK);
-	writel(val, regs + S3C64XX_SPI_CLK_CFG);
-
-	/* Enable Clock */
-	val = readl(regs + S3C64XX_SPI_CLK_CFG);
-	val |= S3C64XX_SPI_ENCLK_ENABLE;
-	writel(val, regs + S3C64XX_SPI_CLK_CFG);
+	if (sci->clk_from_cmu) {
+		/* Configure Clock */
+		/* There is half-multiplier before the SPI */
+		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
+		/* Enable Clock */
+		clk_enable(sdd->src_clk);
+	} else {
+		/* Configure Clock */
+		val = readl(regs + S3C64XX_SPI_CLK_CFG);
+		val &= ~S3C64XX_SPI_PSR_MASK;
+		val |= ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / 2 - 1)
+				& S3C64XX_SPI_PSR_MASK);
+		writel(val, regs + S3C64XX_SPI_CLK_CFG);
+
+		/* Enable Clock */
+		val = readl(regs + S3C64XX_SPI_CLK_CFG);
+		val |= S3C64XX_SPI_ENCLK_ENABLE;
+		writel(val, regs + S3C64XX_SPI_CLK_CFG);
+	}
 }
 
 void s3c64xx_spi_dma_rxcb(struct s3c2410_dma_chan *chan, void *buf_id,
@@ -846,7 +859,6 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	struct s3c64xx_spi_driver_data *sdd;
 	struct s3c64xx_spi_info *sci;
 	struct spi_message *msg;
-	u32 psr, speed;
 	unsigned long flags;
 	int err = 0;
 
@@ -889,32 +901,37 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	}
 
 	/* Check if we can provide the requested rate */
-	speed = clk_get_rate(sdd->src_clk) / 2 / (0 + 1); /* Max possible */
-
-	if (spi->max_speed_hz > speed)
-		spi->max_speed_hz = speed;
-
-	psr = clk_get_rate(sdd->src_clk) / 2 / spi->max_speed_hz - 1;
-	psr &= S3C64XX_SPI_PSR_MASK;
-	if (psr == S3C64XX_SPI_PSR_MASK)
-		psr--;
+	if (!sci->clk_from_cmu) {
+		u32 psr, speed;
+
+		/* Max possible */
+		speed = clk_get_rate(sdd->src_clk) / 2 / (0 + 1);
+
+		if (spi->max_speed_hz > speed)
+			spi->max_speed_hz = speed;
+
+		psr = clk_get_rate(sdd->src_clk) / 2 / spi->max_speed_hz - 1;
+		psr &= S3C64XX_SPI_PSR_MASK;
+		if (psr == S3C64XX_SPI_PSR_MASK)
+			psr--;
+
+		speed = clk_get_rate(sdd->src_clk) / 2 / (psr + 1);
+		if (spi->max_speed_hz < speed) {
+			if (psr+1 < S3C64XX_SPI_PSR_MASK) {
+				psr++;
+			} else {
+				err = -EINVAL;
+				goto setup_exit;
+			}
+		}
 
-	speed = clk_get_rate(sdd->src_clk) / 2 / (psr + 1);
-	if (spi->max_speed_hz < speed) {
-		if (psr+1 < S3C64XX_SPI_PSR_MASK) {
-			psr++;
-		} else {
+		speed = clk_get_rate(sdd->src_clk) / 2 / (psr + 1);
+		if (spi->max_speed_hz >= speed)
+			spi->max_speed_hz = speed;
+		else
 			err = -EINVAL;
-			goto setup_exit;
-		}
 	}
 
-	speed = clk_get_rate(sdd->src_clk) / 2 / (psr + 1);
-	if (spi->max_speed_hz >= speed)
-		spi->max_speed_hz = speed;
-	else
-		err = -EINVAL;
-
 setup_exit:
 
 	/* setup() returns with device de-selected */
@@ -936,7 +953,8 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 	/* Disable Interrupts - we use Polling if not DMA mode */
 	writel(0, regs + S3C64XX_SPI_INT_EN);
 
-	writel(sci->src_clk_nr << S3C64XX_SPI_CLKSEL_SRCSHFT,
+	if (!sci->clk_from_cmu)
+		writel(sci->src_clk_nr << S3C64XX_SPI_CLKSEL_SRCSHFT,
 				regs + S3C64XX_SPI_CLK_CFG);
 	writel(0, regs + S3C64XX_SPI_MODE_CFG);
 	writel(0, regs + S3C64XX_SPI_PACKET_CNT);
-- 
1.6.2.5


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
