From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: dw-mid: don't leak memory on exit
Date: Thu, 28 Aug 2014 11:53:17 +0300
Message-ID: <1409215997-26085-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	<stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When built with DMA support the memory for an internal structure is allocated
but not freed. Converting to devm_kzalloc solves the issue.

Fixes: 7063c0d942a1 (spi/dw_spi: add DMA support)
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v2.6.38+
---
 drivers/spi/spi-dw-mid.c | 4 ++--
 drivers/spi/spi-dw-pci.c | 5 ++---
 drivers/spi/spi-dw.h     | 3 ++-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index c79bf96..ceb95b4 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -202,7 +202,7 @@ static struct dw_spi_dma_ops mid_dma_ops = {
 #define CLK_SPI_CDIV_MASK	0x00000e00
 #define CLK_SPI_DISABLE_OFFSET	8
 
-int dw_spi_mid_init(struct dw_spi *dws)
+int dw_spi_mid_init(struct device *dev, struct dw_spi *dws)
 {
 	void __iomem *clk_reg;
 	u32 clk_cdiv;
@@ -220,7 +220,7 @@ int dw_spi_mid_init(struct dw_spi *dws)
 	dws->fifo_len = 40;	/* FIFO has 40 words buffer */
 
 #ifdef CONFIG_SPI_DW_MID_DMA
-	dws->dma_priv = kzalloc(sizeof(struct mid_dma), GFP_KERNEL);
+	dws->dma_priv = devm_kzalloc(dev, sizeof(struct mid_dma), GFP_KERNEL);
 	if (!dws->dma_priv)
 		return -ENOMEM;
 	dws->dma_ops = &mid_dma_ops;
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index b8b02d7..dd06c07 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -28,8 +28,7 @@ struct dw_spi_pci {
 	struct dw_spi	dws;
 };
 
-static int spi_pci_probe(struct pci_dev *pdev,
-	const struct pci_device_id *ent)
+static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct dw_spi_pci *dwpci;
 	struct dw_spi *dws;
@@ -66,7 +65,7 @@ static int spi_pci_probe(struct pci_dev *pdev,
 	 * clock rate, FIFO depth.
 	 */
 	if (pdev->device == 0x0800) {
-		ret = dw_spi_mid_init(dws);
+		ret = dw_spi_mid_init(&pdev->dev, dws);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 0f8cece..b3ff9eb 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -232,5 +232,6 @@ extern int dw_spi_resume_host(struct dw_spi *dws);
 extern void dw_spi_xfer_done(struct dw_spi *dws);
 
 /* platform related setup */
-extern int dw_spi_mid_init(struct dw_spi *dws); /* Intel MID platforms */
+/* Intel MID platforms */
+extern int dw_spi_mid_init(struct device *dev, struct dw_spi *dws);
 #endif /* DW_SPI_HEADER_H */
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
