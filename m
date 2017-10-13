From: Angelo Dureghello <angelo-BIYBQhTR83Y@public.gmane.org>
Subject: [RFC] patch to spi-fsl-dspi.c to enable Coldfire mcf5441x
Date: Fri, 13 Oct 2017 02:08:54 +0200
Message-ID: <ff0014ac-1d46-5014-4371-041ccdba1fa5@sysam.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------57A0638A40AC44CA6D7C92C3"
Cc: Greg Ungerer <gregungerer-ncau/BB9MAPvnOemgxGiVw@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a multi-part message in MIME format.
--------------57A0638A40AC44CA6D7C92C3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear all,

i had the need to use the dspi module of Coldfire mcf5441x.
I have seen the spi-fsl-dspi.c was already covering this
CPU but was not selectable, and not working out of the box
once enabled form Kconfig.

So i tested the attached solution on a mcf5441x based board
called stmark2, it seems to work reliably at least from some
basic testing.

I have a nor spi flash connected to dspi0.

[    8.140000] m25p80 spi0.1: is25lp128 (16384 Kbytes)
[    8.150000] Creating 3 MTD partitions on "is25lp128":
[    8.150000] 0x000000000000-0x000000100000 : "U-Boot (1024K)"
[    8.220000] 0x000000100000-0x000000800000 : "Kernel+initramfs (7168K)"
[    8.290000] 0x000000800000-0x000001000000 : "Flash Free Space (8192K)"
[    8.400000] Freeing unused kernel memory: 264K

I can read and write the partitions properly.

Not sure if patching the driver adding board support would be
welcome, btw, Coldfire arch. is actually not supporting devicetree
so this is why i am proposing the board support option.


Best regards,
Angelo Dureghello



--------------57A0638A40AC44CA6D7C92C3
Content-Type: text/x-patch;
 name="0001-spi-spi-fsl-dspi-enabling-Coldfire-mcf5441x-to-use-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-spi-spi-fsl-dspi-enabling-Coldfire-mcf5441x-to-use-t.pa";
 filename*1="tch"

>From 811fdbb62a9d9c1d194e67c8c5be359500bcc772 Mon Sep 17 00:00:00 2001
From: Angelo Dureghello <angelo-BIYBQhTR83Y@public.gmane.org>
Date: Fri, 13 Oct 2017 01:03:25 +0200
Subject: [PATCH] spi: spi-fsl-dspi: enabling Coldfire mcf5441x to use this
 driver.

This patch adds board support and related params to enable the use
of this driver from Coldfire mcf5441x CPU family.

Signed-off-by: Angelo Dureghello <angelo-BIYBQhTR83Y@public.gmane.org>
---
 drivers/spi/Kconfig              |  2 +-
 drivers/spi/spi-fsl-dspi.c       | 67 +++++++++++++++++++++++++++-------------
 include/linux/spi/spi-fsl-dspi.h | 31 +++++++++++++++++++
 3 files changed, 77 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/spi/spi-fsl-dspi.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a75f2a2cf780..a8b761979673 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -379,7 +379,7 @@ config SPI_FSL_DSPI
 	tristate "Freescale DSPI controller"
 	select REGMAP_MMIO
 	depends on HAS_DMA
-	depends on SOC_VF610 || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on SOC_VF610 || SOC_LS1021A || ARCH_LAYERSCAPE || M5441x || COMPILE_TEST
 	help
 	  This enables support for the Freescale DSPI controller in master
 	  mode. VF610 platform uses the controller.
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d89127f4a46d..ad0b3fc8d2a6 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -32,6 +32,7 @@
 #include <linux/regmap.h>
 #include <linux/sched.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/spi-fsl-dspi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/time.h>
 
@@ -151,6 +152,11 @@ static const struct fsl_dspi_devtype_data ls2085a_data = {
 	.max_clock_factor = 8,
 };
 
+static const struct fsl_dspi_devtype_data coldfire_data = {
+	.trans_mode = DSPI_EOQ_MODE,
+	.max_clock_factor = 8,
+};
+
 struct fsl_dspi_dma {
 	/* Length of transfer in words of DSPI_FIFO_SIZE */
 	u32 curr_xfer_len;
@@ -741,6 +747,7 @@ static int dspi_setup(struct spi_device *spi)
 {
 	struct chip_data *chip;
 	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
+	struct fsl_dspi_platform_data *pdata;
 	u32 cs_sck_delay = 0, sck_cs_delay = 0;
 	unsigned char br = 0, pbr = 0, pcssck = 0, cssck = 0;
 	unsigned char pasc = 0, asc = 0, fmsz = 0;
@@ -761,11 +768,18 @@ static int dspi_setup(struct spi_device *spi)
 			return -ENOMEM;
 	}
 
-	of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
-			&cs_sck_delay);
+	pdata = dev_get_platdata(&dspi->pdev->dev);
 
-	of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
-			&sck_cs_delay);
+	if (!pdata) {
+		of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
+				&cs_sck_delay);
+
+		of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
+				&sck_cs_delay);
+	} else {
+		cs_sck_delay = pdata->cs_sck_delay;
+		sck_cs_delay = pdata->sck_cs_delay;
+	}
 
 	chip->mcr_val = SPI_MCR_MASTER | SPI_MCR_PCSIS |
 		SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF;
@@ -819,7 +833,6 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-
 	if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
 		tx_word = is_double_byte_mode(dspi);
 
@@ -949,6 +962,7 @@ static int dspi_probe(struct platform_device *pdev)
 	struct fsl_dspi *dspi;
 	struct resource *res;
 	void __iomem *base;
+	struct fsl_dspi_platform_data *pdata;
 	int ret = 0, cs_num, bus_num;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
@@ -969,25 +983,34 @@ static int dspi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(4) | SPI_BPW_MASK(8) |
 					SPI_BPW_MASK(16);
 
-	ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "can't get spi-num-chipselects\n");
-		goto out_master_put;
-	}
-	master->num_chipselect = cs_num;
+	pdata = dev_get_platdata(&pdev->dev);
+	if (pdata) {
+		master->num_chipselect = pdata->cs_num;
+		master->bus_num = pdata->bus_num;
 
-	ret = of_property_read_u32(np, "bus-num", &bus_num);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "can't get bus-num\n");
-		goto out_master_put;
-	}
-	master->bus_num = bus_num;
+		dspi->devtype_data = &coldfire_data;
+	} else {
 
-	dspi->devtype_data = of_device_get_match_data(&pdev->dev);
-	if (!dspi->devtype_data) {
-		dev_err(&pdev->dev, "can't get devtype_data\n");
-		ret = -EFAULT;
-		goto out_master_put;
+		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "can't get spi-num-chipselects\n");
+			goto out_master_put;
+		}
+		master->num_chipselect = cs_num;
+
+		ret = of_property_read_u32(np, "bus-num", &bus_num);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "can't get bus-num\n");
+			goto out_master_put;
+		}
+		master->bus_num = bus_num;
+
+		dspi->devtype_data = of_device_get_match_data(&pdev->dev);
+		if (!dspi->devtype_data) {
+			dev_err(&pdev->dev, "can't get devtype_data\n");
+			ret = -EFAULT;
+			goto out_master_put;
+		}
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/include/linux/spi/spi-fsl-dspi.h b/include/linux/spi/spi-fsl-dspi.h
new file mode 100644
index 000000000000..74c9bae20bf2
--- /dev/null
+++ b/include/linux/spi/spi-fsl-dspi.h
@@ -0,0 +1,31 @@
+/*
+ * Freescale DSPI controller driver
+ *
+ * Copyright (c) 2017 Angelo Dureghello <angelo-BIYBQhTR83Y@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef SPI_FSL_DSPI_HEADER_H
+#define SPI_FSL_DSPI_HEADER_H
+
+/**
+ * struct fsl_dspi_platform_data - platform data for the Freescale DSPI driver
+ * @bus_num: board specific identifier for this DSPI driver.
+ * @cs_num: number of chip selects supported by this DSPI driver.
+ */
+struct fsl_dspi_platform_data {
+	u32 cs_num;
+	u32 bus_num;
+	u32 sck_cs_delay;
+	u32 cs_sck_delay;
+};
+
+#endif /* SPI_FSL_DSPI_HEADER_H */
-- 
2.14.1


--------------57A0638A40AC44CA6D7C92C3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
