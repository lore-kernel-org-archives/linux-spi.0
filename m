From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 3/7] spi: zynq-qspi: Keep the bitfields naming consistent
Date: Fri,  8 Nov 2019 15:07:40 +0100
Message-ID: <20191108140744.1734-4-miquel.raynal@bootlin.com>
References: <20191108140744.1734-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@xilinx.com>,
 Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191108140744.1734-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Most of the bits/bitfields #define'd in this driver are composed with:
1/ the driver prefix
2/ the name of the register they apply to

Keep the naming consistent by applying this rule to the CONFIG register
internals. These definitions will be used in a following change set.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 641691f5dedf..78711fe955f4 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -61,9 +61,9 @@
  * These are the values used in the calculation of baud rate divisor and
  * setting the slave select.
  */
-#define ZYNQ_QSPI_BAUD_DIV_MAX		GENMASK(2, 0) /* Baud rate maximum */
-#define ZYNQ_QSPI_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift in CR */
-#define ZYNQ_QSPI_SS_SHIFT		10 /* Slave Select field shift in CR */
+#define ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX	GENMASK(2, 0) /* Baud rate maximum */
+#define ZYNQ_QSPI_CONFIG_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift */
+#define ZYNQ_QSPI_CONFIG_PCS		10 /* Peripheral Chip Select */
 
 /*
  * QSPI Interrupt Registers bit Masks
@@ -293,7 +293,7 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 		/* Select the slave */
 		config_reg &= ~ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
 		config_reg |= (((~(BIT(spi->chip_select))) <<
-				ZYNQ_QSPI_SS_SHIFT) &
+				ZYNQ_QSPI_CONFIG_PCS) &
 				ZYNQ_QSPI_CONFIG_SSCTRL_MASK);
 	} else {
 		config_reg |= ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
@@ -332,7 +332,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
 	 *      ----------------
 	 *      111 - divide by 256
 	 */
-	while ((baud_rate_val < ZYNQ_QSPI_BAUD_DIV_MAX)  &&
+	while ((baud_rate_val < ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX)  &&
 	       (clk_get_rate(xqspi->refclk) / (2 << baud_rate_val)) >
 		spi->max_speed_hz)
 		baud_rate_val++;
@@ -348,7 +348,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
 		config_reg |= ZYNQ_QSPI_CONFIG_CPOL_MASK;
 
 	config_reg &= ~ZYNQ_QSPI_CONFIG_BDRATE_MASK;
-	config_reg |= (baud_rate_val << ZYNQ_QSPI_BAUD_DIV_SHIFT);
+	config_reg |= (baud_rate_val << ZYNQ_QSPI_CONFIG_BAUD_DIV_SHIFT);
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_CONFIG_OFFSET, config_reg);
 
 	return 0;
-- 
2.20.1
