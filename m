From: Alexis RODET <alexis.rodet@bvs-tech.com>
Subject: [PATCH 1/1] merging arch/arm/include/asm/mach/flash.h and
	include/linux/spi/flash.h into single header file
	include/linux/mtd/flash.h
Date: Mon, 31 Jan 2011 12:29:11 +0100
Message-ID: <1296473351-22771-1-git-send-email-alexis.rodet__31172.9662390009$1296473654$gmane$org@bvs-tech.com>
References: <4D3E9683.5090906@bvs-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Baruch Siach <baruch@tkos.co.il>, Alexis RODET <alexis.rodet@bvs-tech.com>,
	David Brownell <david-b@pacbell.net>, linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	David Woodhouse <dwmw2@infradead.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
To: 
In-Reply-To: <4D3E9683.5090906@bvs-tech.com>
To: Grant Likely <grant.likely@secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


Signed-off-by: Alexis RODET <alexis.rodet@bvs-tech.com>
---
 arch/arm/include/asm/mach/flash.h |   35 +------------------------
 include/linux/mtd/flash.h         |   51 +++++++++++++++++++++++++++++++++++++
 include/linux/spi/flash.h         |   27 +-------------------
 3 files changed, 53 insertions(+), 60 deletions(-)

diff --git a/arch/arm/include/asm/mach/flash.h b/arch/arm/include/asm/mach/flash.h
index 4ca69fe..28bd58b 100644
--- a/arch/arm/include/asm/mach/flash.h
+++ b/arch/arm/include/asm/mach/flash.h
@@ -1,39 +1,6 @@
-/*
- *  arch/arm/include/asm/mach/flash.h
- *
- *  Copyright (C) 2003 Russell King, All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
 #ifndef ASMARM_MACH_FLASH_H
 #define ASMARM_MACH_FLASH_H
 
-struct mtd_partition;
-struct mtd_info;
-
-/*
- * map_name:	the map probe function name
- * name:	flash device name (eg, as used with mtdparts=)
- * width:	width of mapped device
- * init:	method called at driver/device initialisation
- * exit:	method called at driver/device removal
- * set_vpp:	method called to enable or disable VPP
- * mmcontrol:	method called to enable or disable Sync. Burst Read in OneNAND
- * parts:	optional array of mtd_partitions for static partitioning
- * nr_parts:	number of mtd_partitions for static partitoning
- */
-struct flash_platform_data {
-	const char	*map_name;
-	const char	*name;
-	unsigned int	width;
-	int		(*init)(void);
-	void		(*exit)(void);
-	void		(*set_vpp)(int on);
-	void		(*mmcontrol)(struct mtd_info *mtd, int sync_read);
-	struct mtd_partition *parts;
-	unsigned int	nr_parts;
-};
+#include <linux/mtd/flash.h>
 
 #endif
diff --git a/include/linux/mtd/flash.h b/include/linux/mtd/flash.h
new file mode 100644
index 0000000..5379eee
--- /dev/null
+++ b/include/linux/mtd/flash.h
@@ -0,0 +1,51 @@
+/*
+ *  include/linux/mtd/flash.h
+ *  merged from arch/arm/include/asm/mach/flash.h and include/linux/spi/flash.h
+ *
+ *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef LINUX_MTD_FLASH_H
+#define LINUX_MTD_FLASH_H
+
+struct mtd_partition;
+struct mtd_info;
+
+/**
+ * struct flash_platform_data: board-specific flash data
+ * @map_name:	the map probe function name
+ * @name:	optional flash device name (eg, as used with mtdparts=)
+ * @width:	width of mapped device
+ * @init:	method called at driver/device initialisation
+ * @exit:	method called at driver/device removal
+ * @set_vpp:	method called to enable or disable VPP
+ * @mmcontrol:	method called to enable or disable Sync. Burst Read in OneNAND
+ * @parts:	optional array of mtd_partitions for static partitioning
+ * @nr_parts:	number of mtd_partitions for static partitoning
+ * @type:	optional flash device type (e.g. m25p80 vs m25p64), for use
+ *	with chips that can't be queried for JEDEC or other IDs
+ *
+ * Board init code (in arch/.../mach-xxx/board-yyy.c files) can
+ * provide information about SPI flash parts (such as DataFlash) to
+ * help set up the device and its appropriate default partitioning.
+ *
+ * Note that for DataFlash, sizes for pages, blocks, and sectors are
+ * rarely powers of two; and partitions should be sector-aligned.
+ */
+struct flash_platform_data {
+	const char	*map_name;
+	const char	*name;
+	unsigned int	width;
+	int		(*init)(void);
+	void		(*exit)(void);
+	void		(*set_vpp)(int on);
+	void		(*mmcontrol)(struct mtd_info *mtd, int sync_read);
+	struct mtd_partition *parts;
+	unsigned int	nr_parts;
+	const char	*type;
+};
+
+#endif
diff --git a/include/linux/spi/flash.h b/include/linux/spi/flash.h
index 3f22932..c7ed65e 100644
--- a/include/linux/spi/flash.h
+++ b/include/linux/spi/flash.h
@@ -1,31 +1,6 @@
 #ifndef LINUX_SPI_FLASH_H
 #define LINUX_SPI_FLASH_H
 
-struct mtd_partition;
-
-/**
- * struct flash_platform_data: board-specific flash data
- * @name: optional flash device name (eg, as used with mtdparts=)
- * @parts: optional array of mtd_partitions for static partitioning
- * @nr_parts: number of mtd_partitions for static partitoning
- * @type: optional flash device type (e.g. m25p80 vs m25p64), for use
- *	with chips that can't be queried for JEDEC or other IDs
- *
- * Board init code (in arch/.../mach-xxx/board-yyy.c files) can
- * provide information about SPI flash parts (such as DataFlash) to
- * help set up the device and its appropriate default partitioning.
- *
- * Note that for DataFlash, sizes for pages, blocks, and sectors are
- * rarely powers of two; and partitions should be sector-aligned.
- */
-struct flash_platform_data {
-	char		*name;
-	struct mtd_partition *parts;
-	unsigned int	nr_parts;
-
-	char		*type;
-
-	/* we'll likely add more ... use JEDEC IDs, etc */
-};
+#include <linux/mtd/flash.h>
 
 #endif
-- 
1.7.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
