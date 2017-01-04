From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx-pci: Enable DMA for Intel Merrifield" to the spi tree
Date: Wed, 04 Jan 2017 18:37:15 +0000
Message-ID: <E1cOqR1-000208-Cl@debutante>
References: <20170102114731.128162-1-andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170102114731.128162-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx-pci: Enable DMA for Intel Merrifield

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 25014521603f70225c1e6fa232839614f7b4f692 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 2 Jan 2017 13:47:31 +0200
Subject: [PATCH] spi: pxa2xx-pci: Enable DMA for Intel Merrifield

SPI controller on Intel Merrifield is backed by DMA engine. Add necessary bits
to support it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 58d2d48e16a5..868452d8e3e1 100644
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
