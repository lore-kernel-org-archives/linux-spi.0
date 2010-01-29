From: "Pietrek, Markus" <Markus.Pietrek-BU0Y/NROKIiELgA04lAiVw@public.gmane.org>
Subject: [PATCH] added
 drivers/spi/spi_board_info_cmdline for setting up an spi_board_info
 structure on commandline
Date: Fri, 29 Jan 2010 14:48:29 +0100
Message-ID: <95F51F4B902CAC40AF459205F6322F0171E8D49880@BMK019S01.emtrion.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: de-DE
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

Some embedded systems have SPI connectors where different kind of SPI devices might be attached. The platform maintainer for e.g. arch/sh/boards/board-XXX.c therefore can't  provide an spi_board_info array for all possible SPI devices. This patch provides a kernel command line interface for setting up an spi_board_info array without the need of recompilation of the kernel.


Signed-off-by: Markus Pietrek <markus.pietrek-BU0Y/NROKIiELgA04lAiVw@public.gmane.org>
---
 Documentation/kernel-parameters.txt  |    7 ++
 drivers/spi/Kconfig                  |   19 ++++
 drivers/spi/Makefile                 |    3 +
 drivers/spi/spi.c                    |    4 -
 drivers/spi/spi_board_info_cmdline.c |  168 ++++++++++++++++++++++++++++++++++
 5 files changed, 197 insertions(+), 4 deletions(-)
 create mode 100644 drivers/spi/spi_board_info_cmdline.c

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 736d456..4ff7e78 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2449,6 +2449,13 @@ and is between 256 and 4096 characters. It is defined in the file
        specialix=      [HW,SERIAL] Specialix multi-serial port adapter
                        See Documentation/serial/specialix.txt.

+        spi_board_info= [HW]
+                        Format: spi_board_info=<devcfg>[,<devcfg>...]
+                       with <devcfg> as
+                       <devname>[:<max_speed_hz>[:<bus_num>[:<chip_select>[:<irq>[:<opt>[:<opt>...]]]]]]
+                        and <opt> as one of
+                        cpha,cpol,mode0,mode1,mode2,mode3,cs,lsb,3wire,loop,no_cs,ready
+
        spia_io_base=   [HW,MTD]
        spia_fio_base=
        spia_pedr=
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f55eb01..85e88fa 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -317,6 +317,25 @@ config SPI_DW_PCI
        tristate "PCI interface driver for DW SPI core"
        depends on SPI_DESIGNWARE && PCI

+config SPI_BOARD_INFO_CMDLINE
+       tristate "SPI board_info commandline support"
+       depends on SPI_MASTER
+       default n
+       help
+         Provides the kernel commandline option spi_board_info= for registering
+         new SPI devices without the need to change and recompile arch/<CPU>/<board>/setup.c
+          The syntax is:
+         spi_board_info=<devcfg>[,<devcfg>...]
+         with <devcfg> as
+         <devname>[:<max_speed_hz>[:<bus_num>[:<chip_select>[:<irq>[:<opt>[:<opt>...]]]]]]
+          and <opt> as one of
+          cpha,cpol,mode0,mode1,mode2,mode3,cs,lsb,3wire,loop,no_cs,ready
+
+          Example:
+           spi_board_info=spidev
+           spi_board_info=spidev:33000000:0,ltc2440_adc:33000000:1
+
+
 #
 # There are lots of SPI device types, with sensors and memory
 # being probably the most widely used ones.
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index f3d2810..df7087d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -43,6 +43,9 @@ obj-$(CONFIG_SPI_SH_MSIOF)            += spi_sh_msiof.o
 obj-$(CONFIG_SPI_STMP3XXX)             += spi_stmp.o
 obj-$(CONFIG_SPI_NUC900)               += spi_nuc900.o

+# SPI commandline interface
+obj-$(CONFIG_SPI_BOARD_INFO_CMDLINE)   += spi_board_info_cmdline.o
+
 # special build for s3c24xx spi driver with fiq support
 spi_s3c24xx_hw-y                       := spi_s3c24xx.o
 spi_s3c24xx_hw-$(CONFIG_SPI_S3C24XX_FIQ) += spi_s3c24xx_fiq.o
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b76f246..9723080 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -398,10 +398,6 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
        return 0;
 }

-/* FIXME someone should add support for a __setup("spi", ...) that
- * creates board info from kernel command lines
- */
-
 static void scan_boardinfo(struct spi_master *master)
 {
        struct boardinfo        *bi;
diff --git a/drivers/spi/spi_board_info_cmdline.c b/drivers/spi/spi_board_info_cmdline.c
new file mode 100644
index 0000000..765a941
--- /dev/null
+++ b/drivers/spi/spi_board_info_cmdline.c
@@ -0,0 +1,168 @@
+/*
+ * spi_board_info_cmdline.c
+ *
+ * Copyright (c) 2010 by emtrion GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ **/
+
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+
+#define DRIVER_NAME "spi_board_info"
+
+static char *cmdline;
+
+/**
+ * spi_board_info_setup - stores our kernel commandline options for later use
+ */
+static int __init spi_board_info_setup(char *opt)
+{
+       cmdline = opt;
+       return 0;
+}
+__setup("spi_board_info=", spi_board_info_setup);
+
+
+/**
+ * spi_board_info_register_device - registers an SPI device defined by kernel argument line
+ */
+static int __init spi_board_info_register_device(char *dev)
+{
+       struct spi_board_info *info = NULL;
+       int num = 0;
+       int res = 0;
+       char *opt = dev;
+
+       info = kzalloc(sizeof(*info), GFP_KERNEL);
+       if (!info)
+               return -ENOMEM;
+
+       info->irq = -1;         /* no irq */
+
+       /* parse configuration and store in spi_board_info */
+       while (opt && *opt) {
+               char *next = strchr(opt, ':');
+
+               if (next)
+                       *next++ = '\0';
+
+               if (strlen(opt) > 0) {
+                       switch (num) {
+                           case 0:
+                               strncpy(info->modalias, opt, ARRAY_SIZE(info->modalias));
+                               info->modalias[ARRAY_SIZE(info->modalias)-1]=0;
+                               break;
+                           case 1:
+                               info->max_speed_hz = simple_strtoul(opt, NULL, 10);
+                               break;
+                           case 2:
+                               info->bus_num = simple_strtoul(opt, NULL, 10);
+                               break;
+                           case 3:
+                               info->chip_select = simple_strtoul(opt, NULL, 10);
+                               break;
+                           case 4:
+                               info->irq = simple_strtoul(opt, NULL, 10);
+                               break;
+                           default:
+                               if (!strcmp(opt, "cpha"))
+                                       info->mode |= SPI_CPHA;
+                               else if (!strcmp(opt, "cpol"))
+                                       info->mode |= SPI_CPOL;
+                               else if (!strcmp(opt, "mode0"))
+                                       info->mode |= SPI_MODE_0;
+                               else if (!strcmp(opt, "mode1"))
+                                       info->mode |= SPI_MODE_1;
+                               else if (!strcmp(opt, "mode2"))
+                                       info->mode |= SPI_MODE_2;
+                               else if (!strcmp(opt, "mode3"))
+                                       info->mode |= SPI_MODE_3;
+                               else if (!strcmp(opt, "cs"))
+                                       info->mode |= SPI_CS_HIGH;
+                               else if (!strcmp(opt, "lsb"))
+                                       info->mode |= SPI_LSB_FIRST;
+                               else if (!strcmp(opt, "3wire"))
+                                       info->mode |= SPI_3WIRE;
+                               else if (!strcmp(opt, "loop"))
+                                       info->mode |= SPI_LOOP;
+                               else if (!strcmp(opt, "no_cs"))
+                                       info->mode |= SPI_NO_CS;
+                               else if (!strcmp(opt, "ready"))
+                                       info->mode |= SPI_READY;
+                               else {
+                                       pr_err(DRIVER_NAME ": Don't know value %s\n", opt);
+                                       kfree(info);
+                                       return -1;
+                               }
+
+                               break;
+                       }
+               }
+
+               /* next option */
+               opt = next;
+               num++;
+       }
+
+       if (num > 0) {
+               res = spi_register_board_info(info, 1);
+               if (res < 0)
+                       pr_err(DRIVER_NAME ": registering failed for %s with error %i\n", info->modalias, res);
+               else
+                       pr_info(DRIVER_NAME ": registered %s\n", info->modalias);
+       }
+
+       return res;
+}
+
+/**
+ * spi_board_info_init - scans the command line option spi_board_info for devices
+ */
+static int __init spi_board_info_init(void)
+{
+       int res;
+       char *dev = cmdline;
+
+       /* split and register spi devices */
+       while (dev && *dev) {
+               char *next = strchr(dev, ',');
+
+               if (next)
+                       *next++ = '\0';
+
+               if ((res=spi_board_info_register_device(dev)) < 0)
+                       return res;
+
+               /* next device */
+               dev = next;
+       }
+
+       return 0;
+}
+
+/* additional devices should be registered after the architecture has added it's
+ * own and before the SPI subsystem initializes itself */
+arch_initcall_sync(spi_board_info_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Markus Pietrek");
+MODULE_DESCRIPTION("Command line parser for SPI boardinfo");
--
1.5.4.3


_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
