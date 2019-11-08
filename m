From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 7/7] spi: zynq-qspi: Support two chip selects
Date: Fri,  8 Nov 2019 15:07:44 +0100
Message-ID: <20191108140744.1734-8-miquel.raynal@bootlin.com>
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

The Zynq QSPI controller features 2 CS. When the num-cs DT property
is set to 2, the hardware will be initialized to support having two
devices connected over each CS.

In this case, both CS lines are driven by the state of the U_PAGE
(upper page) bit. When unset, the lower page (CS0) is selected,
otherwise it is the upper page (CS1).

Change tested on a custom design featuring two SPI-NORs with different
CS on the Zynq-7000 QSPI bus.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 07d361501aa0..a041ac774331 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -115,8 +115,8 @@
  */
 #define ZYNQ_QSPI_MODEBITS			(SPI_CPOL | SPI_CPHA)
 
-/* Default number of chip selects */
-#define ZYNQ_QSPI_DEFAULT_NUM_CS	1
+/* Maximum number of chip selects */
+#define ZYNQ_QSPI_MAX_NUM_CS		2
 
 /**
  * struct zynq_qspi - Defines qspi driver instance
@@ -160,6 +160,7 @@ static inline void zynq_qspi_write(struct zynq_qspi *xqspi, u32 offset,
 /**
  * zynq_qspi_init_hw - Initialize the hardware
  * @xqspi:	Pointer to the zynq_qspi structure
+ * @num_cs:	Number of connected CS (to enable dual memories if needed)
  *
  * The default settings of the QSPI controller's configurable parameters on
  * reset are
@@ -177,7 +178,7 @@ static inline void zynq_qspi_write(struct zynq_qspi *xqspi, u32 offset,
  *	- Set the little endian mode of TX FIFO and
  *	- Enable the QSPI controller
  */
-static void zynq_qspi_init_hw(struct zynq_qspi *xqspi)
+static void zynq_qspi_init_hw(struct zynq_qspi *xqspi, unsigned int num_cs)
 {
 	u32 config_reg;
 
@@ -185,7 +186,12 @@ static void zynq_qspi_init_hw(struct zynq_qspi *xqspi)
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_IDIS_OFFSET, ZYNQ_QSPI_IXR_ALL_MASK);
 
 	/* Disable linear mode as the boot loader may have used it */
-	zynq_qspi_write(xqspi, ZYNQ_QSPI_LINEAR_CFG_OFFSET, 0);
+	config_reg = 0;
+	/* At the same time, enable dual mode if more than 1 CS is available */
+	if (num_cs > 1)
+		config_reg |= ZYNQ_QSPI_LCFG_TWO_MEM;
+
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_LINEAR_CFG_OFFSET, config_reg);
 
 	/* Clear the RX FIFO */
 	while (zynq_qspi_read(xqspi, ZYNQ_QSPI_STATUS_OFFSET) &
@@ -287,6 +293,17 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
 	u32 config_reg;
 
+	/* Select the lower (CS0) or upper (CS1) memory */
+	if (ctlr->num_chipselect > 1) {
+		config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_LINEAR_CFG_OFFSET);
+		if (!spi->chip_select)
+			config_reg &= ~ZYNQ_QSPI_LCFG_U_PAGE;
+		else
+			config_reg |= ZYNQ_QSPI_LCFG_U_PAGE;
+
+		zynq_qspi_write(xqspi, ZYNQ_QSPI_LINEAR_CFG_OFFSET, config_reg);
+	}
+
 	/* Ground the line to assert the CS */
 	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
 	if (assert)
@@ -674,9 +691,9 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(np, "num-cs",
 				   &num_cs);
 	if (ret < 0) {
-		ctlr->num_chipselect = ZYNQ_QSPI_DEFAULT_NUM_CS;
-	} else if (num_cs > ZYNQ_QSPI_DEFAULT_NUM_CS) {
-		dev_err(&pdev->dev, "anything but CS0 is not yet supported\n");
+		ctlr->num_chipselect = 1;
+	} else if (num_cs > ZYNQ_QSPI_MAX_NUM_CS) {
+		dev_err(&pdev->dev, "only 2 chip selects are available\n");
 		goto remove_master;
 	} else {
 		ctlr->num_chipselect = num_cs;
@@ -690,7 +707,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = np;
 
 	/* QSPI controller initializations */
-	zynq_qspi_init_hw(xqspi);
+	zynq_qspi_init_hw(xqspi, ctlr->num_chipselect);
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
-- 
2.20.1
