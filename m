From: Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH] spi: a3700: Fix clk prescaling for coefficient over 15
Date: Mon, 27 Nov 2017 15:16:32 +0100
Message-ID: <1511792192-7090-1-git-send-email-maxime.chevallier@smile.fr>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        gregory.clement@free-electrons.com,
        miquel.raynal@free-electrons.com,
        Maxime Chevallier <maxime.chevallier@smile.fr>
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The Armada 3700 SPI controller has 2 ranges of prescaler coefficients.
One ranging from 0 to 15 by steps of 1, and one ranging from 0 to 30 by
steps of 2.

This commit fixes the prescaler coefficients that are over 15 so that it
uses the correct range of values. The prescaling coefficient is rounded
to the upper value if it is odd.

This was tested on Espressobin with spidev and a locigal analyser.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
---
 drivers/spi/spi-armada-3700.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index fe58685..1f0ff45 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -79,6 +79,7 @@
 #define A3700_SPI_BYTE_LEN		BIT(5)
 #define A3700_SPI_CLK_PRESCALE		BIT(0)
 #define A3700_SPI_CLK_PRESCALE_MASK	(0x1f)
+#define A3700_SPI_CLK_EVEN_OFFS		(0x10)
 
 #define A3700_SPI_WFIFO_THRS_BIT	28
 #define A3700_SPI_RFIFO_THRS_BIT	24
@@ -220,6 +221,13 @@ static void a3700_spi_clock_set(struct a3700_spi *a3700_spi,
 
 	prescale = DIV_ROUND_UP(clk_get_rate(a3700_spi->clk), speed_hz);
 
+	/* For prescaler values over 15, we can only set it by steps of 2.
+	 * Starting from A3700_SPI_CLK_EVEN_OFFS, we set values from 0 up to
+	 * 30. We only use this range from 16 to 30.
+	 */
+	if (prescale > 15)
+		prescale = A3700_SPI_CLK_EVEN_OFFS + DIV_ROUND_UP(prescale, 2);
+
 	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
 	val = val & ~A3700_SPI_CLK_PRESCALE_MASK;
 
-- 
2.1.4
