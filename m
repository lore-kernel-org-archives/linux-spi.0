From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 12/20] spi: tegra114: add support for LSBYTE_FIRST
Date: Thu, 4 Apr 2019 17:14:11 -0700
Message-ID: <1554423259-26056-12-git-send-email-skomatineni@nvidia.com>
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

Some SPI devices expects SPI transfers to be in Least significant byte
first order and some devices expect Most significant byte first order.

This patch adds SPI_LSBYTE_FIRST to the supported SPI mode list and also
configures Tegra SPI controller accordingly.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 212bb90aa0cb..d3b95bba2361 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -755,6 +755,11 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		else
 			command1 &= ~SPI_LSBIT_FE;
 
+		if (spi->mode & SPI_LSBYTE_FIRST)
+			command1 |= SPI_LSBYTE_FE;
+		else
+			command1 &= ~SPI_LSBYTE_FE;
+
 		if (spi->mode & SPI_3WIRE)
 			command1 |= SPI_BIDIROE;
 		else
@@ -1164,7 +1169,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
+			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE |
+			    SPI_LSBYTE_FIRST;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
-- 
2.7.4
