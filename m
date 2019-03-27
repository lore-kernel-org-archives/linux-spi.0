From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 23/26] spi: tegra114: add support for gpio based cs
Date: Tue, 26 Mar 2019 22:56:44 -0700
Message-ID: <1553666207-11414-23-git-send-email-skomatineni@nvidia.com>
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

This patch adds supports for chip select control using GPIO if valid
CS gpio exists rather than controlling from the SPI controller.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 725d60364ec6..9b216e9d6079 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -23,6 +23,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -178,6 +179,10 @@ struct tegra_spi_client_data {
 	int rx_clk_tap_delay;
 };
 
+struct tegra_spi_client_state {
+	bool cs_gpio_valid;
+};
+
 struct tegra_spi_data {
 	struct device				*dev;
 	struct spi_master			*master;
@@ -781,6 +786,7 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	struct tegra_spi_client_data *cdata = spi->controller_data;
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
 	u32 command1;
@@ -849,6 +855,12 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
 		}
 
+		if (cstate->cs_gpio_valid) {
+			int val = (spi->mode & SPI_CS_HIGH) ? 1 : 0;
+
+			gpio_set_value(spi->cs_gpio, val);
+		}
+
 		if (tspi->last_used_cs != spi->chip_select) {
 			if (cdata && cdata->tx_clk_tap_delay)
 				tx_tap = cdata->tx_clk_tap_delay;
@@ -950,7 +962,12 @@ static struct tegra_spi_client_data
 static void tegra_spi_cleanup(struct spi_device *spi)
 {
 	struct tegra_spi_client_data *cdata = spi->controller_data;
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 
+	spi->controller_state = NULL;
+	if (cstate && cstate->cs_gpio_valid)
+		gpio_free(spi->cs_gpio);
+	kfree(cstate);
 	spi->controller_data = NULL;
 	if (spi->dev.of_node)
 		kfree(cdata);
@@ -960,6 +977,7 @@ static int tegra_spi_setup(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	struct tegra_spi_client_data *cdata = spi->controller_data;
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 	u32 val;
 	unsigned long flags;
 	int ret;
@@ -970,11 +988,41 @@ static int tegra_spi_setup(struct spi_device *spi)
 		spi->mode & SPI_CPHA ? "" : "~",
 		spi->max_speed_hz);
 
+	if (!cstate) {
+		cstate = kzalloc(sizeof(*cstate), GFP_KERNEL);
+		if (!cstate)
+			return -ENOMEM;
+		spi->controller_state = cstate;
+	}
+
 	if (!cdata) {
 		cdata = tegra_spi_parse_cdata_dt(spi);
 		spi->controller_data = cdata;
 	}
 
+	if (spi->master->cs_gpios && gpio_is_valid(spi->cs_gpio)) {
+		if (!cstate->cs_gpio_valid) {
+			int gpio_flag = GPIOF_OUT_INIT_HIGH;
+
+			if (spi->mode & SPI_CS_HIGH)
+				gpio_flag = GPIOF_OUT_INIT_LOW;
+
+			ret = gpio_request_one(spi->cs_gpio, gpio_flag,
+					       "cs_gpio");
+			if (ret < 0) {
+				dev_err(&spi->dev,
+					"GPIO request failed: %d\n", ret);
+				tegra_spi_cleanup(spi);
+				return ret;
+			}
+			cstate->cs_gpio_valid = true;
+		} else {
+			int val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
+
+			gpio_set_value(spi->cs_gpio, val);
+		}
+	}
+
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
@@ -1034,9 +1082,11 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	struct tegra_spi_data *tspi = spi_master_get_devdata(master);
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 	int single_xfer;
 	int ret;
 	bool skip = false;
+	int cs_val;
 
 	msg->status = 0;
 	msg->actual_length = 0;
@@ -1093,7 +1143,10 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		msg->actual_length += xfer->len;
 
 complete_xfer:
+		cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
 		if (ret < 0 || skip) {
+			if (cstate->cs_gpio_valid)
+				gpio_set_value(spi->cs_gpio, cs_val);
 			tegra_spi_writel(tspi, tspi->def_command1_reg,
 					SPI_COMMAND1);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
@@ -1103,11 +1156,15 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			if (xfer->cs_change)
 				tspi->cs_control = spi;
 			else {
+				if (cstate->cs_gpio_valid)
+					gpio_set_value(spi->cs_gpio, cs_val);
 				tegra_spi_writel(tspi, tspi->def_command1_reg,
 						SPI_COMMAND1);
 				tegra_spi_transfer_delay(xfer->delay_usecs);
 			}
 		} else if (xfer->cs_change) {
+			if (cstate->cs_gpio_valid)
+				gpio_set_value(spi->cs_gpio, cs_val);
 			tegra_spi_writel(tspi, tspi->def_command1_reg,
 					SPI_COMMAND1);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
-- 
2.7.4
