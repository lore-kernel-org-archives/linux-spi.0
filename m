From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 20/26] spi: tegra114: add support for tuning HW CS timing
Date: Tue, 26 Mar 2019 22:56:41 -0700
Message-ID: <1553666207-11414-20-git-send-email-skomatineni@nvidia.com>
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

Some slaves may need certain CS setup time, hold time, CS inactive
delay between the packets. Tegra SPI controller supports configuring
these CS timing parameters and are applicable when using HW CS.

This patch adds support for configuring these HW CS timing parameters
through device tree properties.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 61 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 86c34f02d13a..e01962344bde 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -95,8 +95,10 @@
 		(reg = (((val) & 0x1) << ((cs) * 8 + 5)) |	\
 			((reg) & ~(1 << ((cs) * 8 + 5))))
 #define SPI_SET_CYCLES_BETWEEN_PACKETS(reg, cs, val)		\
-		(reg = (((val) & 0xF) << ((cs) * 8)) |		\
-			((reg) & ~(0xF << ((cs) * 8))))
+		(reg = (((val) & 0x1F) << ((cs) * 8)) |		\
+			((reg) & ~(0x1F << ((cs) * 8))))
+#define MAX_SETUP_HOLD_CYCLES			16
+#define MAX_INACTIVE_CYCLES			32
 
 #define SPI_TRANS_STATUS			0x010
 #define SPI_BLK_CNT(val)			(((val) >> 0) & 0xFFFF)
@@ -169,6 +171,9 @@ struct tegra_spi_soc_data {
 
 struct tegra_spi_client_data {
 	bool is_hw_based_cs;
+	int cs_setup_clk_count;
+	int cs_hold_clk_count;
+	int cs_inactive_cycles;
 };
 
 struct tegra_spi_data {
@@ -210,6 +215,8 @@ struct tegra_spi_data {
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
+	u32					spi_cs_timing1;
+	u32					spi_cs_timing2;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -727,6 +734,43 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 	dma_release_channel(dma_chan);
 }
 
+static void tegra_spi_set_hw_cs_timing(struct spi_device *spi)
+{
+	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
+	u32 setup_dly;
+	u32 hold_dly;
+	u32 setup_hold;
+	u32 spi_cs_timing;
+	u32 inactive_cycles;
+	u8 cs_state;
+
+	setup_dly = min(cdata->cs_setup_clk_count, MAX_SETUP_HOLD_CYCLES);
+	hold_dly = min(cdata->cs_hold_clk_count, MAX_SETUP_HOLD_CYCLES);
+	setup_hold = SPI_SETUP_HOLD(setup_dly - 1, hold_dly - 1);
+	spi_cs_timing = SPI_CS_SETUP_HOLD(tspi->spi_cs_timing1,
+					  spi->chip_select,
+					  setup_hold);
+	if (tspi->spi_cs_timing1 != spi_cs_timing) {
+		tspi->spi_cs_timing1 = spi_cs_timing;
+		tegra_spi_writel(tspi, spi_cs_timing, SPI_CS_TIMING1);
+	}
+
+	spi_cs_timing = tspi->spi_cs_timing2;
+	inactive_cycles = min(cdata->cs_inactive_cycles, MAX_INACTIVE_CYCLES);
+	if (inactive_cycles)
+		inactive_cycles--;
+	cs_state = inactive_cycles ? 0 : 1;
+	SPI_SET_CS_ACTIVE_BETWEEN_PACKETS(spi_cs_timing, spi->chip_select,
+					  cs_state);
+	SPI_SET_CYCLES_BETWEEN_PACKETS(spi_cs_timing, spi->chip_select,
+				       inactive_cycles);
+	if (tspi->spi_cs_timing2 != spi_cs_timing) {
+		tspi->spi_cs_timing2 = spi_cs_timing;
+		tegra_spi_writel(tspi, spi_cs_timing, SPI_CS_TIMING2);
+	}
+}
+
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		struct spi_transfer *t, bool is_first_of_msg,
 		bool is_single_xfer)
@@ -784,8 +828,10 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 
 		tspi->use_hw_based_cs = false;
-		if (cdata && cdata->is_hw_based_cs && is_single_xfer)
+		if (cdata && cdata->is_hw_based_cs && is_single_xfer) {
 			tspi->use_hw_based_cs = true;
+			tegra_spi_set_hw_cs_timing(spi);
+		}
 
 		if (!tspi->use_hw_based_cs) {
 			command1 |= SPI_CS_SW_HW;
@@ -871,7 +917,12 @@ static struct tegra_spi_client_data
 
 	if (of_property_read_bool(slave_np, "nvidia,enable-hw-based-cs"))
 		cdata->is_hw_based_cs = true;
-
+	of_property_read_u32(slave_np, "nvidia,cs-setup-clk-count",
+			     &cdata->cs_setup_clk_count);
+	of_property_read_u32(slave_np, "nvidia,cs-hold-clk-count",
+			     &cdata->cs_hold_clk_count);
+	of_property_read_u32(slave_np, "nvidia,cs-inactive-cycles",
+			     &cdata->cs_inactive_cycles);
 	return cdata;
 }
 
@@ -1326,6 +1377,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 	tspi->def_command1_reg  = SPI_M_S;
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
+	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
+	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
 	pm_runtime_put(&pdev->dev);
 	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
 				   tegra_spi_isr_thread, IRQF_ONESHOT,
-- 
2.7.4
