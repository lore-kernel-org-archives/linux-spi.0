From: Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH V5 1/3] dt-bindings: soc: qcom: Remove SPI controller maximum frequency binding
Date: Wed,  3 Oct 2018 19:14:23 +0530
Message-ID: <1538574265-30235-2-git-send-email-alokc@codeaurora.org>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
To: swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Dilip Kota <dkota@codeaurora.org>

SPI controller driver should maintain the maximum frequency
of the controller instead of relying on device tree bindings.
Because maximum frequency is specific property of SPI
controller.

Signed-off-by: Dilip Kota <dkota@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index ff92e5a..b9d0c21 100644
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
