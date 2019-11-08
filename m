From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 5/7] spi: zynq-qspi: Clarify the select chip function
Date: Fri,  8 Nov 2019 15:07:42 +0100
Message-ID: <20191108140744.1734-6-miquel.raynal@bootlin.com>
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

The code used to assert and de-assert a chip select line is very
complicated for no reason. Simplify the logic by either setting or
resetting the concerned bit, which actually only changes an electrical
state.

Update the comment to reflect that there is no possibility to actually
choose a CS as the default (CS0) will be driven in any case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 1151443ec830..9adfcc66b02b 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -51,7 +51,6 @@
 #define ZYNQ_QSPI_CONFIG_BDRATE_MASK	GENMASK(5, 3) /* Baud Rate Mask */
 #define ZYNQ_QSPI_CONFIG_CPHA_MASK	BIT(2) /* Clock Phase Control */
 #define ZYNQ_QSPI_CONFIG_CPOL_MASK	BIT(1) /* Clock Polarity Control */
-#define ZYNQ_QSPI_CONFIG_SSCTRL_MASK	BIT(10) /* Slave Select Mask */
 #define ZYNQ_QSPI_CONFIG_FWIDTH_MASK	GENMASK(7, 6) /* FIFO width */
 #define ZYNQ_QSPI_CONFIG_MSTREN_MASK	BIT(0) /* Master Mode */
 
@@ -63,7 +62,7 @@
  */
 #define ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX	GENMASK(2, 0) /* Baud rate maximum */
 #define ZYNQ_QSPI_CONFIG_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift */
-#define ZYNQ_QSPI_CONFIG_PCS		10 /* Peripheral Chip Select */
+#define ZYNQ_QSPI_CONFIG_PCS		BIT(10) /* Peripheral Chip Select */
 
 /*
  * QSPI Interrupt Registers bit Masks
@@ -288,16 +287,12 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
 	u32 config_reg;
 
+	/* Ground the line to assert the CS */
 	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
-	if (assert) {
-		/* Select the slave */
-		config_reg &= ~ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
-		config_reg |= (((~(BIT(spi->chip_select))) <<
-				ZYNQ_QSPI_CONFIG_PCS) &
-				ZYNQ_QSPI_CONFIG_SSCTRL_MASK);
-	} else {
-		config_reg |= ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
-	}
+	if (assert)
+		config_reg &= ~ZYNQ_QSPI_CONFIG_PCS;
+	else
+		config_reg |= ZYNQ_QSPI_CONFIG_PCS;
 
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_CONFIG_OFFSET, config_reg);
 }
-- 
2.20.1
