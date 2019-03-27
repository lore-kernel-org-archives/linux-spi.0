From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 17/26] spi: tegra114: add support for interrupt mask
Date: Tue, 26 Mar 2019 22:56:38 -0700
Message-ID: <1553666207-11414-17-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch creates tegra_spi_soc_data structure to maintain and implement
SPI HW feature differences between different Tegra chips and also creates
a separate compatible string for T124/T210/T186.

Tegra210 and later has a separate interrupt mask register SPI_INTR_MASK
for enabling or disabling interrupts while Tegra124 and prior uses
interrupt enable bits in SPI_DMA_CTL register.

This patch creates flag has_intr_mask_reg in tegra_spi_soc_data to
identify this and implements accordingly.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 53 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 9b9d4b9e1f3e..68fee474580b 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -149,6 +149,8 @@
 
 #define SPI_TX_FIFO				0x108
 #define SPI_RX_FIFO				0x188
+#define SPI_INTR_MASK				0x18c
+#define SPI_INTR_ALL_MASK			(0x1fUL << 25)
 #define MAX_CHIP_SELECT				4
 #define SPI_FIFO_DEPTH				64
 #define DATA_DIR_TX				(1 << 0)
@@ -161,6 +163,10 @@
 #define MAX_HOLD_CYCLES				16
 #define SPI_DEFAULT_SPEED			25000000
 
+struct tegra_spi_soc_data {
+	bool has_intr_mask_reg;
+};
+
 struct tegra_spi_data {
 	struct device				*dev;
 	struct spi_master			*master;
@@ -211,6 +217,7 @@ struct tegra_spi_data {
 	u32					*tx_dma_buf;
 	dma_addr_t				tx_dma_phys;
 	struct dma_async_tx_descriptor		*tx_dma_desc;
+	const struct tegra_spi_soc_data		*soc_data;
 };
 
 static int tegra_spi_runtime_suspend(struct device *dev);
@@ -554,11 +561,13 @@ static int tegra_spi_start_dma_based_transfer(
 		dma_burst = 8;
 	}
 
-	if (tspi->cur_direction & DATA_DIR_TX)
-		val |= SPI_IE_TX;
+	if (!tspi->soc_data->has_intr_mask_reg) {
+		if (tspi->cur_direction & DATA_DIR_TX)
+			val |= SPI_IE_TX;
 
-	if (tspi->cur_direction & DATA_DIR_RX)
-		val |= SPI_IE_RX;
+		if (tspi->cur_direction & DATA_DIR_RX)
+			val |= SPI_IE_RX;
+	}
 
 	tegra_spi_writel(tspi, val, SPI_DMA_CTL);
 	tspi->dma_control_reg = val;
@@ -848,6 +857,12 @@ static int tegra_spi_setup(struct spi_device *spi)
 		return ret;
 	}
 
+	if (tspi->soc_data->has_intr_mask_reg) {
+		val = tegra_spi_readl(tspi, SPI_INTR_MASK);
+		val &= ~SPI_INTR_ALL_MASK;
+		tegra_spi_writel(tspi, val, SPI_INTR_MASK);
+	}
+
 	spin_lock_irqsave(&tspi->lock, flags);
 	val = tspi->def_command1_reg;
 	if (spi->mode & SPI_CS_HIGH)
@@ -1126,8 +1141,29 @@ static irqreturn_t tegra_spi_isr(int irq, void *context_data)
 	return IRQ_WAKE_THREAD;
 }
 
+static struct tegra_spi_soc_data tegra114_spi_soc_data = {
+	.has_intr_mask_reg = false,
+};
+
+static struct tegra_spi_soc_data tegra124_spi_soc_data = {
+	.has_intr_mask_reg = false,
+};
+
+static struct tegra_spi_soc_data tegra210_spi_soc_data = {
+	.has_intr_mask_reg = true,
+};
+
 static const struct of_device_id tegra_spi_of_match[] = {
-	{ .compatible = "nvidia,tegra114-spi", },
+	{
+		.compatible = "nvidia,tegra114-spi",
+		.data	    = &tegra114_spi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra124-spi",
+		.data	    = &tegra124_spi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra210-spi",
+		.data	    = &tegra210_spi_soc_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tegra_spi_of_match);
@@ -1168,6 +1204,13 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tspi->dev = &pdev->dev;
 	spin_lock_init(&tspi->lock);
 
+	tspi->soc_data = of_device_get_match_data(&pdev->dev);
+	if (!tspi->soc_data) {
+		dev_err(&pdev->dev, "unsupported tegra\n");
+		ret = -ENODEV;
+		goto exit_free_master;
+	}
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(tspi->base)) {
-- 
2.7.4
