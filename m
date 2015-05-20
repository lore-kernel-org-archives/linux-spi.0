From: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
Subject: [RFC PATCH 1/2] devicetree: Add devicetree bindings documentation for
 ZynqMP GQSPI
Date: Wed, 20 May 2015 12:57:50 +0530
Message-ID: <1432106871-27232-1-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, harinik@xilinx.com, Ranjit
 Waghmode <ranjit.waghmode@xilinx.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, punnaia@xilinx.com, ran27jit@gmail.com,
 linux-arm-kernel@lists.infradead.org
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
 <michal.simek@xilinx.com>, <soren.brinkmann@xilinx.com>, <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

Add bindings documentation for GQSPI controller driver used by
Zynq Ultrascale+ MPSoC

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
 .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
new file mode 100644
index 0000000..cec6330
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
@@ -0,0 +1,26 @@
+Xilinx Zynq UltraScale+ MPSoC GQSPI controller Device Tree Bindings
+-------------------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,zynqmp-qspi-1.0".
+- reg			: Physical base address and size of GQSPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller.
+- clock-names		: List of input clock names - "ref_clk", "pclk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+
+Optional properties:
+- num-cs		: Number of chip selects used.
+
+Example:
+	qspi: spi@ff0f0000 {
+		compatible = "xlnx,zynqmp-qspi-1.0";
+		clock-names = "ref_clk", "pclk";
+		clocks = <&misc_clk &misc_clk>;
+		interrupts = <0 15 4>;
+		interrupt-parent = <&gic>;
+		num-cs = <1>;
+		reg = <0x0 0xff0f0000 0x1000 0x0 0xc0000000 0x8000000>;
+	};
--
2.1.2
