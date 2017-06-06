From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: put struct spi_imx_config members into driver private struct" to the spi tree
Date: Tue, 06 Jun 2017 20:07:28 +0100
Message-ID: <E1dIJpA-0007eY-JK@debutante>
References: <20170602053804.3238-4-s.hauer@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        Jiada Wang <jiada_wang@mentor.com>, linux-spi@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170602053804.3238-4-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: put struct spi_imx_config members into driver private struct

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

>From d52345b6cf8ecd2c765edf81f49fa62483dd6437 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 2 Jun 2017 07:38:01 +0200
Subject: [PATCH] spi: imx: put struct spi_imx_config members into driver
 private struct

struct spi_imx_config used to hold data specific to the current
transfer. However, other data is in the drivers private data struct.
Let's drop struct spi_imx_config and put the variables into the
drivers private data struct aswell.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e3bc3d51a2d6..3fa5ccfb45a1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -56,10 +56,6 @@
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
-struct spi_imx_config {
-	unsigned int speed_hz;
-	unsigned int bpw;
-};
 
 enum spi_imx_devtype {
 	IMX1_CSPI,
@@ -74,7 +70,7 @@ struct spi_imx_data;
 
 struct spi_imx_devtype_data {
 	void (*intctrl)(struct spi_imx_data *, int);
-	int (*config)(struct spi_device *, struct spi_imx_config *);
+	int (*config)(struct spi_device *);
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
@@ -94,6 +90,8 @@ struct spi_imx_data {
 	unsigned long spi_clk;
 	unsigned int spi_bus_clk;
 
+	unsigned int speed_hz;
+	unsigned int bits_per_word;
 	unsigned int bytes_per_word;
 	unsigned int spi_drctl;
 
@@ -335,12 +333,11 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
-static int mx51_ecspi_config(struct spi_device *spi,
-			     struct spi_imx_config *config)
+static int mx51_ecspi_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
-	u32 clk = config->speed_hz, delay, reg;
+	u32 clk = spi_imx->speed_hz, delay, reg;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 
 	/*
@@ -359,13 +356,13 @@ static int mx51_ecspi_config(struct spi_device *spi,
 		ctrl |= MX51_ECSPI_CTRL_DRCTL(spi_imx->spi_drctl);
 
 	/* set clock speed */
-	ctrl |= mx51_ecspi_clkdiv(spi_imx, config->speed_hz, &clk);
+	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
 
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
 
-	ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+	ctrl |= (spi_imx->bits_per_word - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
 
 	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
 
@@ -496,21 +493,21 @@ static void mx31_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
+static int mx31_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
 	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz, &clk) <<
+	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, spi_imx->speed_hz, &clk) <<
 		MX31_CSPICTRL_DR_SHIFT;
 	spi_imx->spi_bus_clk = clk;
 
 	if (is_imx35_cspi(spi_imx)) {
-		reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
+		reg |= (spi_imx->bits_per_word - 1) << MX35_CSPICTRL_BL_SHIFT;
 		reg |= MX31_CSPICTRL_SSCTL;
 	} else {
-		reg |= (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
+		reg |= (spi_imx->bits_per_word - 1) << MX31_CSPICTRL_BC_SHIFT;
 	}
 
 	if (spi->mode & SPI_CPHA)
@@ -592,18 +589,18 @@ static void mx21_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int mx21_config(struct spi_device *spi, struct spi_imx_config *config)
+static int mx21_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
 	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
 	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz, max, &clk)
+	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, spi_imx->speed_hz, max, &clk)
 		<< MX21_CSPICTRL_DR_SHIFT;
 	spi_imx->spi_bus_clk = clk;
 
-	reg |= config->bpw - 1;
+	reg |= spi_imx->bits_per_word - 1;
 
 	if (spi->mode & SPI_CPHA)
 		reg |= MX21_CSPICTRL_PHA;
@@ -661,17 +658,17 @@ static void mx1_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int mx1_config(struct spi_device *spi, struct spi_imx_config *config)
+static int mx1_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_MASTER;
 	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz, &clk) <<
+	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, spi_imx->speed_hz, &clk) <<
 		MX1_CSPICTRL_DR_SHIFT;
 	spi_imx->spi_bus_clk = clk;
 
-	reg |= config->bpw - 1;
+	reg |= spi_imx->bits_per_word - 1;
 
 	if (spi->mode & SPI_CPHA)
 		reg |= MX1_CSPICTRL_PHA;
@@ -887,20 +884,19 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 				 struct spi_transfer *t)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
-	struct spi_imx_config config;
 	int ret;
 
 	if (!t)
 		return 0;
 
-	config.bpw = t->bits_per_word;
-	config.speed_hz  = t->speed_hz;
+	spi_imx->bits_per_word = t->bits_per_word;
+	spi_imx->speed_hz  = t->speed_hz;
 
 	/* Initialize the functions for transfer */
-	if (config.bpw <= 8) {
+	if (spi_imx->bits_per_word <= 8) {
 		spi_imx->rx = spi_imx_buf_rx_u8;
 		spi_imx->tx = spi_imx_buf_tx_u8;
-	} else if (config.bpw <= 16) {
+	} else if (spi_imx->bits_per_word <= 16) {
 		spi_imx->rx = spi_imx_buf_rx_u16;
 		spi_imx->tx = spi_imx_buf_tx_u16;
 	} else {
@@ -915,12 +911,12 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 
 	if (spi_imx->usedma) {
 		ret = spi_imx_dma_configure(spi->master,
-					    spi_imx_bytes_per_word(config.bpw));
+					    spi_imx_bytes_per_word(spi_imx->bits_per_word));
 		if (ret)
 			return ret;
 	}
 
-	spi_imx->devtype_data->config(spi, &config);
+	spi_imx->devtype_data->config(spi);
 
 	return 0;
 }
-- 
2.11.0
