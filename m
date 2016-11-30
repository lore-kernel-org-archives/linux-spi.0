From: Romain Perier <romain.perier@free-electrons.com>
Subject: [PATCH v2 3/5] dt-bindings: spi: Add documentation for the Armada
 3700 SPI Controller
Date: Wed, 30 Nov 2016 10:43:49 +0100
Message-ID: <20161130094351.2748-4-romain.perier@free-electrons.com>
References: <20161130094351.2748-1-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>,
 devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Kumar Gala <galak@codeaurora.org>,
 Gregory Clement <gregory.clement@free-electrons.com>, xigu@marvell.com,
 dingwei@marvell.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161130094351.2748-1-romain.perier@free-electrons.com>
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

This adds the devicetree bindings documentation for the SPI controller
present in the Marvell Armada 3700 SoCs.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 .../devicetree/bindings/spi/spi-armada-3700.txt    | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-armada-3700.txt b/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
new file mode 100644
index 0000000..1564aa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
@@ -0,0 +1,25 @@
+* Marvell Armada 3700 SPI Controller
+
+Required Properties:
+
+- compatible: should be "marvell,armada-3700-spi"
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- interrupts: The interrupt number. The interrupt specifier format depends on
+	      the interrupt controller and of its driver.
+- clocks: Must contain the clock source, usually from the North Bridge clocks.
+- num-cs: The number of chip selects that is supported by this SPI Controller
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+Example:
+
+	spi0: spi@10600 {
+		compatible = "marvell,armada-3700-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x10600 0x5d>;
+		clocks = <&nb_perih_clk 7>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+		num-cs = <4>;
+	};
-- 
2.9.3
