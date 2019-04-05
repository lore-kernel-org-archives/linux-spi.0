From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 14/20] spi: tegra114: add support for gpio based cs
Date: Thu, 4 Apr 2019 17:14:13 -0700
Message-ID: <1554423259-26056-14-git-send-email-skomatineni@nvidia.com>
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

This patch adds supports for chip select control using GPIO if valid
CS gpio exists.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f4e39eb3857c..209ec05a349f 100644
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
@@ -167,6 +168,10 @@ struct tegra_spi_soc_data {
 	bool has_intr_mask_reg;
 };
 
+struct tegra_spi_client_state {
+	bool cs_gpio_valid;
+};
+
 struct tegra_spi_data {
 	struct device				*dev;
 	struct spi_master			*master;
@@ -726,6 +731,7 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		struct spi_transfer *t, bool is_first_of_msg)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
 	u32 command1;
@@ -787,6 +793,12 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		else
 			command1 &= ~SPI_CS_SW_VAL;
 
+		if (cstate->cs_gpio_valid) {
+			int val = (spi->mode & SPI_CS_HIGH) ? 1 : 0;
+
+			gpio_set_value(spi->cs_gpio, val);
+		}
+
 		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
 	} else {
 		command1 = tspi->command1_reg;
@@ -843,9 +855,20 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 	return ret;
 }
 
+static void tegra_spi_cleanup(struct spi_device *spi)
+{
+	struct tegra_spi_client_state *cstate = spi->controller_state;
+
+	spi->controller_state = NULL;
+	if (cstate && cstate->cs_gpio_valid)
+		gpio_free(spi->cs_gpio);
+	kfree(cstate);
+}
+
 static int tegra_spi_setup(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 	u32 val;
 	unsigned long flags;
 	int ret;
@@ -856,9 +879,40 @@ static int tegra_spi_setup(struct spi_device *spi)
 		spi->mode & SPI_CPHA ? "" : "~",
 		spi->max_speed_hz);
 
+	if (!cstate) {
+		cstate = kzalloc(sizeof(*cstate), GFP_KERNEL);
+		if (!cstate)
+			return -ENOMEM;
+		spi->controller_state = cstate;
+	}
+
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
+		tegra_spi_cleanup(spi);
 		return ret;
 	}
 
@@ -896,8 +950,12 @@ static void tegra_spi_transfer_delay(int delay)
 static void tegra_spi_transfer_end(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
 
+	if (cstate->cs_gpio_valid)
+		gpio_set_value(spi->cs_gpio, cs_val);
+
 	if (cs_val)
 		tspi->command1_reg |= SPI_CS_SW_VAL;
 	else
@@ -1209,6 +1267,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 			    SPI_LSBYTE_FIRST;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
+	master->cleanup = tegra_spi_cleanup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->auto_runtime_pm = true;
-- 
2.7.4
