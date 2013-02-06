From: Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>
Subject: [PATCH 2/2] gpio: mcp23s08: convert driver to DT
Date: Wed,  6 Feb 2013 18:01:58 +0100
Message-ID: <1360170118-11937-3-git-send-email-larsi@wh2.tu-dresden.de>
References: <1360170118-11937-1-git-send-email-larsi@wh2.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1360170118-11937-1-git-send-email-larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>

This converts the mcp23s08 driver to be able to be used with device
tree.
There is a special "mcp,chips" property, that correspond to the chips
member of the struct mcp23s08_platform_data. It can be used for
multiple mcp23s08/mc23s17 on the same spi chipselect.

Signed-off-by: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
---
 .../devicetree/bindings/gpio/gpio-mcp23s08.txt     |   36 ++++++++
 drivers/gpio/gpio-mcp23s08.c                       |   91 +++++++++++++++++++-
 include/linux/spi/mcp23s08.h                       |    1 +
 3 files changed, 124 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mcp23s08.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mcp23s08.txt b/Documentation/devicetree/bindings/gpio/gpio-mcp23s08.txt
new file mode 100644
index 0000000..17eb669
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-mcp23s08.txt
@@ -0,0 +1,36 @@
+Microchip MCP2308/MCP23S08/MCP23017/MCP23S17 driver for
+8-/16-bit I/O expander with serial interface (I2C/SPI)
+
+Required properties:
+- compatible : Should be
+    - "mcp,mcp23s08" for  8 GPIO SPI version
+    - "mcp,mcp23s17" for 16 GPIO SPI version
+    - "mcp,mcp23008" for  8 GPIO I2C version or
+    - "mcp,mcp23017" for 16 GPIO I2C version of the chip
+- #gpio-cells : Should be two.
+  - first cell is the pin number
+  - second cell is used to specify optional parameters (currently unused)
+- gpio-controller : Marks the device node as a GPIO controller.
+- reg : For an address on its bus
+
+Optional device specific properties:
+- mcp,chips : This is a table with 2 columns and up to 8 entries. The first column
+	is a is_present flag, that makes only sense for SPI chips. Multiple
+	chips can share the same chipselect. This flag can be 0 or 1 depending
+	if there is a chip at this address or not.
+	The second column is written to the GPPU register, selecting a 100k
+	pullup resistor or not. Setting a 1 is activating the pullup.
+	For I2C chips only the first line in this table is used. Further chips
+	are registered at different addresses at the I2C bus.
+
+Example:
+gpiom1: gpio@20 {
+        compatible = "mcp,mcp23017";
+        gpio-controller;
+        #gpio-cells = <2>;
+        reg = <0x20>;
+	chips = <
+	/* is_present  pullups */
+		1	0x07	/* chip address 0 */
+	>;
+};
diff --git a/drivers/gpio/gpio-mcp23s08.c b/drivers/gpio/gpio-mcp23s08.c
index 2afb828..9c9bc1a 100644
--- a/drivers/gpio/gpio-mcp23s08.c
+++ b/drivers/gpio/gpio-mcp23s08.c
@@ -12,6 +12,8 @@
 #include <linux/spi/mcp23s08.h>
 #include <linux/slab.h>
 #include <asm/byteorder.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 /**
  * MCP types supported by driver
@@ -473,16 +475,87 @@ fail:
 
 /*----------------------------------------------------------------------*/
 
+#ifdef CONFIG_OF
+static struct of_device_id mcp23s08_of_match[] = {
+#ifdef CONFIG_SPI_MASTER
+	{
+		.compatible = "mcp,mcp23s08",
+	},
+	{
+		.compatible = "mcp,mcp23s17",
+	},
+#endif
+#if IS_ENABLED(CONFIG_I2C)
+	{
+		.compatible = "mcp,mcp23008",
+	},
+	{
+		.compatible = "mcp,mcp23017",
+	},
+#endif
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mcp23s08_of_match);
+
+static struct mcp23s08_platform_data *
+		of_get_mcp23s08_pdata(struct device *dev)
+{
+	struct mcp23s08_platform_data *pdata;
+	struct device_node *np = dev->of_node;
+	u32 chips[sizeof(pdata->chip)];
+	int ret, i, j;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->base = -1;
+
+	for (i = ARRAY_SIZE(pdata->chip) * MCP23S08_CHIP_INFO_MEMBERS;
+				i > 0; i -= MCP23S08_CHIP_INFO_MEMBERS) {
+		ret = of_property_read_u32_array(np, "mcp,chips", chips, i);
+		if (ret == -EOVERFLOW)
+			continue;
+		break;
+	}
+	if (!ret) {
+		for (j = 0; j < i / MCP23S08_CHIP_INFO_MEMBERS ; j++) {
+			pdata->chip[j].is_present =
+				chips[j * MCP23S08_CHIP_INFO_MEMBERS];
+			pdata->chip[j].pullups =
+				chips[j * MCP23S08_CHIP_INFO_MEMBERS + 1];
+		}
+	}
+
+	return pdata;
+}
+#else
+static struct mcp23s08_platform_data *
+		of_get_mcp23s08_pdata(struct i2c_client *client, int *chip_id)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
+
 #if IS_ENABLED(CONFIG_I2C)
 
 static int mcp230xx_probe(struct i2c_client *client,
 				    const struct i2c_device_id *id)
 {
-	struct mcp23s08_platform_data *pdata;
+	struct mcp23s08_platform_data *pdata = NULL;
 	struct mcp23s08 *mcp;
 	int status;
+	const struct of_device_id *match;
+
+	match = of_match_device(of_match_ptr(mcp23s08_of_match), &client->dev);
+	if (match)
+		pdata = of_get_mcp23s08_pdata(&client->dev);
+
+	/* if there was no pdata in DT, take it the legacy way */
+	if (!pdata)
+		pdata = client->dev.platform_data;
 
-	pdata = client->dev.platform_data;
 	if ((!pdata || !gpio_is_valid(pdata->base)) && pdata->base != -1) {
 		dev_dbg(&client->dev, "invalid or missing platform data\n");
 		return -EINVAL;
@@ -531,6 +604,7 @@ static struct i2c_driver mcp230xx_driver = {
 	.driver = {
 		.name	= "mcp230xx",
 		.owner	= THIS_MODULE,
+		.of_match_table = mcp23s08_of_match,
 	},
 	.probe		= mcp230xx_probe,
 	.remove		= mcp230xx_remove,
@@ -560,16 +634,24 @@ static void mcp23s08_i2c_exit(void) { }
 
 static int mcp23s08_probe(struct spi_device *spi)
 {
-	struct mcp23s08_platform_data	*pdata;
+	struct mcp23s08_platform_data	*pdata = NULL;
 	unsigned			addr;
 	unsigned			chips = 0;
 	struct mcp23s08_driver_data	*data;
 	int				status, type;
 	unsigned			base;
+	const struct			of_device_id *match;
 
 	type = spi_get_device_id(spi)->driver_data;
 
-	pdata = spi->dev.platform_data;
+	match = of_match_device(of_match_ptr(mcp23s08_of_match), &spi->dev);
+	if (match)
+		pdata = of_get_mcp23s08_pdata(&spi->dev);
+
+	/* if there was no pdata in DT, take it the legacy way */
+	if (!pdata)
+		pdata = spi->dev.platform_data;
+
 	if ((!pdata || !gpio_is_valid(pdata->base)) && pdata->base != -1) {
 		dev_dbg(&spi->dev, "invalid or missing platform data\n");
 		return -EINVAL;
@@ -668,6 +750,7 @@ static struct spi_driver mcp23s08_driver = {
 	.driver = {
 		.name	= "mcp23s08",
 		.owner	= THIS_MODULE,
+		.of_match_table = mcp23s08_of_match,
 	},
 };
 
diff --git a/include/linux/spi/mcp23s08.h b/include/linux/spi/mcp23s08.h
index 2d676d5..3969e12 100644
--- a/include/linux/spi/mcp23s08.h
+++ b/include/linux/spi/mcp23s08.h
@@ -1,3 +1,4 @@
+#define MCP23S08_CHIP_INFO_MEMBERS	2
 
 /* FIXME driver should be able to handle IRQs...  */
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
