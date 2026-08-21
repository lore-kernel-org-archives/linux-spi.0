Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135947F2CB;
	Fri, 21 Aug 2026 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309753; cv=none; b=SKIa5jA1ZyrTwTfT9xeCkECHMESsKoI3TIVod8rIkaogatpuDSiu/4tY308kbZ285rKCV8wWd0ZrkdwxJdlxueZFNzctB0Y1vmT67TRM+KB6UFmCT+TTBLma4eWnZqOhUJODOe7qAuvn/eqGry3Jh4EDZqgNOGIrhEO3wRlcgDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309753; c=relaxed/simple;
	bh=kD0hkF/VYoRaUxrYxzCU4pdTFdS33H9+0d6RZToTzPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rj08ESff4XfHyP84lVwF2iG2feQWIb37hPjYGNLM+jxlVipoBtnRRnDcjfX8O52sDi61AAEavKlOqGFfdCmVQ88odVNwszp7bRTsT1ZaHdzeb0WpZ3EIE0u3nsFIfEEpPN7t3cwZBr8GV1DX+PupXHo/zXBHyblgkFQKQdBYLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMJp6IEa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMJp6IEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787309751; x=1818845751;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=kD0hkF/VYoRaUxrYxzCU4pdTFdS33H9+0d6RZToTzPA=;
  b=jMJp6IEaotoRwrNi109ZFWiRWtNzvCvTz+4SQaWk5+TfIIRCBoT6W9ia
   oNprCbvcfmHIA6JRiqrjrqW8FgJaRsU32JB38KJipmuwOXmdWp3j8a6NV
   lT6x20GTK9bNouiqUjet11z5adJg0kDMStmWmn+PL40iNVJyhver6x6pd
   VYKdmyksmPwLwEa+Nl2GLwSGxuE/WZTpVV727csZdWLVWfuMh9mZJnhfO
   qR0TnWv3EWIDQk8vhVoUvj09k5bP5jqLaq6gXMApiN6irKp/uOLLM/GkT
   yriGskcRPSc8nzX1sO78fSfLx/Okts+18Eg1ElcYy89E2JuLfiTfASA8a
   Q==;
X-CSE-ConnectionGUID: XolWzq11RGmjZQ/zKaARog==
X-CSE-MsgGUID: sZXcV9AeS9KZvcwAYVVg6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="88060550"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88060550"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 03:55:47 -0700
X-CSE-ConnectionGUID: sEshNRS6R/W8V4egwR+cow==
X-CSE-MsgGUID: xXRFfBtnQrKHalSL4WA+bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="289841519"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2026 03:55:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1EC8E9E; Fri, 21 Aug 2026 12:55:44 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] spi: Fix the section ordering in accordance with the comment
Date: Fri, 21 Aug 2026 12:54:54 +0200
Message-ID: <20260821105541.1432348-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260821105541.1432348-1-andriy.shevchenko@linux.intel.com>
References: <20260821105541.1432348-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments in all sections tell that the list of the sections
should be alphabetically ordered. With time this went apart,
mostly for Freescale entries. So, put the things into order again.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/Kconfig | 339 ++++++++++++++++++++++----------------------
 1 file changed, 169 insertions(+), 170 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f53c0ece5d96..357cebef9917 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -91,6 +91,14 @@ config SPI_ALTERA_DFL
 	  Altera SPI master controller.  The SPI master is connected
 	  to a SPI slave to Avalon bridge in a Intel MAX BMC.
 
+config SPI_AMD
+	tristate "AMD SPI controller"
+	depends on PCI
+	depends on X86 || COMPILE_TEST
+	depends on SPI_MEM
+	help
+	  Enables SPI controller driver for AMD SoC.
+
 config SPI_AMLOGIC_SPIFC_A1
 	tristate "Amlogic A1 SPIFC controller"
 	depends on ARCH_MESON || COMPILE_TEST
@@ -135,6 +143,13 @@ config SPI_AR934X
 	  This enables support for the SPI controller present on the
 	  Qualcomm Atheros AR934X/QCA95XX SoCs.
 
+config SPI_ARMADA_3700
+	tristate "Marvell Armada 3700 SPI Controller"
+	depends on (ARCH_MVEBU && OF) || COMPILE_TEST
+	help
+	  This enables support for the SPI controller present on the
+	  Marvell Armada 3700 SoCs.
+
 config SPI_ATCSPI200
 	tristate "Andes ATCSPI200 SPI controller"
 	depends on ARCH_ANDES || COMPILE_TEST
@@ -152,13 +167,6 @@ config SPI_ATH79
 	  This enables support for the SPI controller present on the
 	  Atheros AR71XX/AR724X/AR913X SoCs.
 
-config SPI_ARMADA_3700
-	tristate "Marvell Armada 3700 SPI Controller"
-	depends on (ARCH_MVEBU && OF) || COMPILE_TEST
-	help
-	  This enables support for the SPI controller present on the
-	  Marvell Armada 3700 SoCs.
-
 config SPI_ASPEED_SMC
 	tristate "Aspeed flash controllers in SPI mode"
 	depends on ARCH_ASPEED || COMPILE_TEST
@@ -419,6 +427,22 @@ config SPI_FSI
 	  This enables support for the driver for FSI bus attached SPI
 	  controllers.
 
+config SPI_FSL_DSPI
+	tristate "Freescale DSPI controller"
+	select REGMAP_MMIO
+	depends on ARCH_MXC || ARCH_NXP || M5441x || COMPILE_TEST
+	help
+	  This enables support for the Freescale DSPI controller in master
+	  mode. S32, VF610, LS1021A and ColdFire platforms uses the controller.
+
+config SPI_FSL_ESPI
+	tristate "Freescale eSPI controller"
+	depends on FSL_SOC
+	help
+	  This enables using the Freescale eSPI controllers in master mode.
+	  From MPC8536, 85xx platform uses the controller, and all P10xx,
+	  P20xx, P30xx,P40xx, P50xx uses this controller.
+
 config SPI_FSL_LPSPI
 	tristate "Freescale i.MX LPSPI controller"
 	depends on ARCH_MXC || COMPILE_TEST
@@ -437,6 +461,26 @@ config SPI_FSL_QUADSPI
 	  This controller does not support generic SPI messages. It only
 	  supports the high-level SPI memory interface.
 
+config SPI_FSL_LIB
+	tristate
+	depends on OF
+
+config SPI_FSL_CPM
+	tristate
+	depends on FSL_SOC
+
+config SPI_FSL_SPI
+	tristate "Freescale SPI controller and Aeroflex Gaisler GRLIB SPI controller"
+	depends on OF
+	select SPI_FSL_LIB
+	select SPI_FSL_CPM if FSL_SOC
+	help
+	  This enables using the Freescale SPI controllers in master mode.
+	  MPC83xx platform uses the controller in cpu mode or CPM/QE mode.
+	  MPC8569 uses the controller in QE mode, MPC8610 in cpu mode.
+	  This also enables using the Aeroflex Gaisler GRLIB SPI controller in
+	  master mode.
+
 config SPI_GXP
 	tristate "GXP SPI driver"
 	depends on ARCH_HPE || COMPILE_TEST
@@ -462,27 +506,6 @@ config SPI_HISI_SFC_V3XX
 	  This enables support for HiSilicon v3xx SPI NOR flash controller
 	  found in hi16xx chipsets.
 
-config SPI_NXP_FLEXSPI
-	tristate "NXP Flex SPI controller"
-	depends on ARCH_LAYERSCAPE || ARCH_MXC || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This enables support for the Flex SPI controller in master mode.
-	  Up to four slave devices can be connected on two buses with two
-	  chipselects each.
-	  This controller does not support generic SPI messages and only
-	  supports the high-level SPI memory interface.
-
-config SPI_NXP_XSPI
-	tristate "NXP xSPI controller"
-	depends on ARCH_MXC || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This enables support for the xSPI controller. Up to two devices
-	  can be connected to one host.
-	  This controller does not support generic SPI messages and only
-	  supports the high-level SPI memory interface.
-
 config SPI_GPIO
 	tristate "GPIO-based bitbanging SPI Master"
 	depends on GPIOLIB || COMPILE_TEST
@@ -580,6 +603,25 @@ config SPI_KSPI2
 	  This driver can also be built as a module. If so, the module
 	  will be called spi-kspi2.
 
+config SPI_LANTIQ_SSC
+	tristate "Lantiq SSC SPI controller"
+	depends on LANTIQ || X86 || COMPILE_TEST
+	help
+	  This driver supports the Lantiq SSC SPI controller in master
+	  mode. This controller is found on Intel (former Lantiq) SoCs like
+	  the Danube, Falcon, xRX200, xRX300, Lightning Mountain.
+
+config SPI_LJCA
+	tristate "Intel La Jolla Cove Adapter SPI support"
+	depends on USB_LJCA
+	default USB_LJCA
+	help
+	  Select this option to enable SPI driver for the Intel
+	  La Jolla Cove Adapter (LJCA) board.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called spi-ljca.
+
 config SPI_LM70_LLP
 	tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
 	depends on PARPORT
@@ -625,74 +667,6 @@ config SPI_LP8841_RTC
 	  Say N here unless you plan to run the kernel on an ICP DAS
 	  LP-8x4x industrial computer.
 
-config SPI_MPC52xx
-	tristate "Freescale MPC52xx SPI (non-PSC) controller support"
-	depends on PPC_MPC52xx
-	help
-	  This drivers supports the MPC52xx SPI controller in master SPI
-	  mode.
-
-config SPI_MPC52xx_PSC
-	tristate "Freescale MPC52xx PSC SPI controller"
-	depends on PPC_MPC52xx
-	help
-	  This enables using the Freescale MPC52xx Programmable Serial
-	  Controller in master SPI mode.
-
-config SPI_MPC512x_PSC
-	tristate "Freescale MPC512x PSC SPI controller"
-	depends on PPC_MPC512x
-	help
-	  This enables using the Freescale MPC5121 Programmable Serial
-	  Controller in SPI master mode.
-
-config SPI_FSL_LIB
-	tristate
-	depends on OF
-
-config SPI_FSL_CPM
-	tristate
-	depends on FSL_SOC
-
-config SPI_FSL_SPI
-	tristate "Freescale SPI controller and Aeroflex Gaisler GRLIB SPI controller"
-	depends on OF
-	select SPI_FSL_LIB
-	select SPI_FSL_CPM if FSL_SOC
-	help
-	  This enables using the Freescale SPI controllers in master mode.
-	  MPC83xx platform uses the controller in cpu mode or CPM/QE mode.
-	  MPC8569 uses the controller in QE mode, MPC8610 in cpu mode.
-	  This also enables using the Aeroflex Gaisler GRLIB SPI controller in
-	  master mode.
-
-config SPI_FSL_DSPI
-	tristate "Freescale DSPI controller"
-	select REGMAP_MMIO
-	depends on ARCH_MXC || ARCH_NXP || M5441x || COMPILE_TEST
-	help
-	  This enables support for the Freescale DSPI controller in master
-	  mode. S32, VF610, LS1021A and ColdFire platforms uses the controller.
-
-config SPI_FSL_ESPI
-	tristate "Freescale eSPI controller"
-	depends on FSL_SOC
-	help
-	  This enables using the Freescale eSPI controllers in master mode.
-	  From MPC8536, 85xx platform uses the controller, and all P10xx,
-	  P20xx, P30xx,P40xx, P50xx uses this controller.
-
-config SPI_LJCA
-	tristate "Intel La Jolla Cove Adapter SPI support"
-	depends on USB_LJCA
-	default USB_LJCA
-	help
-	  Select this option to enable SPI driver for the Intel
-	  La Jolla Cove Adapter (LJCA) board.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called spi-ljca.
-
 config SPI_MA35D1_QSPI
 	tristate "Nuvoton MA35D1 QSPI controller"
 	depends on ARCH_MA35 || COMPILE_TEST
@@ -735,6 +709,27 @@ config SPI_MICROCHIP_CORE_SPI
 	  PolarFire SoC.
 	  If built as a module, it will be called spi-microchip-core-spi.
 
+config SPI_MPC52xx
+	tristate "Freescale MPC52xx SPI (non-PSC) controller support"
+	depends on PPC_MPC52xx
+	help
+	  This drivers supports the MPC52xx SPI controller in master SPI
+	  mode.
+
+config SPI_MPC52xx_PSC
+	tristate "Freescale MPC52xx PSC SPI controller"
+	depends on PPC_MPC52xx
+	help
+	  This enables using the Freescale MPC52xx Programmable Serial
+	  Controller in master SPI mode.
+
+config SPI_MPC512x_PSC
+	tristate "Freescale MPC512x PSC SPI controller"
+	depends on PPC_MPC512x
+	help
+	  This enables using the Freescale MPC5121 Programmable Serial
+	  Controller in SPI master mode.
+
 config SPI_MT65XX
 	tristate "MediaTek SPI controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
@@ -770,6 +765,19 @@ config SPI_MTK_SNFI
 	  is implemented as a SPI-MEM controller with pipelined ECC
 	  capability.
 
+config SPI_MXIC
+	tristate "Macronix MX25F0A SPI controller"
+	imply MTD_NAND_ECC_MXIC
+	help
+	  This selects the Macronix MX25F0A SPI controller driver.
+
+config SPI_MXS
+	tristate "Freescale MXS SPI controller"
+	depends on ARCH_MXS
+	select STMP_DEVICE
+	help
+	  SPI driver for Freescale MXS devices.
+
 config SPI_WPCM_FIU
 	tristate "Nuvoton WPCM450 Flash Interface Unit"
 	depends on ARCH_NPCM || COMPILE_TEST
@@ -798,13 +806,26 @@ config SPI_NPCM_PSPI
 	  This driver provides support for Nuvoton NPCM BMC
 	  Peripheral SPI controller in master mode.
 
-config SPI_LANTIQ_SSC
-	tristate "Lantiq SSC SPI controller"
-	depends on LANTIQ || X86 || COMPILE_TEST
+config SPI_NXP_FLEXSPI
+	tristate "NXP Flex SPI controller"
+	depends on ARCH_LAYERSCAPE || ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
-	  This driver supports the Lantiq SSC SPI controller in master
-	  mode. This controller is found on Intel (former Lantiq) SoCs like
-	  the Danube, Falcon, xRX200, xRX300, Lightning Mountain.
+	  This enables support for the Flex SPI controller in master mode.
+	  Up to four slave devices can be connected on two buses with two
+	  chipselects each.
+	  This controller does not support generic SPI messages and only
+	  supports the high-level SPI memory interface.
+
+config SPI_NXP_XSPI
+	tristate "NXP xSPI controller"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This enables support for the xSPI controller. Up to two devices
+	  can be connected to one host.
+	  This controller does not support generic SPI messages and only
+	  supports the high-level SPI memory interface.
 
 config SPI_OC_TINY
 	tristate "OpenCores tiny SPI"
@@ -835,14 +856,6 @@ config SPI_OMAP24XX
 	  SPI master controller for OMAP24XX and later Multichannel SPI
 	  (McSPI) modules.
 
-config SPI_TI_QSPI
-	tristate "DRA7xxx QSPI controller support"
-	depends on ARCH_OMAP2PLUS || COMPILE_TEST
-	help
-	  QSPI master controller for DRA7xxx used for flash devices.
-	  This device supports single, dual and quad read support, while
-	  it only supports single write mode.
-
 config SPI_ORION
 	tristate "Orion SPI master"
 	depends on PLAT_ORION || ARCH_MVEBU || COMPILE_TEST
@@ -1031,12 +1044,14 @@ config SPI_SC18IS602
 	help
 	  SPI driver for NXP SC18IS602/602B/603 I2C to SPI bridge.
 
-config SPI_SH_MSIOF
-	tristate "SuperH MSIOF SPI controller"
-	depends on HAVE_CLK
-	depends on ARCH_SHMOBILE || ARCH_RENESAS || COMPILE_TEST
+config SPI_SG2044_NOR
+	tristate "SG2044 SPI NOR Controller"
+	depends on ARCH_SOPHGO || COMPILE_TEST
 	help
-	  SPI driver for SuperH and SH Mobile MSIOF blocks.
+	  This enables support for the SG2044 SPI NOR controller,
+	  which supports Dual/Quad read and write operations while
+	  also supporting 3Byte address devices and 4Byte address
+	  devices.
 
 config SPI_SH
 	tristate "SuperH SPI controller"
@@ -1044,6 +1059,19 @@ config SPI_SH
 	help
 	  SPI driver for SuperH SPI blocks.
 
+config SPI_SH_HSPI
+	tristate "SuperH HSPI controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	help
+	  SPI driver for SuperH HSPI blocks.
+
+config SPI_SH_MSIOF
+	tristate "SuperH MSIOF SPI controller"
+	depends on HAVE_CLK
+	depends on ARCH_SHMOBILE || ARCH_RENESAS || COMPILE_TEST
+	help
+	  SPI driver for SuperH and SH Mobile MSIOF blocks.
+
 config SPI_SH_SCI
 	tristate "SuperH SCI SPI controller"
 	depends on SUPERH
@@ -1051,28 +1079,12 @@ config SPI_SH_SCI
 	help
 	  SPI driver for SuperH SCI blocks.
 
-config SPI_SH_HSPI
-	tristate "SuperH HSPI controller"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	help
-	  SPI driver for SuperH HSPI blocks.
-
 config SPI_SIFIVE
 	tristate "SiFive SPI controller"
 	depends on HAS_IOMEM
 	help
 	  This exposes the SPI controller IP from SiFive.
 
-config SPI_SLAVE_MT27XX
-	tristate "MediaTek SPI slave device"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on SPI_SLAVE
-	help
-	  This selects the MediaTek(R) SPI slave device driver.
-	  If you want to use MediaTek(R) SPI slave interface,
-	  say Y or M here.If you are not sure, say N.
-	  SPI slave drivers for Mediatek MT27XX series ARM SoCs.
-
 config SPI_SN_F_OSPI
 	tristate "Socionext F_OSPI SPI flash controller"
 	depends on OF && HAS_IOMEM
@@ -1082,15 +1094,6 @@ config SPI_SN_F_OSPI
 	  for connecting an SPI Flash memory over up to 8-bit wide bus.
 	  It supports indirect access mode only.
 
-config SPI_SG2044_NOR
-	tristate "SG2044 SPI NOR Controller"
-	depends on ARCH_SOPHGO || COMPILE_TEST
-	help
-	  This enables support for the SG2044 SPI NOR controller,
-	  which supports Dual/Quad read and write operations while
-	  also supporting 3Byte address devices and 4Byte address
-	  devices.
-
 config SPI_SPACEMIT_K1
 	tristate "K1 SPI Controller"
 	depends on ARCH_SPACEMIT || COMPILE_TEST
@@ -1185,19 +1188,6 @@ config SPI_SYNQUACER
 
 	  It also supports the new dual-bit and quad-bit SPI protocol.
 
-config SPI_MXIC
-	tristate "Macronix MX25F0A SPI controller"
-	imply MTD_NAND_ECC_MXIC
-	help
-	  This selects the Macronix MX25F0A SPI controller driver.
-
-config SPI_MXS
-	tristate "Freescale MXS SPI controller"
-	depends on ARCH_MXS
-	select STMP_DEVICE
-	help
-	  SPI driver for Freescale MXS devices.
-
 config SPI_TEGRA210_QUAD
 	tristate "NVIDIA Tegra QSPI Controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
@@ -1239,6 +1229,23 @@ config SPI_THUNDERX
 	  SPI host driver for the hardware found on Cavium ThunderX
 	  SOCs.
 
+config SPI_TI_QSPI
+	tristate "DRA7xxx QSPI controller support"
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	help
+	  QSPI master controller for DRA7xxx used for flash devices.
+	  This device supports single, dual and quad read support, while
+	  it only supports single write mode.
+
+config SPI_TLE62X0
+	tristate "Infineon TLE62X0 (for power switching)"
+	depends on SYSFS
+	help
+	  SPI driver for Infineon TLE62X0 series line driver chips,
+	  such as the TLE6220, TLE6230 and TLE6240.  This provides a
+	  sysfs interface, with each line presented as a kind of GPIO
+	  exposing both switch control and diagnostic feedback.
+
 config SPI_TOPCLIFF_PCH
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) SPI"
 	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
@@ -1331,14 +1338,6 @@ config SPI_ZYNQMP_GQSPI
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
 	  This controller only supports SPI memory interface.
 
-config SPI_AMD
-	tristate "AMD SPI controller"
-	depends on PCI
-	depends on X86 || COMPILE_TEST
-	depends on SPI_MEM
-	help
-	  Enables SPI controller driver for AMD SoC.
-
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
@@ -1387,15 +1386,6 @@ config SPI_LOOPBACK_TEST
 	  primarily used for development of spi_master drivers
 	  and to detect regressions
 
-config SPI_TLE62X0
-	tristate "Infineon TLE62X0 (for power switching)"
-	depends on SYSFS
-	help
-	  SPI driver for Infineon TLE62X0 series line driver chips,
-	  such as the TLE6220, TLE6230 and TLE6240.  This provides a
-	  sysfs interface, with each line presented as a kind of GPIO
-	  exposing both switch control and diagnostic feedback.
-
 #
 # Add new SPI protocol masters in alphabetical order above this line
 #
@@ -1426,6 +1416,15 @@ config SPI_SLAVE_SYSTEM_CONTROL
 	  SPI slave handler to allow remote control of system reboot, power
 	  off, halt, and suspend.
 
+config SPI_SLAVE_MT27XX
+	tristate "MediaTek SPI slave device"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  This selects the MediaTek(R) SPI slave device driver.
+	  If you want to use MediaTek(R) SPI slave interface,
+	  say Y or M here.If you are not sure, say N.
+	  SPI slave drivers for Mediatek MT27XX series ARM SoCs.
+
 endif # SPI_SLAVE
 
 config SPI_DYNAMIC
-- 
2.50.1

