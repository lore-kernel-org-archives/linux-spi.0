From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 18/26] spi: tegra114: add support for hw based cs
Date: Tue, 26 Mar 2019 22:56:39 -0700
Message-ID: <1553666207-11414-18-git-send-email-skomatineni@nvidia.com>
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

This patch adds support for HW based CS control.

Tegra SPI controller supports both HW and SW based CS control
transfers.

Tegra SPI driver default uses SW CS control for transfers and HW CS
control can be enabled through SPI client device node DT property
nvidia,enable-hw-based-cs and is used only for single transfers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 71 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 68fee474580b..86c34f02d13a 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -167,6 +167,10 @@ struct tegra_spi_soc_data {
 	bool has_intr_mask_reg;
 };
 
+struct tegra_spi_client_data {
+	bool is_hw_based_cs;
+};
+
 struct tegra_spi_data {
 	struct device				*dev;
 	struct spi_master			*master;
@@ -193,6 +197,7 @@ struct tegra_spi_data {
 	unsigned				dma_buf_size;
 	unsigned				max_buf_size;
 	bool					is_curr_dma_xfer;
+	bool					use_hw_based_cs;
 
 	struct completion			rx_dma_complete;
 	struct completion			tx_dma_complete;
@@ -723,9 +728,11 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 }
 
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
-		struct spi_transfer *t, bool is_first_of_msg)
+		struct spi_transfer *t, bool is_first_of_msg,
+		bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
 	u32 command1;
@@ -776,11 +783,19 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		} else
 			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 
-		command1 |= SPI_CS_SW_HW;
-		if (spi->mode & SPI_CS_HIGH)
-			command1 |= SPI_CS_SW_VAL;
-		else
-			command1 &= ~SPI_CS_SW_VAL;
+		tspi->use_hw_based_cs = false;
+		if (cdata && cdata->is_hw_based_cs && is_single_xfer)
+			tspi->use_hw_based_cs = true;
+
+		if (!tspi->use_hw_based_cs) {
+			command1 |= SPI_CS_SW_HW;
+			if (spi->mode & SPI_CS_HIGH)
+				command1 |= SPI_CS_SW_VAL;
+			else
+				command1 &= ~SPI_CS_SW_VAL;
+		} else {
+			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
+		}
 
 		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
 	} else {
@@ -838,9 +853,41 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
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
+	if (of_property_read_bool(slave_np, "nvidia,enable-hw-based-cs"))
+		cdata->is_hw_based_cs = true;
+
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
@@ -851,9 +898,15 @@ static int tegra_spi_setup(struct spi_device *spi)
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
+		tegra_spi_cleanup(spi);
 		return ret;
 	}
 
@@ -909,18 +962,21 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	struct tegra_spi_data *tspi = spi_master_get_devdata(master);
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
+	int single_xfer;
 	int ret;
 	bool skip = false;
 
 	msg->status = 0;
 	msg->actual_length = 0;
 
+	single_xfer = list_is_singular(&msg->transfers);
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		u32 cmd1;
 
 		reinit_completion(&tspi->xfer_completion);
 
-		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg);
+		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
+						    single_xfer);
 
 		if (!xfer->len) {
 			ret = 0;
@@ -1193,6 +1249,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
+	master->cleanup = tegra_spi_cleanup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->auto_runtime_pm = true;
-- 
2.7.4
