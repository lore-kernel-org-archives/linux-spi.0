From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 07/20] spi: tegra114: set bus number based on id
Date: Thu, 4 Apr 2019 17:14:06 -0700
Message-ID: <1554423259-26056-7-git-send-email-skomatineni@nvidia.com>
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

This patch sets SPI device id from the device tree as the bus number.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 191233eae149..58f5059b339f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1138,6 +1138,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	struct tegra_spi_data	*tspi;
 	struct resource		*r;
 	int ret, spi_irq;
+	int bus_num;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*tspi));
 	if (!master) {
@@ -1158,6 +1159,9 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->auto_runtime_pm = true;
+	bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
+	if (bus_num >= 0)
+		master->bus_num = bus_num;
 
 	tspi->master = master;
 	tspi->dev = &pdev->dev;
-- 
2.7.4
