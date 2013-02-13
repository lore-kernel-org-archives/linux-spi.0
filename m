From: Girish K S <girishks2000@gmail.com>
Subject: [PATCH V2 0/5]  Add polling support for 64xx spi controller
Date: Wed, 13 Feb 2013 11:25:26 -0800
Message-ID: <1360783531-32654-1-git-send-email-ks.giri@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca,
	t.figa@samsung.com, broonie@opensource.wolfsonmicro.com
To: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

[PATCH 1/5]: fixes the error handling in the interrupt handler
[PATCH 2/5]: The existing driver support partial polling mode.
	     This patch modifies the current driver to support
	     only polling mode.
[PATCH 3/5]: provision to support SoC's with dedicated i/o pins
[PATCH 4/5]: provision to support dedicated cs pin
[PATCH 5/5]: support exynos5440 SoC in polling mode

Tested this patch on exynos5250 in dma mode, and exynos5440 in
polling mode.

Girish K S (5):
  spi: s3c64xx: modified error interrupt handling and init
  spi: s3c64xx: added support for polling mode
  spi: s3c64xx: Added provision for non-gpio i/o's
  spi: s3c64xx: Added provision for dedicated cs pin
  spi: s3c64xx: Added support for exynos5440 spi

 drivers/spi/spi-s3c64xx.c                 |  216 ++++++++++++++++++++---------
 include/linux/platform_data/spi-s3c64xx.h |    3 +
 2 files changed, 155 insertions(+), 64 deletions(-)

-- 
1.7.10.4
