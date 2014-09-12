From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 5/6] spi: dw-mid: remove redundant dmac member
Date: Fri, 12 Sep 2014 15:12:00 +0300
Message-ID: <1410523921-16732-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1410523921-16732-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410523921-16732-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Instead of using that member we prefer to use dma_dev which represents actual
struct device of the DMA device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 12 ++++++++----
 drivers/spi/spi-dw.h     |  1 -
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index deba3c4..9ae2eaa 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -39,12 +39,13 @@ static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_spi *dws = param;
 
-	return dws->dmac && (&dws->dmac->dev == chan->device->dev);
+	return dws->dma_dev == chan->device->dev;
 }
 
 static int mid_spi_dma_init(struct dw_spi *dws)
 {
 	struct mid_dma *dw_dma = dws->dma_priv;
+	struct pci_dev *dma_dev;
 	struct intel_mid_dma_slave *rxs, *txs;
 	dma_cap_mask_t mask;
 
@@ -52,7 +53,11 @@ static int mid_spi_dma_init(struct dw_spi *dws)
 	 * Get pci device for DMA controller, currently it could only
 	 * be the DMA controller of Medfield
 	 */
-	dws->dmac = pci_get_device(PCI_VENDOR_ID_INTEL, 0x0827, NULL);
+	dma_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x0827, NULL);
+	if (!dma_dev)
+		return -ENODEV;
+
+	dws->dma_dev = &dma_dev->dev;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -81,8 +86,7 @@ static int mid_spi_dma_init(struct dw_spi *dws)
 free_rxchan:
 	dma_release_channel(dws->rxchan);
 err_exit:
-	return -1;
-
+	return -EBUSY;
 }
 
 static void mid_spi_dma_exit(struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index fcd12b6..089fc4b 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -140,7 +140,6 @@ struct dw_spi {
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	struct dw_spi_dma_ops	*dma_ops;
 	void			*dma_priv; /* platform relate info */
-	struct pci_dev		*dmac;
 
 	/* Bus interface info */
 	void			*priv;
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
