From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1] spi: dw-pci: describe Intel MID controllers better
Date: Wed,  7 Jan 2015 17:15:00 +0200
Message-ID: <1420643700-23059-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There are more that one SPI controller on the Intel MID boards. This patch
describes the status and IDs of them. From now on we also have to care about
bus number that must be unique per host.

According to the specification the SPI1 has 5 bits for chip selects and SPI2
only 2 bits. The patch makes it depend to PCI ID.

The first controller (SPI1) is DMA capable, meanwhile SPI2 can share same
channels (via software switch) such functionality is not in the scope of this
patch. Thus, attempt to init DMA for SPI2 will always fail for now.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 arch/x86/pci/intel_mid_pci.c |  1 -
 drivers/spi/spi-dw-mid.c     |  2 --
 drivers/spi/spi-dw-pci.c     | 38 ++++++++++++++++++++++++++++++--------
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 44b9271..852aa4c 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -293,7 +293,6 @@ static void mrst_power_off_unused_dev(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0801, mrst_power_off_unused_dev);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0809, mrst_power_off_unused_dev);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x080C, mrst_power_off_unused_dev);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0812, mrst_power_off_unused_dev);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0815, mrst_power_off_unused_dev);
 
 /*
diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index a67d37c..47a8e65 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -270,8 +270,6 @@ int dw_spi_mid_init(struct dw_spi *dws)
 	dws->max_freq = MRST_SPI_CLK_BASE / (clk_cdiv + 1);
 	iounmap(clk_reg);
 
-	dws->num_cs = 16;
-
 #ifdef CONFIG_SPI_DW_MID_DMA
 	dws->dma_priv = kzalloc(sizeof(struct mid_dma), GFP_KERNEL);
 	if (!dws->dma_priv)
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index ba68da1..64f3efa 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -30,10 +30,20 @@ struct dw_spi_pci {
 
 struct spi_pci_desc {
 	int	(*setup)(struct dw_spi *);
+	u16	num_cs;
+	u16	bus_num;
 };
 
-static struct spi_pci_desc spi_pci_mid_desc = {
+static struct spi_pci_desc spi_pci_mid_desc_1 = {
 	.setup = dw_spi_mid_init,
+	.num_cs = 32,
+	.bus_num = 0,
+};
+
+static struct spi_pci_desc spi_pci_mid_desc_2 = {
+	.setup = dw_spi_mid_init,
+	.num_cs = 4,
+	.bus_num = 1,
 };
 
 static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -65,18 +75,23 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dws->regs = pcim_iomap_table(pdev)[pci_bar];
 
-	dws->bus_num = 0;
-	dws->num_cs = 4;
 	dws->irq = pdev->irq;
 
 	/*
 	 * Specific handling for paltforms, like dma setup,
 	 * clock rate, FIFO depth.
 	 */
-	if (desc && desc->setup) {
-		ret = desc->setup(dws);
-		if (ret)
-			return ret;
+	if (desc) {
+		if (desc->setup) {
+			ret = desc->setup(dws);
+			if (ret)
+				return ret;
+		}
+
+		dws->num_cs = desc->num_cs;
+		dws->bus_num = desc->bus_num;
+	} else {
+		return -ENODEV;
 	}
 
 	ret = dw_spi_add_host(&pdev->dev, dws);
@@ -121,7 +136,14 @@ static SIMPLE_DEV_PM_OPS(dw_spi_pm_ops, spi_suspend, spi_resume);
 
 static const struct pci_device_id pci_ids[] = {
 	/* Intel MID platform SPI controller 0 */
-	{ PCI_VDEVICE(INTEL, 0x0800), (kernel_ulong_t)&spi_pci_mid_desc},
+	/*
+	 * The access to the device 8086:0801 is disabled by HW, since it's
+	 * exclusively used by SCU to communicate with MSIC.
+	 */
+	/* Intel MID platform SPI controller 1 */
+	{ PCI_VDEVICE(INTEL, 0x0800), (kernel_ulong_t)&spi_pci_mid_desc_1},
+	/* Intel MID platform SPI controller 2 */
+	{ PCI_VDEVICE(INTEL, 0x0812), (kernel_ulong_t)&spi_pci_mid_desc_2},
 	{},
 };
 
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
