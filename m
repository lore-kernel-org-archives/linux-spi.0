From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi: davinci: add OF support for the spi controller
Date: Mon, 12 Nov 2012 16:28:22 -0500
Message-ID: <1352755702-21488-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
 <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
 <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
 <linux-keystone-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

This adds OF support to DaVinci SPI controller to configure platform
data through device bindings.

Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-davinci.txt        |   50 ++++++++++++
 drivers/spi/spi-davinci.c                          |   80 +++++++++++++++++++-
 2 files changed, 126 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
new file mode 100644
index 0000000..0369369
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -0,0 +1,50 @@
+Davinci SPI controller device bindings
+
+Required properties:
+- #address-cells: number of cells required to define a chip select
+	address on the SPI bus.
+- #size-cells: should be zero.
+- compatible:
+	- "ti,davinci-spi"
+- reg: Offset and length of SPI controller register space
+- ti,davinci-spi-version: SPI version :- "1.0" or "2.0"
+- ti,davinci-spi-num-cs: Number of chip selects
+- ti,davinci-spi-intr-line: interrupt line used to connect the SPI
+	IP to the ARM interrupt controller withn the SoC. Possible values
+	are 0 and 1.
+- interrupts: interrupt number offset at the irq parent
+- clocks: spi clk phandle
+
+Example of a NOR flash slave device (n25q032) connected to DaVinci
+SPI controller device over the SPI bus.
+
+spi:spi0@20BF0000 {
+	#address-cells			= <1>;
+	#size-cells			= <0>;
+	compatible			= "ti,davinci-spi";
+	reg				= <0x20BF0000 0x1000>;
+	ti,davinci-spi-version		= "1.0";
+	ti,davinci-spi-num-cs		= <4>;
+	ti,davinci-spi-intr-line	= <0>;
+	interrupts			= <338>;
+	clocks				= <&clkspi>;
+
+	flash: n25q032@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p32";
+		spi-max-frequency = <25000000>;
+		reg = <0>;
+
+		partition@0 {
+			label = "u-boot-spl";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition@1 {
+			label = "test";
+			reg = <0x80000 0x380000>;
+		};
+	};
+};
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 71a6423..0f50319 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -26,6 +26,9 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/slab.h>
@@ -788,6 +791,69 @@ rx_dma_failed:
 	return r;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id davinci_spi_of_match[] = {
+	{
+		.compatible = "ti,davinci-spi",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, davini_spi_of_match);
+
+/**
+ * spi_davinci_get_pdata - Get platform_data from DTS binding
+ * @pdev: ptr to platform data
+ *
+ * Parses and populate platform_data from device tree bindings.
+ *
+ * NOTE: Not all platform_data params are supported currently.
+ */
+static struct davinci_spi_platform_data
+	*spi_davinci_get_pdata(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct davinci_spi_platform_data *pdata;
+	unsigned int num_cs, intr_line = 0;
+	const char *version;
+
+	if (pdev->dev.platform_data)
+		return pdev->dev.platform_data;
+
+	if (!pdev->dev.of_node)
+		return NULL;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	pdev->dev.platform_data = pdata;
+	if (!pdata)
+		return NULL;
+
+	/* default version is 1.0 */
+	pdata->version = SPI_VERSION_1;
+	of_property_read_string(node, "ti,davinci-spi-version", &version);
+	if (!strcmp(version, "2.0"))
+		pdata->version = SPI_VERSION_2;
+
+	/*
+	 * default num_cs is 1 and all chipsel are internal to the chip
+	 * indicated by chip_sel being NULL. GPIO based CS is not
+	 * supported yet in DT bindings.
+	 */
+	num_cs = 1;
+	of_property_read_u32(node, "ti,davinci-spi-num-cs", &num_cs);
+	pdata->num_chipselect = num_cs;
+	of_property_read_u32(node, "ti,davinci-spi-intr-line", &intr_line);
+	pdata->intr_line = intr_line;
+	return pdev->dev.platform_data;
+}
+#else
+#define davinci_spi_of_match NULL
+static struct davinci_spi_platform_data
+	*spi_davinci_get_pdata(struct platform_device *pdev)
+{
+	return pdev->dev.platform_data;
+}
+#endif
+
 /**
  * davinci_spi_probe - probe function for SPI Master Controller
  * @pdev: platform_device structure which contains plateform specific data
@@ -801,16 +867,16 @@ rx_dma_failed:
  */
 static int __devinit davinci_spi_probe(struct platform_device *pdev)
 {
+	resource_size_t dma_rx_chan = SPI_NO_RESOURCE;
+	resource_size_t	dma_tx_chan = SPI_NO_RESOURCE;
+	struct davinci_spi_platform_data *pdata;
 	struct spi_master *master;
 	struct davinci_spi *dspi;
-	struct davinci_spi_platform_data *pdata;
 	struct resource *r, *mem;
-	resource_size_t dma_rx_chan = SPI_NO_RESOURCE;
-	resource_size_t	dma_tx_chan = SPI_NO_RESOURCE;
 	int i = 0, ret = 0;
 	u32 spipc0;
 
-	pdata = pdev->dev.platform_data;
+	pdata = spi_davinci_get_pdata(pdev);
 	if (pdata == NULL) {
 		ret = -ENODEV;
 		goto err;
@@ -851,7 +917,11 @@ static int __devinit davinci_spi_probe(struct platform_device *pdev)
 		goto release_region;
 	}
 
+	/* first get irq through resource table, else try of irq method */
 	dspi->irq = platform_get_irq(pdev, 0);
+	if (dspi->irq <= 0)
+		dspi->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+
 	if (dspi->irq <= 0) {
 		ret = -EINVAL;
 		goto unmap_io;
@@ -875,6 +945,7 @@ static int __devinit davinci_spi_probe(struct platform_device *pdev)
 	}
 	clk_prepare_enable(dspi->clk);
 
+	master->dev.of_node = pdev->dev.of_node;
 	master->bus_num = pdev->id;
 	master->num_chipselect = pdata->num_chipselect;
 	master->setup = davinci_spi_setup;
@@ -1010,6 +1081,7 @@ static struct platform_driver davinci_spi_driver = {
 	.driver = {
 		.name = "spi_davinci",
 		.owner = THIS_MODULE,
+		.of_match_table = davinci_spi_of_match,
 	},
 	.probe = davinci_spi_probe,
 	.remove = __devexit_p(davinci_spi_remove),
-- 
1.7.9.5
