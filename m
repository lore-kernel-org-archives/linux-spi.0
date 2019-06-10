From: yibin.gong@nxp.com
Subject: [PATCH v5 12/15] ARM: dts: imx6ul: add dma support on ecspi
Date: Mon, 10 Jun 2019 16:17:50 +0800
Message-ID: <20190610081753.11422-13-yibin.gong@nxp.com>
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

Add dma support on ecspi.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index fc388b8..4a34316 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -227,6 +227,8 @@
 					clocks = <&clks IMX6UL_CLK_ECSPI1>,
 						 <&clks IMX6UL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -239,6 +241,8 @@
 					clocks = <&clks IMX6UL_CLK_ECSPI2>,
 						 <&clks IMX6UL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -251,6 +255,8 @@
 					clocks = <&clks IMX6UL_CLK_ECSPI3>,
 						 <&clks IMX6UL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -263,6 +269,8 @@
 					clocks = <&clks IMX6UL_CLK_ECSPI4>,
 						 <&clks IMX6UL_CLK_ECSPI4>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
-- 
2.7.4
