From: yibin.gong@nxp.com
Subject: [PATCH v5 14/15]  arm64: defconfig: Enable SDMA on i.mx8mq/8mm
Date: Mon, 10 Jun 2019 16:17:52 +0800
Message-ID: <20190610081753.11422-15-yibin.gong@nxp.com>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, broonie@kernel.org,
        festevam@gmail.com, vkoul@kernel.org, dan.j.williams@intel.com,
        u.kleine-koenig@pengutronix.de, catalin.marinas@arm.com,
        l.stach@pengutronix.de, will.deacon@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610081753.11422-1-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Enable SDMA support on i.mx8mq/8mm chips, including enabling
CONFIG_FW_LOADER_USER_HELPER/CONFIG_FW_LOADER_USER_HELPER_FALLBACK
for firmware loaded by udev.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bb0705e..e8aabc52 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -195,6 +195,8 @@ CONFIG_PCIE_HISI_STB=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_FW_LOADER_USER_HELPER=y
+CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_MTD=y
@@ -627,6 +629,7 @@ CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
 CONFIG_DMA_BCM2835=m
+CONFIG_IMX_SDMA=y
 CONFIG_K3_DMA=y
 CONFIG_MV_XOR=y
 CONFIG_MV_XOR_V2=y
-- 
2.7.4
