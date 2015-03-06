From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: [PATCH 1/2] spi: qup: Fix cs-num DT property parsing
Date: Fri,  6 Mar 2015 17:26:17 +0200
Message-ID: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

num-cs is 32 bit property, don't read just upper 16 bits.

Fixes: 4a8573abe965 "spi: qup: Remove chip select function"
Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/spi/spi-qup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index ff9cdbd..2b2c359 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -498,7 +498,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct device *dev;
 	void __iomem *base;
-	u32 max_freq, iomode;
+	u32 max_freq, iomode, num_cs;
 	int ret, irq, size;

 	dev = &pdev->dev;
@@ -550,10 +550,11 @@ static int spi_qup_probe(struct platform_device *pdev)
 	}

 	/* use num-cs unless not present or out of range */
-	if (of_property_read_u16(dev->of_node, "num-cs",
-			&master->num_chipselect) ||
-			(master->num_chipselect > SPI_NUM_CHIPSELECTS))
+	if (of_property_read_u32(dev->of_node, "num-cs", &num_cs) ||
+	    num_cs > SPI_NUM_CHIPSELECTS)
 		master->num_chipselect = SPI_NUM_CHIPSELECTS;
+	else
+		master->num_chipselect = num_cs;

 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
--
1.9.1
