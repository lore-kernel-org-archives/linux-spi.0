From: P L Sai Krishna <lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [LINUX PATCH v2 3/3] spi:zynqmp:gqspi: Added separate dummy entry.
Date: Thu, 7 Apr 2016 20:09:29 +0530
Message-ID: <1460039969-9835-3-git-send-email-lakshmis@xilinx.com>
References: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Harini Katakam" <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	P L Sai Krishna <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"Brian Norris" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Javier Martinez Canillas" <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460039969-9835-1-git-send-email-lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch sends dummy as a separate entry.
Break the Address+Cmd+dummy transfer into multiple transfers.
Address+Cmd as one transfer.
Dummy cycles as another transfer.
As per the controller spec, immediate data field of dummy entry
in the GenFifo represent dummy cycles.
Bus width for dummy cycles transfer should be same as
Rx bus width.

Signed-off-by: P L Sai Krishna <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
v2:
 - Replaced dummy with dummy_cycles.
 
 drivers/spi/spi-zynqmp-gqspi.c | 57 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index aab9b49..a4b109e 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -134,6 +134,9 @@
 #define GQSPI_SELECT_MODE_QUADSPI	0x4
 #define GQSPI_DMA_UNALIGN		0x3
 #define GQSPI_DEFAULT_NUM_CS	1	/* Default number of chip selects */
+#define GQSPI_RX_BUS_WIDTH_QUAD		0x4
+#define GQSPI_RX_BUS_WIDTH_DUAL		0x2
+#define GQSPI_RX_BUS_WIDTH_SINGLE	0x1
 
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
@@ -169,6 +172,7 @@ struct zynqmp_qspi {
 	u32 genfifobus;
 	u32 dma_rx_bytes;
 	dma_addr_t dma_addr;
+	u32 rx_bus_width;
 	u32 genfifoentry;
 	enum mode_type mode;
 };
@@ -541,6 +545,35 @@ static void zynqmp_qspi_filltxfifo(struct zynqmp_qspi *xqspi, int size)
 }
 
 /**
+ * zynqmp_qspi_preparedummy:	Prepares the dummy entry
+ *
+ * @xqspi:	Pointer to the zynqmp_qspi structure
+ * @transfer:	It is a pointer to the structure containing transfer data.
+ * @genfifoentry:	genfifoentry is pointer to the variable in which
+ *			GENFIFO	mask is returned to calling function
+ */
+static void zynqmp_qspi_preparedummy(struct zynqmp_qspi *xqspi,
+					struct spi_transfer *transfer,
+					u32 *genfifoentry)
+{
+	/* For dummy Tx and Rx are NULL */
+	*genfifoentry &= ~(GQSPI_GENFIFO_TX | GQSPI_GENFIFO_RX);
+
+	/* SPI mode */
+	*genfifoentry &= ~GQSPI_GENFIFO_MODE_QUADSPI;
+	if (xqspi->rx_bus_width == GQSPI_RX_BUS_WIDTH_QUAD)
+		*genfifoentry |= GQSPI_GENFIFO_MODE_QUADSPI;
+	else if (xqspi->rx_bus_width == GQSPI_RX_BUS_WIDTH_DUAL)
+		*genfifoentry |= GQSPI_GENFIFO_MODE_DUALSPI;
+	else
+		*genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
+
+	/* Immediate data */
+	*genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
+	*genfifoentry |= transfer->dummy_cycles;
+}
+
+/**
  * zynqmp_qspi_readrxfifo:	Fills the RX FIFO as long as there is room in
  *				the FIFO.
  * @xqspi:	Pointer to the zynqmp_qspi structure
@@ -771,7 +804,7 @@ static void zynqmp_qspi_txrxsetup(struct zynqmp_qspi *xqspi,
 		*genfifoentry |= GQSPI_GENFIFO_TX;
 		*genfifoentry |=
 			zynqmp_qspi_selectspimode(xqspi, transfer->tx_nbits);
-		xqspi->bytes_to_transfer = transfer->len;
+		xqspi->bytes_to_transfer = transfer->len - (transfer->dummy_cycles/8);
 		if (xqspi->mode == GQSPI_MODE_DMA) {
 			config_reg = zynqmp_gqspi_read(xqspi,
 							GQSPI_CONFIG_OFST);
@@ -832,13 +865,19 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
 	if (xqspi->mode == GQSPI_MODE_DMA)
 		transfer_len = xqspi->dma_rx_bytes;
 	else
-		transfer_len = transfer->len;
+		transfer_len = transfer->len - (transfer->dummy_cycles/8);
 
 	xqspi->genfifoentry = genfifoentry;
 	if ((transfer_len) < GQSPI_GENFIFO_IMM_DATA_MASK) {
 		genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
 		genfifoentry |= transfer_len;
 		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
+		if (transfer->dummy_cycles) {
+			zynqmp_qspi_preparedummy(xqspi, transfer,
+					&genfifoentry);
+			zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST,
+					genfifoentry);
+		}
 	} else {
 		int tempcount = transfer_len;
 		u32 exponent = 8;	/* 2^8 = 256 */
@@ -979,6 +1018,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	struct zynqmp_qspi *xqspi;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
+	struct device_node *nc;
+	u32 rx_bus_width;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
 	if (!master)
@@ -1039,6 +1080,18 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	xqspi->rx_bus_width = GQSPI_RX_BUS_WIDTH_SINGLE;
+	for_each_available_child_of_node(pdev->dev.of_node, nc) {
+		ret = of_property_read_u32(nc, "spi-rx-bus-width",
+					&rx_bus_width);
+		if (!ret) {
+			xqspi->rx_bus_width = rx_bus_width;
+			break;
+		}
+	}
+	if (ret)
+		dev_err(dev, "rx bus width not found\n");
+
 	master->num_chipselect = GQSPI_DEFAULT_NUM_CS;
 
 	master->setup = zynqmp_qspi_setup;
-- 
2.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
