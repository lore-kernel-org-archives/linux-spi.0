From: kernel@martin.sperl.org
Subject: [PATCH v5 2/6] ARM: bcm2835: add DT for the bcm2835 auxiliar devices
Date: Fri,  4 Sep 2015 09:41:46 +0000
Message-ID: <1441359711-2800-3-git-send-email-kernel@martin.sperl.org>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>,
 Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
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

From: Martin Sperl <kernel@martin.sperl.org>

Add device tree definitions for auxiliar bcm2835 devices:
* spi1
* spi2
* uart1

This also include a device to get used by the relevant
device-drivers (via a shared register) to enable/disable
the HW-block.

The aux-interrupt-register (0x7e21500) is intentionally left
out of scope, so that in the future it is still possible to
implement a separate interrupt-driver - if deemed necessary.

The spi (and also uart) drivers are able to use shared interrupts,
so there is no real need for an interrupt driver.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..4e6fc61 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -158,6 +158,43 @@
 		arm-pmu {
 			compatible = "arm,arm1176-pmu";
 		};
+
+		aux_enable: aux_enable@0x7e215004 {
+			compatible = "brcm,bcm2835-aux";
+			reg = <0x7e215004 0x04>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		uart1: uart@7e215040 {
+			compatible = "brcm,bcm2835-aux-uart";
+			reg = <0x7e215040 0x40>;
+			interrupts = <1 29>;
+			brcm,aux-enable = <&aux_enable 1>;
+			status = "disabled";
+		};
+
+		spi1: spi@7e215080 {
+			compatible = "brcm,bcm2835-aux-spi";
+			reg = <0x7e215080 0x40>;
+			brcm,aux-enable = <&aux_enable 2>;
+			interrupts = <1 29>;
+			clocks = <&clk_spi>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi2: spi@7e2150c0 {
+			compatible = "brcm,bcm2835-aux-spi";
+			reg = <0x7e2150c0 0x40>;
+			brcm,aux-enable = <&aux_enable 4>;
+			interrupts = <1 29>;
+			clocks = <&clk_spi>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};

 	clocks {
--
1.7.10.4
