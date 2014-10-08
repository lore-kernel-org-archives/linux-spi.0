From: Weike Chen <alvin.chen@intel.com>
Subject: [PATCH 0/2 v3] SPI: spi-pxa2xx: Add support for Intel Quark X1000 SPI controller
Date: Wed,  8 Oct 2014 08:50:21 -0700
Message-ID: <1412783423-9408-1-git-send-email-alvin.chen@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@intel.com>,
	Hock Leong Kweh <hock.leong.kweh@intel.com>,
	Boon Leong Ong <boon.leong.ong@intel.com>,
	Raymond Tan <raymond.tan@intel.com>,
	Alvin Chen <alvin.chen@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eric Miao <eric.y.miao@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,
Intel Quark X1000 consists of two SPI controllers which can be PCI enumerated.
SPI-PXA2XX PCI layer doesn't support it. Thus, we add support for Intel Quark
X1000 SPI as well.

---
v3:
[PATCH 1/2]
* Improve the commit message.
* A couple of minor fixes.
[PATCH 2/2]
* Set '.num_chipselect' to '1' instead of '4'.
* A couple of minor fixes.

v2:
  Split into two patches: one is for helper functions,
  and another is for quark supporting.

[PATCH 1/2]
* Add helper functions to access registers.
* Use 'switch' instead of 'if-else'.
[PATCH 2/2]
* Use 'switch' instead of 'if-else'.
* Add comments for the 'dds'&'clk_div' caculation.
* A couple of minor fixes.

Weike Chen (2):
  SPI: spi-pxa2xx: Add helpers for regiseters' accessing
  SPI: spi-pxa2xx: SPI support for Intel Quark X1000

 drivers/spi/spi-pxa2xx-pci.c |    8 ++
 drivers/spi/spi-pxa2xx.c     |  304 ++++++++++++++++++++++++++++++++++++------
 drivers/spi/spi-pxa2xx.h     |   16 ++-
 include/linux/pxa2xx_ssp.h   |   21 +++
 4 files changed, 304 insertions(+), 45 deletions(-)

-- 
1.7.9.5
