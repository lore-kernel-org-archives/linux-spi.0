From: Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH 6/6] arm64: dts: sc7180: Add interconnect for QUP and QSPI
Date: Mon, 17 Feb 2020 19:00:05 +0530
Message-ID: <1581946205-27189-7-git-send-email-akashast@codeaurora.org>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
Cc: linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, Akash Asthana <akashast@codeaurora.org>
To: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add interconnect ports for GENI QUPs and QSPI to set bus capabilities.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
Note:
 - This patch depends on series https://patchwork.kernel.org/cover/11313817/
   [Add SC7180 interconnect provider driver]. It won't compile without that.

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 199 +++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index cc5a94f..04569c9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -352,6 +352,14 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -365,6 +373,11 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -376,6 +389,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart0_default>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -389,6 +407,14 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -402,6 +428,11 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -413,6 +444,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart1_default>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -426,6 +462,14 @@
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -437,6 +481,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart2_default>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -450,6 +499,14 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -463,6 +520,11 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -474,6 +536,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart3_default>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -487,6 +554,14 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -498,6 +573,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart4_default>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -511,6 +591,14 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -524,6 +612,11 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -535,6 +628,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart5_default>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0
+						&qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 		};
@@ -561,6 +659,14 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -574,6 +680,11 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -585,6 +696,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -598,6 +714,14 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -609,6 +733,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_default>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -622,6 +751,14 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -635,6 +772,11 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -646,6 +788,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart8_default>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -659,6 +806,14 @@
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -670,6 +825,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -683,6 +843,14 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -696,6 +864,11 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -707,6 +880,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart10_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -720,6 +898,14 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1
+						&mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -733,6 +919,11 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -744,6 +935,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart11_default>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1
+						&qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC
+						&config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 		};
@@ -1051,6 +1247,9 @@
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
+			interconnects = <&gem_noc MASTER_APPSS_PROC
+					&config_noc SLAVE_QSPI_0>;
+			interconnect-names = "qspi-config";
 			status = "disabled";
 		};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
