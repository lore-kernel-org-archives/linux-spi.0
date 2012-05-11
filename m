From: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] eeprom/of: Add device tree bindings to at25.
Date: Fri, 11 May 2012 15:05:23 -0700
Message-ID: <1336773923-17866-4-git-send-email-ddaney.cavm@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1336773923-17866-1-git-send-email-ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

We can extract the "pagesize", "size" and "address-width" from the
device tree so that SPI eeproms can be fully specified in the device
tree.

Also add a MODULE_DEVICE_TABLE so the drivers can be automatically bound.

Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/misc/eeprom/at25.c |   61 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 01ab3c9..609ee72 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/sched.h>
+#include <linux/of.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
@@ -293,6 +294,9 @@ static int at25_probe(struct spi_device *spi)
 {
 	struct at25_data	*at25 = NULL;
 	const struct spi_eeprom *chip;
+#ifdef CONFIG_OF
+	struct spi_eeprom of_chip;
+#endif
 	int			err;
 	int			sr;
 	int			addrlen;
@@ -300,9 +304,51 @@ static int at25_probe(struct spi_device *spi)
 	/* Chip description */
 	chip = spi->dev.platform_data;
 	if (!chip) {
-		dev_dbg(&spi->dev, "no chip description\n");
-		err = -ENODEV;
-		goto fail;
+#ifdef CONFIG_OF
+		if (spi->dev.of_node) {
+			u32 val;
+			memset(&of_chip, 0, sizeof(of_chip));
+			if (of_property_read_u32(spi->dev.of_node, "pagesize", &val)) {
+				dev_dbg(&spi->dev, "no \"pagesize\" property\n");
+				err = -ENODEV;
+				goto fail;
+			}
+			of_chip.page_size = val;
+			if (of_property_read_u32(spi->dev.of_node, "size", &val)) {
+				dev_dbg(&spi->dev, "no \"size\" property\n");
+				err = -ENODEV;
+				goto fail;
+			}
+			of_chip.byte_len = val;
+			if (of_property_read_u32(spi->dev.of_node, "address-width", &val)) {
+				dev_dbg(&spi->dev, "no \"address-width\" property\n");
+				err = -ENODEV;
+				goto fail;
+			}
+			switch (val) {
+			case 8:
+				of_chip.flags |= EE_ADDR1;
+				break;
+			case 16:
+				of_chip.flags |= EE_ADDR2;
+				break;
+			case 24:
+				of_chip.flags |= EE_ADDR3;
+				break;
+			default:
+				dev_dbg(&spi->dev, "bad \"address-width\" property: %u\n", val);
+				err = -EINVAL;
+				goto fail;
+			}
+			strlcpy(of_chip.name, spi->dev.of_node->name, sizeof(of_chip.name));
+			chip = &of_chip;
+		} else
+#endif
+		{
+			dev_dbg(&spi->dev, "no chip description\n");
+			err = -ENODEV;
+			goto fail;
+		}
 	}
 
 	/* For now we only support 8/16/24 bit addressing */
@@ -396,11 +442,19 @@ static int __devexit at25_remove(struct spi_device *spi)
 
 /*-------------------------------------------------------------------------*/
 
+static const struct spi_device_id at25_id[] = {
+	{"at25", 0},
+	{"m95256", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, at25_id);
+
 static struct spi_driver at25_driver = {
 	.driver = {
 		.name		= "at25",
 		.owner		= THIS_MODULE,
 	},
+	.id_table	= at25_id,
 	.probe		= at25_probe,
 	.remove		= __devexit_p(at25_remove),
 };
@@ -410,4 +464,3 @@ module_spi_driver(at25_driver);
 MODULE_DESCRIPTION("Driver for most SPI EEPROMs");
 MODULE_AUTHOR("David Brownell");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:at25");
-- 
1.7.2.3


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
