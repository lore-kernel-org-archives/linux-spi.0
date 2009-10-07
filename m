From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: [PATCH] drivers/misc: add driver for Texas
	Instruments DAC7512
Date: Thu,  8 Oct 2009 04:01:05 +0800
Message-ID: <1254945665-28053-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is actually too trivial to publish, but to export the function of
that chip to the userspace, a module like this is needed.

Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
---
 drivers/misc/Kconfig      |   10 ++++
 drivers/misc/Makefile     |    1 +
 drivers/misc/ti_dac7512.c |  102 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/ti_dac7512.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index df1f86b..1191446 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -246,6 +246,16 @@ config EP93XX_PWM
 	  To compile this driver as a module, choose M here: the module will
 	  be called ep93xx_pwm.
 
+config TI_DAC7512
+	tristate "Texas Instruments DAC7512"
+	depends on SPI && SYSFS
+	help
+	  If you say yes here you get support for the Texas Instruments
+	  DAC7512 16-bit digital-to-analog converter.
+
+	  This driver can also be built as a module. If so, the module
+	  will be calles ti_dac7512.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f982d2e..d59830e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
 obj-$(CONFIG_HP_ILO)		+= hpilo.o
 obj-$(CONFIG_ISL29003)		+= isl29003.o
 obj-$(CONFIG_EP93XX_PWM)	+= ep93xx_pwm.o
+obj-$(CONFIG_TI_DAC7512)	+= ti_dac7512.o
 obj-$(CONFIG_C2PORT)		+= c2port/
 obj-y				+= eeprom/
 obj-y				+= cb710/
diff --git a/drivers/misc/ti_dac7512.c b/drivers/misc/ti_dac7512.c
new file mode 100644
index 0000000..3c60dcf
--- /dev/null
+++ b/drivers/misc/ti_dac7512.c
@@ -0,0 +1,102 @@
+/*
+ *  dac7512.c - Linux kernel module for
+ * 	Texas Instruments DAC7512
+ *
+ *  Copyright (c) 2009 Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/spi/spi.h>
+
+#define DAC7512_DRV_NAME	"dac7512"
+#define DRIVER_VERSION		"1.0"
+
+static ssize_t dac7512_store_val(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned char tmp[2];
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val) < 0)
+		return -EINVAL;
+
+	tmp[0] = val >> 8;
+	tmp[1] = val & 0xff;
+	spi_write(spi, tmp, sizeof(tmp));
+	return count;
+}
+
+static DEVICE_ATTR(value, S_IWUSR | S_IRUGO,
+		   NULL, dac7512_store_val);
+
+static struct attribute *dac7512_attributes[] = {
+	&dev_attr_value.attr,
+	NULL
+};
+
+static const struct attribute_group dac7512_attr_group = {
+	.attrs = dac7512_attributes,
+};
+
+static int __devinit dac7512_probe(struct spi_device *spi)
+{
+	int ret;
+
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_0;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_create_group(&spi->dev.kobj, &dac7512_attr_group);
+}
+
+static int __devexit dac7512_remove(struct spi_device *spi)
+{
+	sysfs_remove_group(&spi->dev.kobj, &dac7512_attr_group);
+	return 0;
+}
+
+static struct spi_driver dac7512_driver = {
+	.driver = {
+		.name	= DAC7512_DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe	= dac7512_probe,
+	.remove	= __devexit_p(dac7512_remove),
+};
+
+static int __init dac7512_init(void)
+{
+	return spi_register_driver(&dac7512_driver);
+}
+
+static void __exit dac7512_exit(void)
+{
+	spi_unregister_driver(&dac7512_driver);
+}
+
+MODULE_AUTHOR("Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>");
+MODULE_DESCRIPTION("DAC7512 16-bit DAC");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRIVER_VERSION);
+
+module_init(dac7512_init);
+module_exit(dac7512_exit);
-- 
1.6.0.4


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
