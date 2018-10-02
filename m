From: Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v6 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date: Tue,  2 Oct 2018 14:47:07 -0700
Message-ID: <20181002214709.162330-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Girish Mahadevan <girishm@codeaurora.org>

Bindings for Qualcomm Quad SPI used on SoCs such as sdm845.

Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
Signed-off-by: Ryan Case <ryandcase@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v6:
- None

Changes in v5:
- None

Changes in v4:
- Changed qspi@ to spi@ and device@ to flash@ to match Rob's review

Changes in v3:
- Added generic compatible string in addition to specific SoC

Changes in v2:
- Added commit text
- Removed invalid property
- Updated example to match sdm845 with attached spi-nor

 .../bindings/spi/qcom,spi-qcom-qspi.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
new file mode 100644
index 000000000000..1d64b61f5171
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
@@ -0,0 +1,36 @@
+Qualcomm Quad Serial Peripheral Interface (QSPI)
+
+The QSPI controller allows SPI protocol communication in single, dual, or quad
+wire transmission modes for read/write access to slaves such as NOR flash.
+
+Required properties:
+- compatible:	An SoC specific identifier followed by "qcom,qspi-v1", such as
+		"qcom,sdm845-qspi", "qcom,qspi-v1"
+- reg:		Should contain the base register location and length.
+- interrupts:	Interrupt number used by the controller.
+- clocks:	Should contain the core and AHB clock.
+- clock-names:	Should be "core" for core clock and "iface" for AHB clock.
+
+SPI slave nodes must be children of the SPI master node and can contain
+properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+
+	qspi: spi@88df000 {
+		compatible = "qcom,sdm845-qspi", "qcom,qspi-v1";
+		reg = <0x88df000 0x600>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "iface", "core";
+		clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			 <&gcc GCC_QSPI_CORE_CLK>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <25000000>;
+			spi-tx-bus-width = <2>;
+			spi-rx-bus-width = <2>;
+		};
+	};
-- 
2.19.0.605.g01d371f741-goog
