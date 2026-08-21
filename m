Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B884756C3;
	Fri, 21 Aug 2026 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309751; cv=none; b=n1G9k6P3lDyrbR4EN93+PSzYsWdXDungNXA0l+m7mK1Rz8mjHNNnKSgPZpnzTZ4CeEV4EbTrhCk2bwpXXHRqri2wx8LBRX3PuiaDU/7AIVHJ+IR4R33MriKxjE14p2bXC+bFLF+sp83UQxqzwUxv23Xv6wCpS3p4bnu+eUts/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309751; c=relaxed/simple;
	bh=UMugOGhOKh4jgBuiFSKv7D4spZhnr3vx7Ljmpt+dF5Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql5vKA9txFxIpkJAqgiZPoNZ0acT6RhgZ/XZLJqAAGfBmPSGxFrgjeanvs6aL+fOa13vJpmdwnZB2sDfQg5dCHiPHC32qgudhSaRO5y9HQ5cTVnWgfToCb9tZivm5V89KbycFQ7oXuWWzNIZII9iQoV5I0mxPjpxH3mpF2Cymy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ck19p2F4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ck19p2F4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787309750; x=1818845750;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=UMugOGhOKh4jgBuiFSKv7D4spZhnr3vx7Ljmpt+dF5Y=;
  b=Ck19p2F4MqjdDPK+EFEzRWaTIRnY17qSV5Vm3ZVQw0Xwx3gQ4+jiRpyk
   vduo9JhR864VdTmoWy0L3Q++cKu8TQNuUcOe7JJ68AZL/0CyJ4bxmF5me
   4vOmr5Osp33USr8Ip4v0MJvfm5hg0cVyH7Na6KmvSJ/GuuNRemLP8PJdU
   ZOnXvm7Nks9Q3jscA8DcxZ3fMc1e64Rmao6E2Nr2Yvx1zZM5fgHWslk1Q
   M5jD2ywWCzYPII4pWqxEim9QMDUGMUeSFZ6HOXcc4NtGrbgYagRBVmNVd
   ns6L64DdSY+jl36g8IFiNoP743kXbXuGN4E2a1rEh7+VIHiY2apake11G
   A==;
X-CSE-ConnectionGUID: wlCMYOKuSQSYKyzdWlE5bA==
X-CSE-MsgGUID: fQzKiQLGROKKIn7QKiULKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="88060549"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88060549"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 03:55:47 -0700
X-CSE-ConnectionGUID: h8fa1ah8SdekFLn7X0oL1Q==
X-CSE-MsgGUID: fscJWK4zSVGZvYuVWIsmXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="289841518"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2026 03:55:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1B12F9D; Fri, 21 Aug 2026 12:55:44 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] spi: Drop redundant dependency on SPI_MASTER
Date: Fri, 21 Aug 2026 12:54:53 +0200
Message-ID: <20260821105541.1432348-3-andriy.shevchenko@linux.intel.com>
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

The sections defined under 'if SPI_MASTER' already imply that
the SPI_MASTER is selected. Drop redundant dependencies.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/Kconfig | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 93c3d9e1416a..f53c0ece5d96 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -63,7 +63,6 @@ comment "SPI Master Controller Drivers"
 config SPI_AIROHA_SNFI
 	tristate "Airoha SPI NAND Flash Interface"
 	depends on ARCH_AIROHA || COMPILE_TEST
-	depends on SPI_MASTER
 	select REGMAP_MMIO
 	help
 	  This enables support for SPI-NAND mode on the Airoha NAND
@@ -333,7 +332,7 @@ config SPI_CADENCE_XSPI
 
 config SPI_CH341
 	tristate "CH341 USB2SPI adapter"
-	depends on SPI_MASTER && USB
+	depends on USB
 	help
 	  Enables the SPI controller on the CH341a USB to serial chip
 
@@ -722,7 +721,6 @@ config SPI_MESON_SPIFC
 
 config SPI_MICROCHIP_CORE_QSPI
 	tristate "Microchip FPGA QSPI controllers"
-	depends on SPI_MASTER
 	help
 	  This enables the QSPI driver for Microchip FPGA QSPI controllers.
 	  Say Y or M here if you want to use the QSPI controllers on
@@ -731,7 +729,6 @@ config SPI_MICROCHIP_CORE_QSPI
 
 config SPI_MICROCHIP_CORE_SPI
 	tristate "Microchip FPGA CoreSPI controller"
-	depends on SPI_MASTER
 	help
 	  This enables the SPI driver for Microchip FPGA CoreSPI controller.
 	  Say Y or M here if you want to use the "soft" controllers on
@@ -887,7 +884,6 @@ config SPI_PL022
 
 config SPI_POLARFIRE_SOC
 	tristate "Microchip FPGA SPI controllers"
-	depends on SPI_MASTER
 	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  This enables the SPI driver for Microchip FPGA SPI controllers.
@@ -950,7 +946,7 @@ config SPI_ROCKCHIP_SFC
 
 config SPI_RB4XX
 	tristate "Mikrotik RB4XX SPI master"
-	depends on SPI_MASTER && (ATH79 || COMPILE_TEST)
+	depends on ATH79 || COMPILE_TEST
 	depends on OF
 	help
 	  SPI controller driver for the Mikrotik RB4xx series boards.
@@ -1191,7 +1187,6 @@ config SPI_SYNQUACER
 
 config SPI_MXIC
 	tristate "Macronix MX25F0A SPI controller"
-	depends on SPI_MASTER
 	imply MTD_NAND_ECC_MXIC
 	help
 	  This selects the Macronix MX25F0A SPI controller driver.
@@ -1270,7 +1265,7 @@ config SPI_UNIPHIER
 
 config SPI_VIRTIO
 	tristate "Virtio SPI Controller"
-	depends on SPI_MASTER && VIRTIO
+	depends on VIRTIO
 	help
 	  If you say yes to this option, support will be included for the virtio
 	  SPI controller driver. The hardware can be emulated by any device model
@@ -1339,7 +1334,7 @@ config SPI_ZYNQMP_GQSPI
 config SPI_AMD
 	tristate "AMD SPI controller"
 	depends on PCI
-	depends on SPI_MASTER || X86 || COMPILE_TEST
+	depends on X86 || COMPILE_TEST
 	depends on SPI_MEM
 	help
 	  Enables SPI controller driver for AMD SoC.
-- 
2.50.1

