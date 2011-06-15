From: dirk.brandewie@gmail.com
Subject: [PATCH 1/5] spi/makefile:  Fix typo from reorganize drivers patch.
Date: Wed, 15 Jun 2011 10:23:04 -0700
Message-ID: <1308158588-17249-2-git-send-email-dirk.brandewie@gmail.com>
References: <1308158588-17249-1-git-send-email-dirk.brandewie@gmail.com>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
To: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308158588-17249-1-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Dirk Brandewie <dirk.brandewie@gmail.com>

Fix Makefile to build designware driver.

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/spi/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index f6d5018..b60b04b 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
 obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
 obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
 obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-midpci.o
-spi_dw_midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
+spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
 obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
 obj-$(CONFIG_SPI_FSL_LIB)		+= spi-fsl-lib.o
 obj-$(CONFIG_SPI_FSL_ESPI)		+= spi-fsl-espi.o
-- 
1.7.3.4
