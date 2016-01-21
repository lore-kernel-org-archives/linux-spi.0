From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] spi: qup: provide proper bus numbers
Date: Thu, 21 Jan 2016 18:33:47 +0000
Message-ID: <1453401227-27135-1-git-send-email-srinivas.kandagatla@linaro.org>
Cc: David Brown <david.brown@linaro.org>,
	Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Andy Gross <andy.gross@linaro.org>, linux-spi@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This driver reuses pdev->id for spi bus numbers resulting in random
or very large bus numbering when used with device trees. pdev->id
is not the correct choice when using device trees. So add code to
get bus numbers via device tree aliases and if it fails then generate
a unique bus number.

Without this patch the driver get a random and useless bus number.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/spi/spi-qup.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 810a7fa..2bc67a9 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -127,6 +127,8 @@
 #define SPI_DELAY_THRESHOLD		1
 #define SPI_DELAY_RETRY			10
 
+static atomic_t spi_qup_next_id = ATOMIC_INIT(0);
+
 struct spi_qup {
 	void __iomem		*base;
 	struct device		*dev;
@@ -759,7 +761,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	struct device *dev;
 	void __iomem *base;
 	u32 max_freq, iomode, num_cs;
-	int ret, irq, size;
+	int ret, irq, size, bus_num;
 
 	dev = &pdev->dev;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -816,7 +818,15 @@ static int spi_qup_probe(struct platform_device *pdev)
 	else
 		master->num_chipselect = num_cs;
 
-	master->bus_num = pdev->id;
+	if (dev->of_node)
+		bus_num = of_alias_get_id(dev->of_node, "spi");
+	else
+		bus_num = pdev->id;
+
+	if (bus_num < 0)
+		bus_num = atomic_inc_return(&spi_qup_next_id) - 1;
+
+	master->bus_num = bus_num;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->max_speed_hz = max_freq;
-- 
1.9.1
