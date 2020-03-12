From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 7/7] spi: dw: Add support for Intel Keem Bay SPI
Date: Thu, 12 Mar 2020 19:31:29 +0800
Message-ID: <20200312113129.8198-8-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add support for Intel Keem Bay SPI controller, which uses DesignWare
DWC_ssi core. Bit 31 of CTRLR0 register is added for Keem Bay, to
configure the device as a master or as a slave serial peripheral.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mmio.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 1df6f3deee2c..abd3bb5e52db 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -44,6 +44,13 @@ struct dw_spi_mmio {
 #define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE	BIT(13)
 #define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)	(x << 5)
 
+/*
+ * For Keem Bay, CTRLR0[31] is used to select controller mode.
+ * 0: SSI is slave
+ * 1: SSI is master
+ */
+#define KEEMBAY_CTRLR0_SSIC_IS_MST		BIT(31)
+
 struct dw_spi_mscc {
 	struct regmap       *syscon;
 	void __iomem        *spi_mst;
@@ -155,6 +162,24 @@ static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
 	return 0;
 }
 
+static u32 dw_spi_update_cr0_keembay(struct spi_controller *master,
+				     struct spi_device *spi,
+				     struct spi_transfer *transfer)
+{
+	u32 cr0 = dw_spi_update_cr0_v1_01a(master, spi, transfer);
+
+	return cr0 | KEEMBAY_CTRLR0_SSIC_IS_MST;
+}
+
+static int dw_spi_keembay_init(struct platform_device *pdev,
+			       struct dw_spi_mmio *dwsmmio)
+{
+	/* Register hook to configure CTRLR0 */
+	dwsmmio->dws.update_cr0 = dw_spi_update_cr0_keembay;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -254,6 +279,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
+	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.17.1
