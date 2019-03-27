From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 26/26] spi: tegra114: add support for LSBYTE_FIRST
Date: Tue, 26 Mar 2019 22:56:47 -0700
Message-ID: <1553666207-11414-26-git-send-email-skomatineni@nvidia.com>
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

Some SPI devices expects SPI transfers to be in Least significant byte
first order and some devices expect Most significant byte first order.

This patch adds SPI_LSBYTE_FIRST to supported mode list and implements
configuration accordingly.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index e1669ab3b0fe..a2e809af96da 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -827,6 +827,11 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
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
@@ -1393,7 +1398,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
+			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE |
+			    SPI_LSBYTE_FIRST;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
 	master->cleanup = tegra_spi_cleanup;
-- 
2.7.4
