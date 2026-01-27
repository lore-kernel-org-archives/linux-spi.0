Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA82882CE;
	Tue, 27 Jan 2026 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547949; cv=none; b=K7hVqaIAURxmgv8Q+2KtHXMkZ0FcRe4+Q/GczZ2wpt9Gso0G0g93DxKv7ZevHc37xsnx7M/RBMVa5vhzOXK7CJ0c3rTCHJQNU2VmKVoBB4dCw+fwPQzEklqtFCg9mn7bNzVesZ9whruF+LkWlf8LvqFwUeDCfO5jtMEQaT4me8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547949; c=relaxed/simple;
	bh=lisn/ecaiuE3lJLFh2pm/QAdueQk2Om7N03UTtr0NzI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nCKa8n6BHNAMjbNiu8FPmk3gdeDwMCAAKwc+AMorwdwPw7JTFgDbpRLFoNm44AjlsyPs5hKDYhuBLTGM7+kE12uo1U+e6GDrszK/pUkKlNz/BkeYw755W1o+Wy1+sccaGRlCAdElfbLGVpyh4wkSZ3gs2sfDO4u1C+hTR2xVIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GM8j09XG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GM8j09XG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769547948; x=1801083948;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lisn/ecaiuE3lJLFh2pm/QAdueQk2Om7N03UTtr0NzI=;
  b=GM8j09XGwPou5xHmnXL5OAwgbajYPZVtAsH34k9S7TlxVZgs8ykKFB0d
   TfnHo98/MTgvlbtrySNqvQ2jD5ta2bYoJj0RITVH8BsDUkXRMlDPB7cjb
   jPYUFZomyUAXJsrLJex+vBKYZQxaS5GDFyMsWcHQmuTIMPjF+t7QlHJdf
   PfYR51QYel+Wic+o1hzsyWgXNMHBdO6B2ehcTtWvmAAOlULIStrgBUF7F
   RGzbgLPJMGGY0+rxMjH8Ipse/DZIIHYrvpG3ArBd6rXeS7k5AoLu06MK0
   xY0vQd09M4GO4tmhCTbVlr1sHQV0Tgfb55f72O8xqspTzEw3gNovyd2NG
   A==;
X-CSE-ConnectionGUID: +N3VolEpTZK9cACrJn13zQ==
X-CSE-MsgGUID: c1/Ek0aNQcqnrvK44qZ3gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69770336"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="69770336"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:05:47 -0800
X-CSE-ConnectionGUID: M0dEoM27TyiSF6P/p327Gg==
X-CSE-MsgGUID: OUuqAT3URquyZ6dy/XxbWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208138314"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 27 Jan 2026 13:05:44 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id AFA8D95; Tue, 27 Jan 2026 22:05:42 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v1 1/1] spi: dw: Remove not-going-to-be-supported code for Baikal SoC
Date: Tue, 27 Jan 2026 22:05:41 +0100
Message-ID: <20260127210541.4068379-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As noticed in the discussion [1] the Baikal SoC and platforms
are not going to be finalized, hence remove stale code.

Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/Kconfig      |  27 ----
 drivers/spi/Makefile     |   1 -
 drivers/spi/spi-dw-bt1.c | 331 ---------------------------------------
 3 files changed, 359 deletions(-)
 delete mode 100644 drivers/spi/spi-dw-bt1.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f884cb717543..2d788c4829d7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -384,33 +384,6 @@ config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
 	depends on HAS_IOMEM
 
-config SPI_DW_BT1
-	tristate "Baikal-T1 SPI driver for DW SPI core"
-	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
-	select MULTIPLEXER
-	help
-	  Baikal-T1 SoC is equipped with three DW APB SSI-based MMIO SPI
-	  controllers. Two of them are pretty much normal: with IRQ, DMA,
-	  FIFOs of 64 words depth, 4x CSs, but the third one as being a
-	  part of the Baikal-T1 System Boot Controller has got a very
-	  limited resources: no IRQ, no DMA, only a single native
-	  chip-select and Tx/Rx FIFO with just 8 words depth available.
-	  The later one is normally connected to an external SPI-nor flash
-	  of 128Mb (in general can be of bigger size).
-
-config SPI_DW_BT1_DIRMAP
-	bool "Directly mapped Baikal-T1 Boot SPI flash support"
-	depends on SPI_DW_BT1
-	help
-	  Directly mapped SPI flash memory is an interface specific to the
-	  Baikal-T1 System Boot Controller. It is a 16MB MMIO region, which
-	  can be used to access a peripheral memory device just by
-	  reading/writing data from/to it. Note that the system APB bus
-	  will stall during each IO from/to the dirmap region until the
-	  operation is finished. So try not to use it concurrently with
-	  time-critical tasks (like the SPI memory operations implemented
-	  in this driver).
-
 endif
 
 config SPI_DLN2
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9f44b508402b..9d36190a9884 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_SPI_DLN2)			+= spi-dln2.o
 obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
 spi-dw-y				:= spi-dw-core.o
 spi-dw-$(CONFIG_SPI_DW_DMA)		+= spi-dw-dma.o
-obj-$(CONFIG_SPI_DW_BT1)		+= spi-dw-bt1.o
 obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
 obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-pci.o
 obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
deleted file mode 100644
index 91642e05ac60..000000000000
--- a/drivers/spi/spi-dw-bt1.c
+++ /dev/null
@@ -1,331 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-//
-// Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
-//
-// Authors:
-//   Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
-//   Serge Semin <Sergey.Semin@baikalelectronics.ru>
-//
-// Baikal-T1 DW APB SPI and System Boot SPI driver
-//
-
-#include <linux/clk.h>
-#include <linux/cpumask.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/mux/consumer.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/property.h>
-#include <linux/slab.h>
-#include <linux/spi/spi-mem.h>
-#include <linux/spi/spi.h>
-
-#include "spi-dw.h"
-
-#define BT1_BOOT_DIRMAP		0
-#define BT1_BOOT_REGS		1
-
-struct dw_spi_bt1 {
-	struct dw_spi		dws;
-	struct clk		*clk;
-	struct mux_control	*mux;
-
-#ifdef CONFIG_SPI_DW_BT1_DIRMAP
-	void __iomem		*map;
-	resource_size_t		map_len;
-#endif
-};
-#define to_dw_spi_bt1(_ctlr) \
-	container_of(spi_controller_get_devdata(_ctlr), struct dw_spi_bt1, dws)
-
-typedef int (*dw_spi_bt1_init_cb)(struct platform_device *pdev,
-				    struct dw_spi_bt1 *dwsbt1);
-
-#ifdef CONFIG_SPI_DW_BT1_DIRMAP
-
-static int dw_spi_bt1_dirmap_create(struct spi_mem_dirmap_desc *desc)
-{
-	struct dw_spi_bt1 *dwsbt1 = to_dw_spi_bt1(desc->mem->spi->controller);
-
-	if (!dwsbt1->map ||
-	    !dwsbt1->dws.mem_ops.supports_op(desc->mem, &desc->info.op_tmpl))
-		return -EOPNOTSUPP;
-
-	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
-		return -EOPNOTSUPP;
-
-	/*
-	 * Make sure the requested region doesn't go out of the physically
-	 * mapped flash memory bounds.
-	 */
-	if (desc->info.offset + desc->info.length > dwsbt1->map_len)
-		return -EINVAL;
-
-	return 0;
-}
-
-/*
- * Directly mapped SPI memory region is only accessible in the dword chunks.
- * That's why we have to create a dedicated read-method to copy data from there
- * to the passed buffer.
- */
-static void dw_spi_bt1_dirmap_copy_from_map(void *to, void __iomem *from, size_t len)
-{
-	size_t shift, chunk;
-	u32 data;
-
-	/*
-	 * We split the copying up into the next three stages: unaligned head,
-	 * aligned body, unaligned tail.
-	 */
-	shift = (size_t)from & 0x3;
-	if (shift) {
-		chunk = min_t(size_t, 4 - shift, len);
-		data = readl_relaxed(from - shift);
-		memcpy(to, (char *)&data + shift, chunk);
-		from += chunk;
-		to += chunk;
-		len -= chunk;
-	}
-
-	while (len >= 4) {
-		data = readl_relaxed(from);
-		memcpy(to, &data, 4);
-		from += 4;
-		to += 4;
-		len -= 4;
-	}
-
-	if (len) {
-		data = readl_relaxed(from);
-		memcpy(to, &data, len);
-	}
-}
-
-static ssize_t dw_spi_bt1_dirmap_read(struct spi_mem_dirmap_desc *desc,
-				      u64 offs, size_t len, void *buf)
-{
-	struct dw_spi_bt1 *dwsbt1 = to_dw_spi_bt1(desc->mem->spi->controller);
-	struct dw_spi *dws = &dwsbt1->dws;
-	struct spi_mem *mem = desc->mem;
-	struct dw_spi_cfg cfg;
-	int ret;
-
-	/*
-	 * Make sure the requested operation length is valid. Truncate the
-	 * length if it's greater than the length of the MMIO region.
-	 */
-	if (offs >= dwsbt1->map_len || !len)
-		return 0;
-
-	len = min_t(size_t, len, dwsbt1->map_len - offs);
-
-	/* Collect the controller configuration required by the operation */
-	cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
-	cfg.dfs = 8;
-	cfg.ndf = 4;
-	cfg.freq = mem->spi->max_speed_hz;
-
-	/* Make sure the corresponding CS is de-asserted on transmission */
-	dw_spi_set_cs(mem->spi, false);
-
-	dw_spi_enable_chip(dws, 0);
-
-	dw_spi_update_config(dws, mem->spi, &cfg);
-
-	dw_spi_umask_intr(dws, DW_SPI_INT_RXFI);
-
-	dw_spi_enable_chip(dws, 1);
-
-	/*
-	 * Enable the transparent mode of the System Boot Controller.
-	 * The SPI core IO should have been locked before calling this method
-	 * so noone would be touching the controller' registers during the
-	 * dirmap operation.
-	 */
-	ret = mux_control_select(dwsbt1->mux, BT1_BOOT_DIRMAP);
-	if (ret)
-		return ret;
-
-	dw_spi_bt1_dirmap_copy_from_map(buf, dwsbt1->map + offs, len);
-
-	mux_control_deselect(dwsbt1->mux);
-
-	dw_spi_set_cs(mem->spi, true);
-
-	ret = dw_spi_check_status(dws, true);
-
-	return ret ?: len;
-}
-
-#endif /* CONFIG_SPI_DW_BT1_DIRMAP */
-
-static int dw_spi_bt1_std_init(struct platform_device *pdev,
-			       struct dw_spi_bt1 *dwsbt1)
-{
-	struct dw_spi *dws = &dwsbt1->dws;
-
-	dws->irq = platform_get_irq(pdev, 0);
-	if (dws->irq < 0)
-		return dws->irq;
-
-	dws->num_cs = 4;
-
-	/*
-	 * Baikal-T1 Normal SPI Controllers don't always keep up with full SPI
-	 * bus speed especially when it comes to the concurrent access to the
-	 * APB bus resources. Thus we have no choice but to set a constraint on
-	 * the SPI bus frequency for the memory operations which require to
-	 * read/write data as fast as possible.
-	 */
-	dws->max_mem_freq = 20000000U;
-
-	dw_spi_dma_setup_generic(dws);
-
-	return 0;
-}
-
-static int dw_spi_bt1_sys_init(struct platform_device *pdev,
-			       struct dw_spi_bt1 *dwsbt1)
-{
-	struct resource *mem __maybe_unused;
-	struct dw_spi *dws = &dwsbt1->dws;
-
-	/*
-	 * Baikal-T1 System Boot Controller is equipped with a mux, which
-	 * switches between the directly mapped SPI flash access mode and
-	 * IO access to the DW APB SSI registers. Note the mux controller
-	 * must be setup to preserve the registers being accessible by default
-	 * (on idle-state).
-	 */
-	dwsbt1->mux = devm_mux_control_get(&pdev->dev, NULL);
-	if (IS_ERR(dwsbt1->mux))
-		return PTR_ERR(dwsbt1->mux);
-
-	/*
-	 * Directly mapped SPI flash memory is a 16MB MMIO region, which can be
-	 * used to access a peripheral memory device just by reading/writing
-	 * data from/to it. Note the system APB bus will stall during each IO
-	 * from/to the dirmap region until the operation is finished. So don't
-	 * use it concurrently with time-critical tasks (like the SPI memory
-	 * operations implemented in the DW APB SSI driver).
-	 */
-#ifdef CONFIG_SPI_DW_BT1_DIRMAP
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (mem) {
-		dwsbt1->map = devm_ioremap_resource(&pdev->dev, mem);
-		if (!IS_ERR(dwsbt1->map)) {
-			dwsbt1->map_len = resource_size(mem);
-			dws->mem_ops.dirmap_create = dw_spi_bt1_dirmap_create;
-			dws->mem_ops.dirmap_read = dw_spi_bt1_dirmap_read;
-		} else {
-			dwsbt1->map = NULL;
-		}
-	}
-#endif /* CONFIG_SPI_DW_BT1_DIRMAP */
-
-	/*
-	 * There is no IRQ, no DMA and just one CS available on the System Boot
-	 * SPI controller.
-	 */
-	dws->irq = IRQ_NOTCONNECTED;
-	dws->num_cs = 1;
-
-	/*
-	 * Baikal-T1 System Boot SPI Controller doesn't keep up with the full
-	 * SPI bus speed due to relatively slow APB bus and races for it'
-	 * resources from different CPUs. The situation is worsen by a small
-	 * FIFOs depth (just 8 words). It works better in a single CPU mode
-	 * though, but still tends to be not fast enough at low CPU
-	 * frequencies.
-	 */
-	if (num_possible_cpus() > 1)
-		dws->max_mem_freq = 10000000U;
-	else
-		dws->max_mem_freq = 20000000U;
-
-	return 0;
-}
-
-static int dw_spi_bt1_probe(struct platform_device *pdev)
-{
-	dw_spi_bt1_init_cb init_func;
-	struct dw_spi_bt1 *dwsbt1;
-	struct resource *mem;
-	struct dw_spi *dws;
-	int ret;
-
-	dwsbt1 = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_bt1), GFP_KERNEL);
-	if (!dwsbt1)
-		return -ENOMEM;
-
-	dws = &dwsbt1->dws;
-
-	dws->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
-	if (IS_ERR(dws->regs))
-		return PTR_ERR(dws->regs);
-
-	dws->paddr = mem->start;
-
-	dwsbt1->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(dwsbt1->clk))
-		return PTR_ERR(dwsbt1->clk);
-
-	dws->bus_num = pdev->id;
-	dws->reg_io_width = 4;
-	dws->max_freq = clk_get_rate(dwsbt1->clk);
-	if (!dws->max_freq)
-		return -EINVAL;
-
-	init_func = device_get_match_data(&pdev->dev);
-	ret = init_func(pdev, dwsbt1);
-	if (ret)
-		return ret;
-
-	pm_runtime_enable(&pdev->dev);
-
-	ret = dw_spi_add_controller(&pdev->dev, dws);
-	if (ret) {
-		pm_runtime_disable(&pdev->dev);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, dwsbt1);
-
-	return 0;
-}
-
-static void dw_spi_bt1_remove(struct platform_device *pdev)
-{
-	struct dw_spi_bt1 *dwsbt1 = platform_get_drvdata(pdev);
-
-	dw_spi_remove_controller(&dwsbt1->dws);
-
-	pm_runtime_disable(&pdev->dev);
-}
-
-static const struct of_device_id dw_spi_bt1_of_match[] = {
-	{ .compatible = "baikal,bt1-ssi", .data = dw_spi_bt1_std_init},
-	{ .compatible = "baikal,bt1-sys-ssi", .data = dw_spi_bt1_sys_init},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, dw_spi_bt1_of_match);
-
-static struct platform_driver dw_spi_bt1_driver = {
-	.probe	= dw_spi_bt1_probe,
-	.remove = dw_spi_bt1_remove,
-	.driver	= {
-		.name		= "bt1-sys-ssi",
-		.of_match_table	= dw_spi_bt1_of_match,
-	},
-};
-module_platform_driver(dw_spi_bt1_driver);
-
-MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
-MODULE_DESCRIPTION("Baikal-T1 System Boot SPI Controller driver");
-MODULE_LICENSE("GPL v2");
-MODULE_IMPORT_NS("SPI_DW_CORE");
-- 
2.50.1

