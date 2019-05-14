From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Date: Mon, 13 May 2019 22:03:52 -0700
Message-ID: <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds support for GPIO based CS control through SPI core
function spi_set_cs.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index b1f31bb16659..f47417dd9edb 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -776,6 +776,10 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		} else
 			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 
+		/* GPIO based chip select control */
+		if (spi->cs_gpiod)
+			gpiod_set_value(spi->cs_gpiod, 1);
+
 		command1 |= SPI_CS_SW_HW;
 		if (spi->mode & SPI_CS_HIGH)
 			command1 |= SPI_CS_SW_VAL;
@@ -864,6 +868,10 @@ static int tegra_spi_setup(struct spi_device *spi)
 	}
 
 	spin_lock_irqsave(&tspi->lock, flags);
+	/* GPIO based chip select control */
+	if (spi->cs_gpiod)
+		gpiod_set_value(spi->cs_gpiod, 0);
+
 	val = tspi->def_command1_reg;
 	if (spi->mode & SPI_CS_HIGH)
 		val &= ~SPI_CS_POL_INACTIVE(spi->chip_select);
@@ -893,6 +901,10 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
 
+	/* GPIO based chip select control */
+	if (spi->cs_gpiod)
+		gpiod_set_value(spi->cs_gpiod, 0);
+
 	if (cs_val)
 		tspi->command1_reg |= SPI_CS_SW_VAL;
 	else
@@ -1199,6 +1211,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
+	master->use_gpio_descriptors = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
 			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-- 
2.7.4
