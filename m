From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 20/20] spi: tegra114: add support for tuning TX and RX trimmers
Date: Thu, 4 Apr 2019 17:14:19 -0700
Message-ID: <1554423259-26056-20-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
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
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Tegra SPI controller has TX_CLK_TAP_DELAY and RX_CLK_TAP_DELAY in
COMMAND2 register to tune the delay of the clock going out to external
device during transmit and also for the clock coming in from external
device during receive.

TX/RX clock tap delays may vary based on the trace lengths of the
platform design for each of the slaves on the SPI bus.

This patch adds support for configuring TX/RX clock delays specified
through device tree properties.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 63 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 34dee28554ef..9854e6fbddff 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -170,6 +170,11 @@ struct tegra_spi_soc_data {
 	bool has_intr_mask_reg;
 };
 
+struct tegra_spi_client_data {
+	int tx_clk_tap_delay;
+	int rx_clk_tap_delay;
+};
+
 struct tegra_spi_client_state {
 	bool cs_gpio_valid;
 };
@@ -213,8 +218,10 @@ struct tegra_spi_data {
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
+	u32					def_command2_reg;
 	u32					spi_cs_timing1;
 	u32					spi_cs_timing2;
+	u8					last_used_cs;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -774,11 +781,13 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	struct tegra_spi_client_state *cstate = spi->controller_state;
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
-	u32 command1;
+	u32 command1, command2;
 	int req_mode;
+	u32 tx_tap = 0, rx_tap = 0;
 
 	if (speed != tspi->cur_speed) {
 		clk_set_rate(tspi->clk, speed);
@@ -848,6 +857,18 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 			gpio_set_value(spi->cs_gpio, val);
 		}
 
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
 		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
 	} else {
 		command1 = tspi->command1_reg;
@@ -904,19 +925,47 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
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
 static void tegra_spi_cleanup(struct spi_device *spi)
 {
 	struct tegra_spi_client_state *cstate = spi->controller_state;
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 
 	spi->controller_state = NULL;
 	if (cstate && cstate->cs_gpio_valid)
 		gpio_free(spi->cs_gpio);
 	kfree(cstate);
+	spi->controller_data = NULL;
+	if (spi->dev.of_node)
+		kfree(cdata);
 }
 
 static int tegra_spi_setup(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	struct tegra_spi_client_state *cstate = spi->controller_state;
 	u32 val;
 	unsigned long flags;
@@ -935,6 +984,11 @@ static int tegra_spi_setup(struct spi_device *spi)
 		spi->controller_state = cstate;
 	}
 
+	if (!cdata) {
+		cdata = tegra_spi_parse_cdata_dt(spi);
+		spi->controller_data = cdata;
+	}
+
 	if (spi->master->cs_gpios && gpio_is_valid(spi->cs_gpio)) {
 		if (!cstate->cs_gpio_valid) {
 			int gpio_flag = GPIOF_OUT_INIT_HIGH;
@@ -1084,6 +1138,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			reset_control_assert(tspi->rst);
 			udelay(2);
 			reset_control_deassert(tspi->rst);
+			tspi->last_used_cs = master->num_chipselect + 1;
 			goto complete_xfer;
 		}
 
@@ -1139,6 +1194,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
+		tspi->last_used_cs = master->num_chipselect + 1;
 		return IRQ_HANDLED;
 	}
 
@@ -1214,6 +1270,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
+		tspi->last_used_cs = master->num_chipselect + 1;
 		return IRQ_HANDLED;
 	}
 
@@ -1402,6 +1459,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
 	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
+	tspi->def_command2_reg = tegra_spi_readl(tspi, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(&pdev->dev);
 	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
 				   tegra_spi_isr_thread, IRQF_ONESHOT,
@@ -1474,6 +1533,8 @@ static int tegra_spi_resume(struct device *dev)
 		return ret;
 	}
 	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	tegra_spi_writel(tspi, tspi->def_command2_reg, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(dev);
 
 	return spi_master_resume(master);
-- 
2.7.4
