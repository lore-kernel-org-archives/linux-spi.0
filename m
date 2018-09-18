From: Dilip Kota <dkota@codeaurora.org>
Subject: [PATCH V4 1/4] dt-bindings: soc: qcom: Remove SPI controller maximum frequency binding
Date: Tue, 18 Sep 2018 23:37:23 +0530
Message-ID: <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
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

SPI controller driver should maintain the maximum frequency
of the controller instead of relying on device tree bindings.
Because maximum frequency is specific property of SPI
controller.

Signed-off-by: Dilip Kota <dkota@codeaurora.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index 68b7d62..16467ed 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -60,7 +60,6 @@ Required properties:
 - interrupts:		Must contain SPI controller interrupts.
 - clock-names:		Must contain "se".
 - clocks:		Serial engine core clock needed by the device.
-- spi-max-frequency:	Specifies maximum SPI clock frequency, units - Hz.
 - #address-cells:	Must be <1> to define a chip select address on
 			the SPI bus.
 - #size-cells:		Must be <0>.
@@ -112,7 +111,6 @@ Example:
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&qup_1_spi_2_active>;
 			pinctrl-1 = <&qup_1_spi_2_sleep>;
-			spi-max-frequency = <19200000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
