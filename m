From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1] spi: dw-mid: get a proper clock frequency for SPI2
Date: Thu, 22 Jan 2015 17:59:34 +0200
Message-ID: <1421942374-18083-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The clock information is being kept in the custom register on Intel MID
platforms. Each controller has its own dedicated custom register for that.
Thus, to get a proper frequency we have to read value from the specific offset
to the register block. This patch makes this happen.

Fixes: d58cf5ff6500 (spi: dw-pci: describe Intel MID controllers better)
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

Mark, this is material for 3.19-rcX since I introduced the SPI2 just in
3.19-rc1.

 drivers/spi/spi-dw-mid.c | 13 ++++++++-----
 drivers/spi/spi-dw-pci.c |  6 +++---
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 47a8e65..a0197fd 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -247,9 +247,9 @@ static struct dw_spi_dma_ops mid_dma_ops = {
 
 /* Some specific info for SPI0 controller on Intel MID */
 
-/* HW info for MRST CLk Control Unit, one 32b reg */
+/* HW info for MRST Clk Control Unit, 32b reg per controller */
 #define MRST_SPI_CLK_BASE	100000000	/* 100m */
-#define MRST_CLK_SPI0_REG	0xff11d86c
+#define MRST_CLK_SPI_REG	0xff11d86c
 #define CLK_SPI_BDIV_OFFSET	0
 #define CLK_SPI_BDIV_MASK	0x00000007
 #define CLK_SPI_CDIV_OFFSET	9
@@ -261,13 +261,16 @@ int dw_spi_mid_init(struct dw_spi *dws)
 	void __iomem *clk_reg;
 	u32 clk_cdiv;
 
-	clk_reg = ioremap_nocache(MRST_CLK_SPI0_REG, 16);
+	clk_reg = ioremap_nocache(MRST_CLK_SPI_REG, 16);
 	if (!clk_reg)
 		return -ENOMEM;
 
-	/* get SPI controller operating freq info */
-	clk_cdiv  = (readl(clk_reg) & CLK_SPI_CDIV_MASK) >> CLK_SPI_CDIV_OFFSET;
+	/* Get SPI controller operating freq info */
+	clk_cdiv = readl(clk_reg + dws->bus_num * sizeof(u32));
+	clk_cdiv &= CLK_SPI_CDIV_MASK;
+	clk_cdiv >>= CLK_SPI_CDIV_OFFSET;
 	dws->max_freq = MRST_SPI_CLK_BASE / (clk_cdiv + 1);
+
 	iounmap(clk_reg);
 
 #ifdef CONFIG_SPI_DW_MID_DMA
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 64f3efa..5ba3310 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -82,14 +82,14 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * clock rate, FIFO depth.
 	 */
 	if (desc) {
+		dws->num_cs = desc->num_cs;
+		dws->bus_num = desc->bus_num;
+
 		if (desc->setup) {
 			ret = desc->setup(dws);
 			if (ret)
 				return ret;
 		}
-
-		dws->num_cs = desc->num_cs;
-		dws->bus_num = desc->bus_num;
 	} else {
 		return -ENODEV;
 	}
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
