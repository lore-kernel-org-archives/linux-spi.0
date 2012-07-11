From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v5 0/6] spi: s3c64xx: add support for device tree
Date: Wed, 11 Jul 2012 21:10:59 +0530
Message-ID: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
Cc: broonie@opensource.wolfsonmicro.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Changes since v4:
- Includes the missing gpio request for slave select line gpio as suggested
  by Mark Brown.

Changes since v3:
- Fixed the build breakage after applying 3rd patch in this series (which
  had dependency on the 6th patch). This was reported by Doug Anderson.

Changes since v2:
- Removed renaming of platform device name at runtime
- Includes other minor fixes suggested by Olof, Grant, Kukjin and Abhilash.
- Rebased to Linux 3.5-rc1

Changes since v1:
- Incorporated changes suggested by Mark Brown
 - Merged 2nd, 3rd and 5th patch into one single patch.
 - Listed the order of gpios in the device tree support documentation.
 - Switched to generic property names for chip select gpio line and
   number of slave select lines.
- Moved the platform enablement patches for Exynos4 and Exynos5 into a
 different patch series.
- Included Ack from Jaswinder Singh <jaswinder.singh@linaro.org>.

This patch series adds device tree based discovery support for Samsung's
s3c64xx compatible spi controller. This is mainly tested for Exynos4210
and Exynos5250 with onboard spi nor flash device.

The patch series (6 patches) that add board/platform specific support has
no changes since the v2 version. This series is available at:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/100812.html
