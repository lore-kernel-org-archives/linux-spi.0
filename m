From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V3 6/9] spi: tegra114: add support for gpio based CS
Date: Mon, 15 Apr 2019 14:30:31 -0700
Message-ID: <1555363834-32155-7-git-send-email-skomatineni@nvidia.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
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
In-Reply-To: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds support for GPIO based CS control through SPI core
function spi_set_cs.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f4e39eb3857c..0b04eba242c0 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -781,6 +781,9 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		} else
 			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 
+		/* GPIO based chip select control */
+		spi_set_cs(spi, true);
+
 		command1 |= SPI_CS_SW_HW;
 		if (spi->mode & SPI_CS_HIGH)
 			command1 |= SPI_CS_SW_VAL;
@@ -869,6 +872,8 @@ static int tegra_spi_setup(struct spi_device *spi)
 	}
 
 	spin_lock_irqsave(&tspi->lock, flags);
+	/* GPIO based chip select control */
+	spi_set_cs(spi, false);
 	val = tspi->def_command1_reg;
 	if (spi->mode & SPI_CS_HIGH)
 		val &= ~SPI_CS_POL_INACTIVE(spi->chip_select);
@@ -898,6 +903,8 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
 
+	/* GPIO based chip select control */
+	spi_set_cs(spi, false);
 	if (cs_val)
 		tspi->command1_reg |= SPI_CS_SW_VAL;
 	else
-- 
2.7.4
