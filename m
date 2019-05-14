From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 3/4] spi: tegra114: add support for HW CS timing
Date: Mon, 13 May 2019 21:31:51 -0700
Message-ID: <1557808312-3213-3-git-send-email-skomatineni@nvidia.com>
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

This patch implements set_cs_timing SPI controller method to allow
SPI client driver to configure device specific SPI CS timings.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 48 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 0cb0932d32fd..e59ff7c1cee6 100644
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
@@ -206,6 +208,8 @@ struct tegra_spi_data {
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
+	u32					spi_cs_timing1;
+	u32					spi_cs_timing2;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -723,6 +727,43 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 	dma_release_channel(dma_chan);
 }
 
+static void tegra_spi_set_hw_cs_timing(struct spi_device *spi, u8 setup_dly,
+				       u8 hold_dly, u8 inactive_dly)
+{
+	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	u32 setup_hold;
+	u32 spi_cs_timing;
+	u32 inactive_cycles;
+	u8 cs_state;
+
+	setup_dly = min_t(u8, setup_dly, MAX_SETUP_HOLD_CYCLES);
+	hold_dly = min_t(u8, hold_dly, MAX_SETUP_HOLD_CYCLES);
+	if (setup_dly && hold_dly) {
+		setup_hold = SPI_SETUP_HOLD(setup_dly - 1, hold_dly - 1);
+		spi_cs_timing = SPI_CS_SETUP_HOLD(tspi->spi_cs_timing1,
+						  spi->chip_select,
+						  setup_hold);
+		if (tspi->spi_cs_timing1 != spi_cs_timing) {
+			tspi->spi_cs_timing1 = spi_cs_timing;
+			tegra_spi_writel(tspi, spi_cs_timing, SPI_CS_TIMING1);
+		}
+	}
+
+	inactive_cycles = min_t(u8, inactive_dly, MAX_INACTIVE_CYCLES);
+	if (inactive_cycles)
+		inactive_cycles--;
+	cs_state = inactive_cycles ? 0 : 1;
+	spi_cs_timing = tspi->spi_cs_timing2;
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
 					struct spi_transfer *t,
 					bool is_first_of_msg,
@@ -1232,6 +1273,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
+	master->set_cs_timing = tegra_spi_set_hw_cs_timing;
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->auto_runtime_pm = true;
 	bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
@@ -1307,6 +1349,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
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
