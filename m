From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/4] spi: pxa2xx-pci: Do a specific setup in a separate function
Date: Mon,  4 Jul 2016 12:44:24 +0300
Message-ID: <1467625467-103785-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1467625467-103785-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467625467-103785-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Move LPSS specific setup to a separate function. It makes ->probe() cleaner as
well as allows extend the driver for different variation of hardware in the
future, e.g. for Intel Merrifield.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 77 +++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 5202de9..8d58598 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -29,8 +29,11 @@ struct pxa_spi_info {
 	unsigned long max_clk_rate;
 
 	/* DMA channel request parameters */
+	bool (*dma_filter)(struct dma_chan *chan, void *param);
 	void *tx_param;
 	void *rx_param;
+
+	int (*setup)(struct pci_dev *pdev, struct pxa_spi_info *c);
 };
 
 static struct dw_dma_slave byt_tx_param = { .dst_id = 0 };
@@ -57,6 +60,35 @@ static bool lpss_dma_filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
+static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
+{
+	struct pci_dev *dma_dev;
+
+	c->num_chipselect = 1;
+	c->max_clk_rate = 50000000;
+
+	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+
+	if (c->tx_param) {
+		struct dw_dma_slave *slave = c->tx_param;
+
+		slave->dma_dev = &dma_dev->dev;
+		slave->m_master = 0;
+		slave->p_master = 1;
+	}
+
+	if (c->rx_param) {
+		struct dw_dma_slave *slave = c->rx_param;
+
+		slave->dma_dev = &dma_dev->dev;
+		slave->m_master = 0;
+		slave->p_master = 1;
+	}
+
+	c->dma_filter = lpss_dma_filter;
+	return 0;
+}
+
 static struct pxa_spi_info spi_info_configs[] = {
 	[PORT_CE4100] = {
 		.type = PXA25x_SSP,
@@ -67,32 +99,28 @@ static struct pxa_spi_info spi_info_configs[] = {
 	[PORT_BYT] = {
 		.type = LPSS_BYT_SSP,
 		.port_id = 0,
-		.num_chipselect = 1,
-		.max_clk_rate = 50000000,
+		.setup = lpss_spi_setup,
 		.tx_param = &byt_tx_param,
 		.rx_param = &byt_rx_param,
 	},
 	[PORT_BSW0] = {
 		.type = LPSS_BYT_SSP,
 		.port_id = 0,
-		.num_chipselect = 1,
-		.max_clk_rate = 50000000,
+		.setup = lpss_spi_setup,
 		.tx_param = &bsw0_tx_param,
 		.rx_param = &bsw0_rx_param,
 	},
 	[PORT_BSW1] = {
 		.type = LPSS_BYT_SSP,
 		.port_id = 1,
-		.num_chipselect = 1,
-		.max_clk_rate = 50000000,
+		.setup = lpss_spi_setup,
 		.tx_param = &bsw1_tx_param,
 		.rx_param = &bsw1_rx_param,
 	},
 	[PORT_BSW2] = {
 		.type = LPSS_BYT_SSP,
 		.port_id = 2,
-		.num_chipselect = 1,
-		.max_clk_rate = 50000000,
+		.setup = lpss_spi_setup,
 		.tx_param = &bsw2_tx_param,
 		.rx_param = &bsw2_rx_param,
 	},
@@ -105,8 +133,7 @@ static struct pxa_spi_info spi_info_configs[] = {
 	[PORT_LPT] = {
 		.type = LPSS_LPT_SSP,
 		.port_id = 0,
-		.num_chipselect = 1,
-		.max_clk_rate = 50000000,
+		.setup = lpss_spi_setup,
 		.tx_param = &lpt_tx_param,
 		.rx_param = &lpt_rx_param,
 	},
@@ -122,7 +149,6 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	struct ssp_device *ssp;
 	struct pxa_spi_info *c;
 	char buf[40];
-	struct pci_dev *dma_dev;
 
 	ret = pcim_enable_device(dev);
 	if (ret)
@@ -133,30 +159,15 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		return ret;
 
 	c = &spi_info_configs[ent->driver_data];
-
-	memset(&spi_pdata, 0, sizeof(spi_pdata));
-	spi_pdata.num_chipselect = (c->num_chipselect > 0) ?
-					c->num_chipselect : dev->devfn;
-
-	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
-
-	if (c->tx_param) {
-		struct dw_dma_slave *slave = c->tx_param;
-
-		slave->dma_dev = &dma_dev->dev;
-		slave->m_master = 0;
-		slave->p_master = 1;
-	}
-
-	if (c->rx_param) {
-		struct dw_dma_slave *slave = c->rx_param;
-
-		slave->dma_dev = &dma_dev->dev;
-		slave->m_master = 0;
-		slave->p_master = 1;
+	if (c->setup) {
+		ret = c->setup(dev, c);
+		if (ret)
+			return ret;
 	}
 
-	spi_pdata.dma_filter = lpss_dma_filter;
+	memset(&spi_pdata, 0, sizeof(spi_pdata));
+	spi_pdata.num_chipselect = (c->num_chipselect > 0) ? c->num_chipselect : dev->devfn;
+	spi_pdata.dma_filter = c->dma_filter;
 	spi_pdata.tx_param = c->tx_param;
 	spi_pdata.rx_param = c->rx_param;
 	spi_pdata.enable_dma = c->rx_param && c->tx_param;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
