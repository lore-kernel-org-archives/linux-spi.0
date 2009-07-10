From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] SPI driver for LMS283GF05 LCD
Date: Sat, 11 Jul 2009 00:33:15 +0200
Message-ID: <200907110033.15530.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rG8VK3AK2BXXD/q"
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

--Boundary-00=_rG8VK3AK2BXXD/q
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
the included patch adds SPI on/off procedures for the LCD. S-O-B is in the 
patch. Please consider applying. Thanks.

--Boundary-00=_rG8VK3AK2BXXD/q
Content-Type: text/x-patch; charset="UTF-8";
	name="0001-Samsung-LMS283GF05-LCD-SPI-support.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Samsung-LMS283GF05-LCD-SPI-support.patch"

=46rom 1aba3015a91655cad8f5a09a15afa2b92bcf1fe9 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Fri, 10 Jul 2009 15:31:02 +0200
Subject: [PATCH] Samsung LMS283GF05 LCD SPI support

This patch adds support for the SPI part of LMS283GF05 LCD. The LCD uses
SPI for initialization and powerdown sequences. No further defails are
specified in the datasheet about the initialization/powerdown sequence,
just the magic numbers that have to be sent over SPI bus. This LCD can
be found in the Aeronix Zipit Z2 handheld.

Signed-off-by: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
=2D--
 drivers/spi/Kconfig            |    7 +
 drivers/spi/Makefile           |    1 +
 drivers/spi/lms283gf05.c       |  256 ++++++++++++++++++++++++++++++++++++=
++++
 include/linux/spi/lms283gf05.h |   29 +++++
 4 files changed, 293 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/lms283gf05.c
 create mode 100644 include/linux/spi/lms283gf05.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2c733c2..8451ee1 100644
=2D-- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -246,6 +246,13 @@ config SPI_SPIDEV
 	  Note that this application programming interface is EXPERIMENTAL
 	  and hence SUBJECT TO CHANGE WITHOUT NOTICE while it stabilizes.
=20
+config SPI_LMS283GF05
+	tristate "Samsung LMS283GF05 LCD"
+	depends on SYSFS
+	help
+	  SPI driver for Samsung LMS283GF05. This provides basic support
+	  for powering the LCD up/down through a sysfs interface.
+
 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
 	depends on SYSFS
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3de408d..35025ad 100644
=2D-- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_SPI_SH_SCI)		+=3D spi_sh_sci.o
=20
 # SPI protocol drivers (device/link on bus)
 obj-$(CONFIG_SPI_SPIDEV)	+=3D spidev.o
+obj-$(CONFIG_SPI_LMS283GF05)	+=3D lms283gf05.o
 obj-$(CONFIG_SPI_TLE62X0)	+=3D tle62x0.o
 # 	... add above this line ...
=20
diff --git a/drivers/spi/lms283gf05.c b/drivers/spi/lms283gf05.c
new file mode 100644
index 0000000..260e3fb
=2D-- /dev/null
+++ b/drivers/spi/lms283gf05.c
@@ -0,0 +1,256 @@
+/*
+ * lms283gf05.c -- support for Samsung LMS283GF05 LCD
+ *
+ * Copyright (c) 2009 Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/lms283gf05.h>
+
+struct lms283gf05_state {
+	struct spi_device	*us;
+	struct mutex		lock;
+	struct lms283gf05_pdata	*pdata;
+};
+
+struct lms283gf05_seq {
+	unsigned char		reg;
+	unsigned short		value;
+	unsigned char		delay;
+};
+
+/* Magic sequences supplied by manufacturer, for details refer to datashee=
t */
+static struct lms283gf05_seq disp_initseq[] =3D {
+	/* REG, VALUE, DELAY */
+	{ 0x07, 0x0000, 0 },
+	{ 0x13, 0x0000, 10 },
+
+	{ 0x11, 0x3004, 0 },
+	{ 0x14, 0x200F, 0 },
+	{ 0x10, 0x1a20, 0 },
+	{ 0x13, 0x0040, 50 },
+
+	{ 0x13, 0x0060, 0 },
+	{ 0x13, 0x0070, 200 },
+
+	{ 0x01, 0x0127, 0 },
+	{ 0x02,	0x0700, 0 },
+	{ 0x03, 0x1030, 0 },
+	{ 0x08, 0x0208, 0 },
+	{ 0x0B, 0x0620, 0 },
+	{ 0x0C, 0x0110, 0 },
+	{ 0x30, 0x0120, 0 },
+	{ 0x31, 0x0127, 0 },
+	{ 0x32, 0x0000, 0 },
+	{ 0x33, 0x0503, 0 },
+	{ 0x34, 0x0727, 0 },
+	{ 0x35, 0x0124, 0 },
+	{ 0x36, 0x0706, 0 },
+	{ 0x37, 0x0701, 0 },
+	{ 0x38, 0x0F00, 0 },
+	{ 0x39, 0x0F00, 0 },
+	{ 0x40, 0x0000, 0 },
+	{ 0x41, 0x0000, 0 },
+	{ 0x42, 0x013f, 0 },
+	{ 0x43, 0x0000, 0 },
+	{ 0x44, 0x013f, 0 },
+	{ 0x45, 0x0000, 0 },
+	{ 0x46, 0xef00, 0 },
+	{ 0x47, 0x013f, 0 },
+	{ 0x48, 0x0000, 0 },
+	{ 0x07, 0x0015, 30 },
+
+	{ 0x07, 0x0017, 0 },
+
+	{ 0x20, 0x0000, 0 },
+	{ 0x21, 0x0000, 0 },
+	{ 0x22, 0x0000, 0 }
+};
+
+static struct lms283gf05_seq disp_pdwnseq[] =3D {
+	{ 0x07, 0x0016, 30 },
+
+	{ 0x07, 0x0004, 0 },
+	{ 0x10, 0x0220, 20 },
+
+	{ 0x13, 0x0060, 50 },
+
+	{ 0x13, 0x0040, 50 },
+
+	{ 0x13, 0x0000, 0 },
+	{ 0x10, 0x0000, 0 }
+};
+
+
+static ssize_t lms283gf05_power_set(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len);
+
+static void lms283gf05_reset(unsigned long gpio, bool inverted)
+{
+	gpio_set_value(gpio, !inverted);
+	mdelay(100);
+	gpio_set_value(gpio, inverted);
+	mdelay(20);
+	gpio_set_value(gpio, !inverted);
+	mdelay(20);
+}
+
+static void lms283gf05_toggle(struct lms283gf05_state *st,
+			struct lms283gf05_seq *seq, int sz)
+{
+	char buf[3];
+	int i;
+
+	for (i =3D 0; i < sz; i++) {
+		buf[0] =3D 0x74;
+		buf[1] =3D 0x00;
+		buf[2] =3D seq[i].reg;
+		spi_write(st->us, buf, 3);
+
+		buf[0] =3D 0x76;
+		buf[1] =3D seq[i].value >> 8;
+		buf[2] =3D seq[i].value & 0xff;
+		spi_write(st->us, buf, 3);
+
+		mdelay(seq[i].delay);
+	}
+}
+
+static DEVICE_ATTR(enable, S_IWUSR, NULL, lms283gf05_power_set);
+
+static ssize_t lms283gf05_power_set(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct lms283gf05_state *st =3D dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	if (attr !=3D &dev_attr_enable)
+		return -EINVAL;
+
+	ret =3D strict_strtoul(buf, 0, &val);
+	if (ret)
+		return -EINVAL;
+
+	dev_dbg(dev, "LCD power: %i\n", !!val);
+
+	mutex_lock(&st->lock);
+
+	if (val) {
+		if (st->pdata)
+			lms283gf05_reset(st->pdata->reset_gpio,
+					st->pdata->reset_inverted);
+		lms283gf05_toggle(st, disp_initseq, ARRAY_SIZE(disp_initseq));
+	} else {
+		lms283gf05_toggle(st, disp_pdwnseq, ARRAY_SIZE(disp_pdwnseq));
+		if (st->pdata)
+			gpio_set_value(st->pdata->reset_gpio,
+					st->pdata->reset_inverted);
+	}
+
+	mutex_unlock(&st->lock);
+
+	return len;
+}
+
+
+static int __devinit lms283gf05_probe(struct spi_device *spi)
+{
+	struct lms283gf05_state *st;
+	struct lms283gf05_pdata *pdata =3D spi->dev.platform_data;
+	int ret =3D 0;
+
+	if (pdata !=3D NULL) {
+		ret =3D gpio_request(pdata->reset_gpio, "LMS285GF05 RESET");
+		if (ret)
+			return ret;
+
+		ret =3D gpio_direction_output(pdata->reset_gpio, 0);
+		if (ret)
+			goto err;
+	}
+
+	st =3D kzalloc(sizeof(struct lms283gf05_state), GFP_KERNEL);
+	if (st =3D=3D NULL) {
+		dev_err(&spi->dev, "No memory for device state\n");
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	st->us =3D spi;
+	st->pdata =3D pdata;
+	mutex_init(&st->lock);
+
+	ret =3D device_create_file(&spi->dev, &dev_attr_enable);
+	if (ret) {
+		dev_err(&spi->dev, "Cannot create power attribute\n");
+		goto err2;
+	}
+
+	spi_set_drvdata(spi, st);
+
+	/* kick in the LCD */
+	if (pdata)
+		lms283gf05_reset(pdata->reset_gpio, pdata->reset_inverted);
+	lms283gf05_toggle(st, disp_initseq, ARRAY_SIZE(disp_initseq));
+
+	return 0;
+
+err2:
+	kfree(st);
+err:
+	if (pdata !=3D NULL)
+		gpio_free(pdata->reset_gpio);
+	return ret;
+}
+
+static int __devexit lms283gf05_remove(struct spi_device *spi)
+{
+	struct 	lms283gf05_state *st =3D spi_get_drvdata(spi);
+
+	device_remove_file(&spi->dev, &dev_attr_enable);
+
+	kfree(st);
+
+	if (st->pdata !=3D NULL)
+		gpio_free(st->pdata->reset_gpio);
+
+	return 0;
+}
+
+static struct spi_driver lms283gf05_driver =3D {
+	.driver =3D {
+		.name	=3D "lms283gf05",
+		.owner	=3D THIS_MODULE,
+	},
+	.probe		=3D lms283gf05_probe,
+	.remove		=3D __devexit_p(lms283gf05_remove),
+};
+
+static __init int lms283gf05_init(void)
+{
+	return spi_register_driver(&lms283gf05_driver);
+}
+
+static __exit void lms283gf05_exit(void)
+{
+	spi_unregister_driver(&lms283gf05_driver);
+}
+
+module_init(lms283gf05_init);
+module_exit(lms283gf05_exit);
+
+MODULE_AUTHOR("Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("LCD283GF05 LCD");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/spi/lms283gf05.h b/include/linux/spi/lms283gf05.h
new file mode 100644
index 0000000..02e7228
=2D-- /dev/null
+++ b/include/linux/spi/lms283gf05.h
@@ -0,0 +1,29 @@
+/*
+ * lms283gf05.h - Platform glue and init/powerdown sequence definitions
+ * 		  for Samsung LMS283GF05 LCD
+ *
+ * Copyright (C) 2009 Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
+*/
+
+#ifndef _INCLUDE_LINUX_SPI_LMS283GF05_H_
+#define _INCLUDE_LINUX_SPI_LMS283GF05_H_
+
+struct lms283gf05_pdata {
+	unsigned long	reset_gpio;
+	bool		reset_inverted;
+};
+
+#endif /* _INCLUDE_LINUX_SPI_LMS283GF05_H_ */
=2D-=20
1.6.3.3


--Boundary-00=_rG8VK3AK2BXXD/q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--Boundary-00=_rG8VK3AK2BXXD/q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--Boundary-00=_rG8VK3AK2BXXD/q--
