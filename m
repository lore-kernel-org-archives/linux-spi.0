From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 2/4] spi: st: Provide Device Tree binding documentation
Date: Tue,  2 Dec 2014 15:40:42 +0000
Message-ID: <1417534844-25080-3-git-send-email-lee.jones@linaro.org>
References: <1417534844-25080-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, broonie@kernel.org, lee.jones@linaro.org,
 kernel@stlinux.com, linux-spi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1417534844-25080-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This patch adds DT documentation for the SPI portion of ST's SSC device.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-st.txt | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-st.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-st.txt b/Documentation/devicetree/bindings/spi/spi-st.txt
new file mode 100644
index 0000000..fe54959
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-st.txt
@@ -0,0 +1,40 @@
+STMicroelectronics SSC (SPI) Controller
+---------------------------------------
+
+Required properties:
+- compatible	: "st,comms-ssc4-spi"
+- reg		: Offset and length of the device's register set
+- interrupts	: The interrupt specifier
+- clock-names	: Must contain "ssc"
+- clocks	: Must contain an entry for each name in clock-names
+		    See ../clk/*
+- pinctrl-names	: Uses "default", can use "sleep" if provided
+		    See ../pinctrl/pinctrl-binding.txt
+
+Optional properties:
+- cs-gpios	: List of GPIO chip selects
+		    See ../spi/spi-bus.txt
+
+Child nodes represent devices on the SPI bus
+  See ../spi/spi-bus.txt
+
+Example:
+	spi@9840000 {
+		compatible	= "st,comms-ssc4-spi";
+		reg		= <0x9840000 0x110>;
+		interrupts	= <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		clocks		= <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+		clock-names	= "ssc";
+		pinctrl-0	= <&pinctrl_spi0_default>;
+		pinctrl-names	= "default";
+		cs-gpios	= <&pio17 5 0>;
+		#address-cells	= <1>;
+		#size-cells	= <0>;
+
+		st95hf@0{
+			compatible		= "st,st95hf";
+			reg			= <0>;
+			spi-max-frequency	= <1000000>;
+			interrupts		= <2 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
-- 
1.9.1
