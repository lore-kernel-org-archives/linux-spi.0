From: Dilip Kota <dkota@codeaurora.org>
Subject: [PATCH V4 2/4] dt-bindings: soc: qcom: GENI SE SPI controller device tree binding
Date: Tue, 18 Sep 2018 23:37:24 +0530
Message-ID: <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
To: swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Move GENI SE SPI controller device-tree bindings
from devicetree/bindings/soc/qcom/qcom,geni-se.txt
to devicetree/bindings/spi/qcom,spi-geni-qcom.txt.

Signed-off-by: Dilip Kota <dkota@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 27 ++-------------
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt | 39 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index 16467ed..f0fbeda 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -53,19 +53,8 @@ Required properties:
 - clocks:		Serial engine core clock needed by the device.
 
 Qualcomm Technologies Inc. GENI Serial Engine based SPI Controller
-
-Required properties:
-- compatible:		Must contain "qcom,geni-spi".
-- reg:			Must contain SPI register location and length.
-- interrupts:		Must contain SPI controller interrupts.
-- clock-names:		Must contain "se".
-- clocks:		Serial engine core clock needed by the device.
-- #address-cells:	Must be <1> to define a chip select address on
-			the SPI bus.
-- #size-cells:		Must be <0>.
-
-SPI slave nodes must be children of the SPI master node and conform to SPI bus
-binding as described in Documentation/devicetree/bindings/spi/spi-bus.txt.
+node binding is described in
+Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt.
 
 Example:
 	geniqup@8c0000 {
@@ -102,16 +91,4 @@ Example:
 			pinctrl-1 = <&qup_1_uart_3_sleep>;
 		};
 
-		spi0: spi@a84000 {
-			compatible = "qcom,geni-spi";
-			reg = <0xa84000 0x4000>;
-			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "se";
-			clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&qup_1_spi_2_active>;
-			pinctrl-1 = <&qup_1_spi_2_sleep>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
 	}
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
new file mode 100644
index 0000000..790311a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
@@ -0,0 +1,39 @@
+GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
+
+The QUP v3 core is a GENI based AHB slave that provides a common data path
+(an output FIFO and an input FIFO) for serial peripheral interface (SPI)
+mini-core.
+
+SPI in master mode supports up to 50MHz, up to four chip selects, programmable
+data path from 4 bits to 32 bits and numerous protocol variants.
+
+Required properties:
+- compatible:		Must contain "qcom,geni-spi".
+- reg:			Must contain SPI register location and length.
+- interrupts:		Must contain SPI controller interrupts.
+- clock-names:		Must contain "se".
+- clocks:		Serial engine core clock needed by the device.
+- #address-cells:	Must be <1> to define a chip select address on
+			the SPI bus.
+- #size-cells:		Must be <0>.
+
+SPI Controller nodes must be child of GENI based Qualcomm Universal
+Peripharal. Please refer GENI based QUP wrapper controller node bindings
+described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt.
+
+SPI slave nodes must be children of the SPI master node and conform to SPI bus
+binding as described in Documentation/devicetree/bindings/spi/spi-bus.txt.
+
+Example:
+	spi0: spi@a84000 {
+		compatible = "qcom,geni-spi";
+		reg = <0xa84000 0x4000>;
+		interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "se";
+		clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&qup_1_spi_2_active>;
+		pinctrl-1 = <&qup_1_spi_2_sleep>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
