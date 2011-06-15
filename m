From: dirk.brandewie@gmail.com
Subject: [PATCH 0/5] Designware SPI driver update
Date: Wed, 15 Jun 2011 10:23:03 -0700
Message-ID: <1308158588-17249-1-git-send-email-dirk.brandewie@gmail.com>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
To: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch set reworks the Designware SPI driver. This patch set is
based on commit f8f82d4 on spi/next

Patch 1:
      Fixes trivial typo from commit f8f82d4 in spi/next

Patch 2:
      exports the platform data structure for client driver use.

Patch 3:
      Reworks the core message and transfer handling.

Patch 4:
      Changes internal function naming convention to match new file
      names.

Patch 5:
      Adds runtime power management to the PCI driver.



Dirk Brandewie (5):
  spi/makefile:  Fix typo from reorganize drivers patch.
  spi/dw_spi: expose dw_spi platform data stucture.
  dw_spi: rework message processing
  spi/spi-dw: update function naming convention
  spi_dw_pci: Add runtime power management

 drivers/spi/Makefile       |    2 +-
 drivers/spi/spi-dw-mid.c   |   47 +-
 drivers/spi/spi-dw-mmio.c  |   34 +-
 drivers/spi/spi-dw-pci.c   |   69 ++-
 drivers/spi/spi-dw.c       | 1674 +++++++++++++++++++-------------------------
 drivers/spi/spi-dw.h       |  138 ++--
 include/linux/spi/spi-dw.h |   20 +
 7 files changed, 930 insertions(+), 1054 deletions(-)
 rewrite drivers/spi/spi-dw.c (62%)
 create mode 100644 include/linux/spi/spi-dw.h

-- 
1.7.3.4
