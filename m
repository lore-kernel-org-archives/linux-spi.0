From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 4/4] spi: tegra114: add support for TX and RX trimmers
Date: Mon, 13 May 2019 21:31:52 -0700
Message-ID: <1557808312-3213-4-git-send-email-skomatineni@nvidia.com>
References: <1557808312-3213-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557808312-3213-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Tegra SPI master controller has programmable trimmers to adjust the
data with respect to the clock.

These trimmers are programmed in TX_CLK_TAP_DELAY and RX_CLK_TAP_DELAY
fields of COMMAND2 register.

SPI TX trimmer is to adjust the outgoing data with respect to the
outgoing clock and SPI RX trimmer is to adjust the loopback clock with
respect to the incoming data from the slave device.

These trimmers vary based on trace lengths of the platform design for
each of the slaves on the SPI bus and optimal value programmed is from
the platform validation across PVT.

This patch adds support for configuring TX and RX clock delay trimmers
through the device tree properties.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 69 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index e59ff7c1cee6..377fcc026794 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -169,6 +169,11 @@ struct tegra_spi_soc_data {
 	bool has_intr_mask_reg;
 };
 
+struct tegra_spi_client_data {
+	int tx_clk_tap_delay;
+	int rx_clk_tap_delay;
+};
+
 struct tegra_spi_data {
 	struct device				*dev;
 	struct spi_master			*master;
@@ -208,8 +213,10 @@ struct tegra_spi_data {
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
+	u32					def_command2_reg;
 	u32					spi_cs_timing1;
 	u32					spi_cs_timing2;
+	u8					last_used_cs;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -770,10 +777,12 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 					bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
-	u32 command1;
+	u32 command1, command2;
 	int req_mode;
+	u32 tx_tap = 0, rx_tap = 0;
 
 	if (speed != tspi->cur_speed) {
 		clk_set_rate(tspi->clk, speed);
@@ -836,7 +845,18 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 				command1 &= ~SPI_CS_SW_VAL;
 		}
 
-		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
+		if (tspi->last_used_cs != spi->chip_select) {
+			if (cdata && cdata->tx_clk_tap_delay)
+				tx_tap = cdata->tx_clk_tap_delay;
+			if (cdata && cdata->rx_clk_tap_delay)
+				rx_tap = cdata->rx_clk_tap_delay;
+			command2 = SPI_TX_TAP_DELAY(tx_tap) |
+				   SPI_RX_TAP_DELAY(rx_tap);
+			if (command2 != tspi->def_command2_reg)
+				tegra_spi_writel(tspi, command2, SPI_COMMAND2);
+			tspi->last_used_cs = spi->chip_select;
+		}
+
 	} else {
 		command1 = tspi->command1_reg;
 		command1 &= ~SPI_BIT_LENGTH(~0);
@@ -892,9 +912,42 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 	return ret;
 }
 
+static struct tegra_spi_client_data
+	*tegra_spi_parse_cdata_dt(struct spi_device *spi)
+{
+	struct tegra_spi_client_data *cdata;
+	struct device_node *slave_np;
+
+	slave_np = spi->dev.of_node;
+	if (!slave_np) {
+		dev_dbg(&spi->dev, "device node not found\n");
+		return NULL;
+	}
+
+	cdata = kzalloc(sizeof(*cdata), GFP_KERNEL);
+	if (!cdata)
+		return NULL;
+
+	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
+			     &cdata->tx_clk_tap_delay);
+	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
+			     &cdata->rx_clk_tap_delay);
+	return cdata;
+}
+
+static void tegra_spi_cleanup(struct spi_device *spi)
+{
+	struct tegra_spi_client_data *cdata = spi->controller_data;
+
+	spi->controller_data = NULL;
+	if (spi->dev.of_node)
+		kfree(cdata);
+}
+
 static int tegra_spi_setup(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	u32 val;
 	unsigned long flags;
 	int ret;
@@ -905,6 +958,11 @@ static int tegra_spi_setup(struct spi_device *spi)
 		spi->mode & SPI_CPHA ? "" : "~",
 		spi->max_speed_hz);
 
+	if (!cdata) {
+		cdata = tegra_spi_parse_cdata_dt(spi);
+		spi->controller_data = cdata;
+	}
+
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
@@ -1034,6 +1092,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			reset_control_assert(tspi->rst);
 			udelay(2);
 			reset_control_deassert(tspi->rst);
+			tspi->last_used_cs = master->num_chipselect + 1;
 			goto complete_xfer;
 		}
 
@@ -1089,6 +1148,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
+		tspi->last_used_cs = master->num_chipselect + 1;
 		return IRQ_HANDLED;
 	}
 
@@ -1164,6 +1224,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
+		tspi->last_used_cs = master->num_chipselect + 1;
 		return IRQ_HANDLED;
 	}
 
@@ -1351,6 +1412,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
 	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
+	tspi->def_command2_reg = tegra_spi_readl(tspi, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(&pdev->dev);
 	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
 				   tegra_spi_isr_thread, IRQF_ONESHOT,
@@ -1423,6 +1486,8 @@ static int tegra_spi_resume(struct device *dev)
 		return ret;
 	}
 	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	tegra_spi_writel(tspi, tspi->def_command2_reg, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(dev);
 
 	return spi_master_resume(master);
-- 
2.7.4
