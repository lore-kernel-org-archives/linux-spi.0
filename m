From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: pxa2xx-pci: Enable DMA for Intel Merrifield
Date: Mon,  2 Jan 2017 13:47:31 +0200
Message-ID: <20170102114731.128162-1-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI controller on Intel Merrifield is backed by DMA engine. Add necessary bits
to support it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 373c1871db15..188082cea004 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -41,6 +41,13 @@ struct pxa_spi_info {
 static struct dw_dma_slave byt_tx_param = { .dst_id = 0 };
 static struct dw_dma_slave byt_rx_param = { .src_id = 1 };
 
+static struct dw_dma_slave mrfld3_tx_param = { .dst_id = 15 };
+static struct dw_dma_slave mrfld3_rx_param = { .src_id = 14 };
+static struct dw_dma_slave mrfld5_tx_param = { .dst_id = 13 };
+static struct dw_dma_slave mrfld5_rx_param = { .src_id = 12 };
+static struct dw_dma_slave mrfld6_tx_param = { .dst_id = 11 };
+static struct dw_dma_slave mrfld6_rx_param = { .src_id = 10 };
+
 static struct dw_dma_slave bsw0_tx_param = { .dst_id = 0 };
 static struct dw_dma_slave bsw0_rx_param = { .src_id = 1 };
 static struct dw_dma_slave bsw1_tx_param = { .dst_id = 6 };
@@ -93,22 +100,39 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 
 static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 {
+	struct pci_dev *dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(21, 0));
+	struct dw_dma_slave *tx, *rx;
+
 	switch (PCI_FUNC(dev->devfn)) {
 	case 0:
 		c->port_id = 3;
 		c->num_chipselect = 1;
+		c->tx_param = &mrfld3_tx_param;
+		c->rx_param = &mrfld3_rx_param;
 		break;
 	case 1:
 		c->port_id = 5;
 		c->num_chipselect = 4;
+		c->tx_param = &mrfld5_tx_param;
+		c->rx_param = &mrfld5_rx_param;
 		break;
 	case 2:
 		c->port_id = 6;
 		c->num_chipselect = 1;
+		c->tx_param = &mrfld6_tx_param;
+		c->rx_param = &mrfld6_rx_param;
 		break;
 	default:
 		return -ENODEV;
 	}
+
+	tx = c->tx_param;
+	tx->dma_dev = &dma_dev->dev;
+
+	rx = c->rx_param;
+	rx->dma_dev = &dma_dev->dev;
+
+	c->dma_filter = lpss_dma_filter;
 	return 0;
 }
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
